{ config, pkgs, miniA, miniB, miniC, ... }:
{
  virtualisation.libvirtd.enable = true;

  # Mini-A: Whitelist-Wächter mit Pop-up-Schnittstelle
  systemd.services."kvm-mini-a" = {
    description = "KVM Kapsel: Mini-A (Whitelist-Wächter) — Rein lesendes Audit";
    after = [ "libvirtd.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.qemu}/bin/qemu-system-x86_64 -enable-kvm -cpu host -smp 1 -m 2048 -name mini-a -display none -nic user,model=virtio,mac=52:54:00:12:34:56 -device usb-ehci,id=usb -device virtio-serial -chardev spicevmc,id=vdagent,debug=0,name=vdagent -device virtserialport,chardev=vdagent,name=com.redhat.spice.0 -drive file=/dev/sdb1,format=raw,if=virtio,aio=native,cache=none -device vhost-vsock-pci,guest-cid=3 -vga qxl -spice unix=on,addr=/tmp/vm_mini_a.socket,disable-ticketing=on";
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
      ExecStart = "${pkgs.qemu}/bin/qemu-system-x86_64 -enable-kvm -cpu host -smp 2 -m 4096 -name mini-c -display none -nic none -device virtio-serial -chardev spicevmc,id=vdagent,debug=0,name=vdagent -device virtserialport,chardev=vdagent,name=com.redhat.spice.0 -kernel ${miniC.config.system.build.kernel}/bzImage -initrd ${miniC.config.system.build.initialRamdisk}/initrd -append \"root=/dev/vda rw init=${miniC.config.system.build.toplevel}/init systemConfig=${miniC.config.system.build.toplevel}\" -drive file=/dev/sdb3,format=raw,if=virtio,aio=native,cache=none -device vhost-vsock-pci,guest-cid=5 -spice unix=on,addr=/tmp/vm_mini_c.socket,disable-ticketing=on";
      Restart = "no"; User = "root"; SupplementaryGroups = [ "disk" "kvm" ];
    };
  };
}