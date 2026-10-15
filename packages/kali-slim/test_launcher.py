"""Behaviour tests with mocked QEMU/KVM; no real VM or disk image is used."""
# Co-Created by Pixel1255, Anti-Gravity Gemini & ChatGPT (GxG-Prozess)
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile
import unittest

SOURCE = Path(sys.argv.pop(1)).resolve()


class LauncherTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="kali-slim-test-")
        self.root = Path(self.temp.name)
        self.home = self.root / "home,with-comma"
        self.home.mkdir()
        self.bin = self.root / "bin"
        self.bin.mkdir()
        self.args_file = self.root / "qemu-args.json"
        self.disk = self.home / "kali-audit-lab/kali-slim/disk.qcow2"
        self.iso = self.root / "fixture.iso"
        self.iso.write_bytes(b"test fixture, not a bootable image")
        expected = hashlib.sha256(self.iso.read_bytes()).hexdigest()
        text = SOURCE.read_text()
        kvm_boundary = '''require_kvm() {
  [[ -r /dev/kvm && -w /dev/kvm ]] || fail 'Kein Lese-/Schreibzugriff auf /dev/kvm; Rechte zuerst pruefen.'
}'''
        self.assertEqual(text.count(kvm_boundary), 1)
        # Hardware access is replaced. If this test environment only maps UID 0,
        # replace the root boundary in the TEST COPY; test the original separately.
        text = text.replace(kvm_boundary, "require_kvm() { :; }")
        prefix = f"VM_RAM_MIB=4096\nVM_CPUS=2\nVM_DISK_GIB=30\nISO_SHA256={expected}\n"
        self.original = self.root / "original.sh"
        self.original.write_text(prefix + SOURCE.read_text())
        if os.geteuid() == 0:
            root_boundary = "[[ $EUID -ne 0 ]] || fail 'Als normaler Benutzer starten, ohne sudo.'"
            self.assertEqual(text.count(root_boundary), 1)
            text = text.replace(root_boundary, ": # root boundary mocked in test copy only")
        self.launcher = self.root / "launcher.sh"
        self.launcher.write_text(prefix + text)
        self.env = dict(os.environ, HOME=str(self.home),
                        PATH=str(self.bin) + os.pathsep + os.environ["PATH"],
                        MOCK_QEMU_ARGS=str(self.args_file))
        self.mock("qemu-system-x86_64", '''import json, os, sys
from pathlib import Path
Path(os.environ["MOCK_QEMU_ARGS"]).write_text(json.dumps(sys.argv[1:]))
''')
        self.mock("qemu-img", '''import json, os, sys
from pathlib import Path
if sys.argv[1] == "create":
    Path(sys.argv[-2]).write_bytes(b"existing data must survive")
elif sys.argv[1] == "info":
    print(json.dumps({"format": "qcow2", "virtual-size": 30 * 1024**3,
                     **({"backing-filename": "other.qcow2"} if os.environ.get("MOCK_BACKING") else {})}))
else:
    raise SystemExit(2)
''')

    def tearDown(self):
        self.temp.cleanup()

    def mock(self, name, body):
        path = self.bin / name
        path.write_text(f"#!{sys.executable}\n" + body)
        path.chmod(0o755)

    def invoke(self, *args):
        return subprocess.run([shutil.which("bash"), str(self.launcher), *map(str, args)],
                              env=self.env, text=True, capture_output=True)

    def init(self):
        result = self.invoke("init")
        self.assertEqual(result.returncode, 0, result.stderr)

    def qemu_args(self):
        return json.loads(self.args_file.read_text())

    def test_readonly_commands_do_not_create_directories(self):
        for action in ("help", "status", "check"):
            result = self.invoke(action)
            self.assertEqual(result.returncode, 0, result.stderr)
        self.assertFalse(self.disk.parent.exists())
        self.assertFalse(self.args_file.exists())

    def test_init_never_overwrites_existing_disk(self):
        self.init()
        before = self.disk.read_bytes()
        self.assertNotEqual(self.invoke("init").returncode, 0)
        self.assertEqual(self.disk.read_bytes(), before)

    def test_missing_disk_does_not_start_qemu(self):
        self.assertNotEqual(self.invoke("boot").returncode, 0)
        self.assertFalse(self.args_file.exists())

    def test_offline_boot_uses_requested_resources_and_only_new_disk(self):
        self.init()
        result = self.invoke("boot")
        self.assertEqual(result.returncode, 0, result.stderr)
        args = self.qemu_args()
        self.assertEqual(args[args.index("-m") + 1], "4096")
        self.assertEqual(args[args.index("-smp") + 1], "2")
        self.assertEqual(args[args.index("-nic") + 1], "none")
        drives = [args[i + 1] for i, value in enumerate(args) if value == "-drive"]
        self.assertEqual(len(drives), 1)
        self.assertEqual(drives[0], "file=" + str(self.disk).replace(",", ",,") + ",format=qcow2,if=virtio")
        for forbidden in ("-virtfs", "-fsdev", "-cdrom", "-hda", "-hdb"):
            self.assertNotIn(forbidden, args)

    def test_online_requires_explicit_mode(self):
        self.init()
        result = self.invoke("boot-online")
        self.assertEqual(result.returncode, 0, result.stderr)
        args = self.qemu_args()
        self.assertEqual(args[args.index("-nic") + 1], "user,model=virtio-net-pci")

    def test_wrong_installer_cannot_start(self):
        self.init()
        self.iso.write_bytes(b"downloaded HTML page")
        self.assertNotEqual(self.invoke("install", self.iso).returncode, 0)
        self.assertFalse(self.args_file.exists())

    def test_validated_installer_is_readonly_and_reboot_exits(self):
        self.init()
        result = self.invoke("install", self.iso)
        self.assertEqual(result.returncode, 0, result.stderr)
        args = self.qemu_args()
        self.assertIn("-no-reboot", args)
        self.assertIn("file=" + str(self.iso) + ",media=cdrom,readonly=on", args)
        self.assertEqual(args[args.index("-nic") + 1], "user,model=virtio-net-pci")

    def test_backing_chain_is_refused(self):
        self.init()
        self.env["MOCK_BACKING"] = "1"
        self.assertNotEqual(self.invoke("boot").returncode, 0)
        self.assertFalse(self.args_file.exists())

    def test_symlink_disk_is_refused(self):
        self.disk.parent.mkdir(parents=True)
        target = self.root / "unrelated-file"
        target.write_text("keep me")
        self.disk.symlink_to(target)
        self.assertNotEqual(self.invoke("init").returncode, 0)
        self.assertEqual(target.read_text(), "keep me")

    @unittest.skipUnless(os.geteuid() == 0, "Root guard requires a UID-0 test environment")
    def test_original_refuses_root(self):
        result = subprocess.run([shutil.which("bash"), str(self.original), "init"],
                                env=self.env, text=True, capture_output=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn("ohne sudo", result.stderr)
        self.assertFalse(self.disk.parent.exists())


if __name__ == "__main__":
    unittest.main(verbosity=2)
