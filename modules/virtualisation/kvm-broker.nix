{ config, pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;

  # Mini-A: Nur deklarieren, NICHT automatisch starten
  systemd.services."kvm-mini-a" = {
    description = "KVM Kapsel: Mini-A (Whitelist-Wächter) — Rein lesendes Audit";
    after = [ "libvirtd.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.qemu}/bin/qemu-system-x86_64 -enable-kvm -cpu host -smp 1 -m 2048 -name mini-a -drive file=/dev/sdb1,format=raw,if=virtio,aio=native,cache=none -device vhost-vsock-pci,guest-cid=3 -nographic -monitor none";
      Restart = "no"; User = "pixel1255"; SupplementaryGroups = [ "disk" ];
    };
  };

  # Mini-B: Nur deklarieren, KEIN automatischer Start (verhindert iPhone-Netzabsturz!)
  systemd.services."kvm-mini-b" = {
    description = "KVM Kapsel: Mini-B (USB-Snooper) — Exklusives iPhone-Passthrough";
    after = [ "libvirtd.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.qemu}/bin/qemu-system-x86_64 -enable-kvm -cpu host -smp 1 -m 2048 -name mini-b -drive file=/dev/sdb2,format=raw,if=virtio,aio=native,cache=none -device vhost-vsock-pci,guest-cid=4 -device usb-ehci,id=usb -device usb-host,vendorid=0x05ac,productid=0x12a8 -nographic -monitor none";
      Restart = "no"; User = "pixel1255"; SupplementaryGroups = [ "disk" ];
    };
  };

  # Mini-C: Nur deklarieren, NICHT automatisch starten
  systemd.services."kvm-mini-c" = {
    description = "KVM Kapsel: Mini-C (Test-Lab) — Tief verwobene Experimentier-Kapsel";
    after = [ "libvirtd.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.qemu}/bin/qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 4096 -name mini-c -drive file=/dev/sdb3,format=raw,if=virtio,aio=native,cache=none -device vhost-vsock-pci,guest-cid=5 -nographic -monitor none";
      Restart = "no"; User = "root";
    };
  };
}
