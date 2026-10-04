{ modulesPath, pkgs, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  networking.hostName = "pixel-mini-b";
  networking.networkmanager.enable = false;
  networking.useDHCP = false;
  networking.firewall.enable = true;
  services.openssh.enable = false;

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = false;

  boot.kernelParams = [ "root=/dev/vda" ];
  fileSystems."/" = {
    device = "/dev/vda";
    fsType = "ext4";
  };

  hardware.graphics.enable = true;

  i18n.defaultLocale = "de_DE.UTF-8";
  console.keyMap = "de";
  services.xserver.xkb.layout = "de";
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "qxl" ];
  services.xserver.moduleSection = ''
    Load "vgahw"
  '';
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = false;
  };
  services.displayManager.defaultSession = "plasmax11";
  services.displayManager.autoLogin = {
    enable = true;
    user = "pixel1255";
  };
  services.desktopManager.plasma6.enable = true;
  services.spice-vdagentd.enable = true;
  # FORENSISCHE TOOLCHAIN: Ermöglicht iPhone-Kommunikation im Luftspalt
  services.usbmuxd.enable = true;
  environment.systemPackages = with pkgs; [ libimobiledevice ifuse ];

  users.users.pixel1255 = {
    isNormalUser = true;
    description = "Mini-B — iPhone-Snooper";
    home = "/home/pixel1255";
    createHome = true;
  };

  system.stateVersion = "26.11";
}
