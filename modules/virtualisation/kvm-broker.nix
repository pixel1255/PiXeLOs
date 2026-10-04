{ config, pkgs, miniA, miniB, ... }:
{
  virtualisation.libvirtd.enable = true;

  # Mini-A: Whitelist-Wächter mit Pop-up-Schnittstelle
  systemd.services."kvm-mini-a" = {
    description = "KVM Kapsel: Mini-A (Whitelist-Wächter) — Rein lesendes Audit";
    after = [ "libvirtd.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.qemu}/bin/qemu-system-x86_64 -enable-kvm -cpu host -smp 1 -m 2048 -name mini-a -display none -nic none -device virtio-serial -chardev spicevmc,id=vdagent,debug=0,name=vdagent -device virtserialport,chardev=vdagent,name=com.redhat.spice.0 -kernel ${miniA.config.system.build.kernel}/bzImage -initrd ${miniA.config.system.build.initialRamdisk}/initrd -append \"root=/dev/vda rw init=${miniA.config.system.build.toplevel}/init systemConfig=${miniA.config.system.build.toplevel}\" -drive file=/dev/disk/by-uuid/702c15a3-743d-4630-88a2-52fd6ec44e3d,format=raw,if=virtio,aio=native,cache=none -device vhost-vsock-pci,guest-cid=3 -vga qxl -spice unix=on,addr=/tmp/vm_mini_a.socket,disable-ticketing=on";
      Restart = "no"; User = "pixel1255"; SupplementaryGroups = [ "disk" "kvm" ];
    };
  };

  # Mini-B: USB-Snooper mit Pop-up-Schnittstelle (iPhone-Passthrough)
  systemd.services."kvm-mini-b" = {
    description = "KVM Kapsel: Mini-B (USB-Snooper) — Exklusives iPhone-Passthrough";
    after = [ "libvirtd.service" ];
    serviceConfig = {
ExecStart = "${pkgs.qemu}/bin/qemu-system-x86_64 -enable-kvm -cpu host -smp 1 -m 2048 -name mini-b -display none -nic none -device virtio-serial -chardev spicevmc,id=vdagent,debug=0,name=vdagent -device virtserialport,chardev=vdagent,name=com.redhat.spice.0 -kernel ${miniB.config.system.build.kernel}/bzImage -initrd ${miniB.config.system.build.initialRamdisk}/initrd -append \"root=/dev/vda rw init=${miniB.config.system.build.toplevel}/init systemConfig=${miniB.config.system.build.toplevel}\" -drive file=/dev/sdb2,format=raw,if=virtio,aio=native,cache=none -device vhost-vsock-pci,guest-cid=4 -vga qxl -spice unix=on,addr=/tmp/vm_mini_b.socket,disable-ticketing=on";
      Restart = "no"; User = "pixel1255"; SupplementaryGroups = [ "disk" "kvm" ];
    };
  };

  # Mini-C: Test-Lab / Hotspot-Sender (CID 5) mit Pop-up-Schnittstelle
  systemd.services."kvm-mini-c" = {
    description = "KVM Kapsel: Mini-C (Test-Lab) — Tief verwobene Experimentier-Kapsel";
    after = [ "libvirtd.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.qemu}/bin/qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 4096 -name mini-c -drive file=/dev/sdb3,format=raw,if=virtio,aio=native,cache=none -device vhost-vsock-pci,guest-cid=5 -vga qxl -spice unix=on,addr=/tmp/vm_mini_c.socket,disable-ticketing=on";
      Restart = "no"; User = "root";
    };
  };
}
