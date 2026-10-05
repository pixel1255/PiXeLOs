{ modulesPath, pkgs, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  networking.hostName = "pixel-mini-a";
  networking.networkmanager.enable = false;
  networking.useDHCP = true;
  networking.firewall.enable = false;

  # NORMALE VM-BOOT-INFRASTRUKTUR
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/vda2";
    fsType = "vfat";
  };

  hardware.graphics.enable = true;
  services.spice-vdagentd.enable = true;

  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.displayManager.autoLogin = {
    enable = true;
    user = "pixel1255";
  };
  services.desktopManager.plasma6.enable = true;

  users.users.pixel1255 = {
    isNormalUser = true;
    description = "Mini-A Wächter";
    home = "/home/pixel1255";
    createHome = true;
    extraGroups = [ "wheel" "video" "audio" ];
  };

  environment.systemPackages = with pkgs; [
    firefox-beta
    coreutils
    xclip
  ];

  system.stateVersion = "26.11";
}
