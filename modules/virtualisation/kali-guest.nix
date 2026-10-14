## ==============================================================================
## MODULES/VIRTUALISATION/KALI-GUEST.NIX — DIE ISOLIERTE FORENSIK-KAPSEL (RECHTS)
## Co-Created by Pixel1255 & Anti-Gravity Gemini (GxG-Prozess)
## ==============================================================================
{ config, pkgs, lib, ... }:

{
  imports = [
    ../system/locale.nix        # Erbt die Systemsprache des Hosts
    ../system/nix-settings.nix  # Erbt die gehärteten Daemon-Schranken
    ../desktop/audio.nix        # Kapselt das PipeWire-Soundsystem für Audio-Analysen
    ../desktop/plasma.nix       # Zündet KDE Plasma 6 auf dem rechten Monitor
  ];

  # --- Kapsel-Identität laut Roadmap ---
  networking.hostName = "pixel-lab-kali-audit";
  system.stateVersion = "24.11"; 

  # --- Deutsches Tastaturlayout konfliktfrei erzwingen ---
  console.keyMap = lib.mkForce "de-latin1";
  services.xserver.xkb.layout = lib.mkForce "de";

  # --- Bootvorgang für virtuelle Umgebungen ---
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda"; 
  };

  # --- Standard VirtIO-Dateisystem für KVM-Gäste ---
  fileSystems."/" = {
    device = "/dev/vda";
    fsType = "ext4";
  };

  # --- Spice & QEMU Guest Integration ---
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true; 

  # --- STRATEGIE-HEBEL: Grafischen Login komplett skippen (Auto-Login) ---
  services.displayManager.autoLogin = {
    enable = true;
    user = "audit-user";
  };

  # --- Die exakte, schlanke Audit-Toolbox (Strikt Passiv & Forensisch) ---
  environment.systemPackages = with pkgs; [
    wireshark           # Grafische Netzwerk-Sonde
    tshark              # CLI-Netzwerk-Sniffer
    nmap                # Port-Scanner
    testssl             # TLS-Audits
    kdePackages.kate    # Editor (Plasma 6)
    chromium            # Isoliertes Chrome-Gatter
    obsidian            # Wissensdatenbank
  ];

  # --- Gehärteter Firefox-Beta für die Kapsel ---
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
  };

  # --- Benutzerverwaltung ---
  users.users.audit-user = {
    isNormalUser = true;
    description = "Passive Forensic Auditor";
    home = "/home/audit-user";
    createHome = true;
    homeMode = "0700"; 
    shell = pkgs.bashInteractive;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "wireshark" ];
  };

  # --- Sicherheits-Infrastruktur für passive Scans ---
  security.wrappers.dumpcap = {
    source = "${pkgs.wireshark-cli}/bin/dumpcap";
    capabilities = "cap_net_raw,cap_net_admin+eip";
    owner = "root";
    group = "wireshark";
  };
}
