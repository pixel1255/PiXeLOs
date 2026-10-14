## ==============================================================================
## MODULES/VIRTUALISATION/KALI-GUEST.NIX — DIE FORENSIK-KAPSEL (MASTER INTEGRATION)
## Co-Created by Pixel1255 & Anti-Gravity Gemini (GxG-Prozess)
## ==============================================================================
{ config, pkgs, lib, ... }:

{
  imports = [
    ../system/locale.nix        # Erbt die Systemsprache des Hosts
    ../system/nix-settings.nix  # Erbt die gehärteten Daemon-Schranken
    ../desktop/audio.nix        # Kapselt das PipeWire-Soundsystem für Audio-Analysen
    ../desktop/plasma.nix       # Importiert die Plasma-Struktur
  ];

  networking.hostName = "pixel-lab-kali-audit";
  system.stateVersion = "24.11"; 

  console.keyMap = lib.mkForce "de-latin1";
  services.xserver.xkb.layout = lib.mkForce "de";

  boot.loader.grub = {
    enable = true;
    device = "/dev/vda"; 
  };

  fileSystems."/" = {
    device = "/dev/vda";
    fsType = "ext4";
  };

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true; 
  services.displayManager.defaultSession = lib.mkForce "plasmax11";

  environment.systemPackages = with pkgs; [
    wireshark tshark nmap testssl kdePackages.kate chromium obsidian
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
  };

  users.users.audit-user = {
    isNormalUser = true;
    uid = 1255;
    description = "Passive Forensic Auditor";
    home = "/home/audit-user";
    createHome = true;
    homeMode = "0700"; 
    shell = pkgs.bashInteractive;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "wireshark" ];
  };

  security.wrappers.dumpcap = {
    source = "${pkgs.wireshark-cli}/bin/dumpcap";
    capabilities = "cap_net_raw,cap_net_admin+eip";
    owner = "root";
    group = "wireshark";
  };
}
