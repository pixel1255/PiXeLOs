# ==============================================================================
# MODULES/VIRTUALISATION/HOTSPOT-GUEST.NIX — DIE ISOLIERTE APPLIANCE (GAST)
# Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)
# ==============================================================================
{ config, pkgs, lib, ... }:

{
  imports = [
    ../system/locale.nix
    ../system/nix-settings.nix
    ../desktop/audio.nix
    ../desktop/plasma.nix
    ../users/packages.nix
  ];

  networking.hostName = "pixel-lab-hotspot-guest";
  system.stateVersion = "24.11";

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda";
  };
  
  boot.initrd.availableKernelModules = [ "virtio_pci" "virtio_scsi" "virtio_blk" "9p" "9pnet_virtio" ];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  networking.networkmanager.enable = true;
  
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = lib.mkForce 1; 
  };

  users.users.hotspot-user = {
    isNormalUser = true;
    description = "Hotspot Appliance User";
    home = "/home/hotspot-user";
    createHome = true;
    homeMode = "0700";
    shell = pkgs.bashInteractive;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
  };
}
