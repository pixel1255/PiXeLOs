{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix

    ../modules/system/boot.nix
    ../modules/system/locale.nix
    ../modules/system/nix-settings.nix

    ../modules/hardware/graphics.nix
    ../modules/hardware/bluetooth.nix
    ../modules/hardware/usb-devices.nix

    ../modules/desktop/plasma.nix
    ../modules/desktop/audio.nix

    ../modules/network/network.nix
    ../modules/security/hardening.nix

    ../modules/users/pixel1255.nix
    ../modules/users/packages.nix
  ];

  fileSystems."/mnt/Ablage" = {
    device = "/dev/disk/by-uuid/9ceeac28-81cc-461e-928a-a4064ff0f8c8";
    fsType = "ext4";
    options = [
      "nofail"
      "x-systemd.device-timeout=5s"
    ];
  };

  system.stateVersion = "24.11";
}
