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
  system.stateVersion = "24.11"; # Synchronisiert mit dem stabilen Host-Zustand

  # --- Bootvorgang für virtuelle Umgebungen ---
  boot.loader.grub = {
    enable = true;
    device = "/dev/vda"; # VirtIO-Standardlaufwerk für maximale KVM-Geschwindigkeit
  };

  # --- Standard VirtIO-Dateisystem für KVM-Gäste ---
  fileSystems."/" = {
    device = "/dev/vda";
    fsType = "ext4";
  };

  # --- Spice & QEMU Guest Integration (Für verzögerungsfreie Desktop-Kopplung) ---
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true; # Erlaubt kontrolliertes Copy-Paste zum Mittleren Monitor

  # --- Die exakte, schlanke Audit-Toolbox (Strikt Passiv & Forensisch) ---
  environment.systemPackages = with pkgs; [
    wireshark           # Grafische Netzwerk-Sonde für tiefe Paketanalysen (Unstable-Name gefixt!)
    tshark              # CLI-Netzwerk-Sniffer für die automatisierte Überwachung
    nmap                # Port-Scanner für passive OS- und Versions-Scans (-sV, -O)
    testssl             # Zertifikats- und Protokoll-Prüfer für TLS-Audits
    kdePackages.kate    # Editor für Skript-Strukturierungen (Plasma 6 Namensgatter gefixt!)
    chromium            # Isoliertes Chrome-Gatter für Gegenprüfungen
    obsidian            # Deine lokale Wissensdatenbank für die Vorfall-Dokumentation
  ];

  # --- Gehärteter Firefox-Beta für die Kapsel ---
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta; # Identisch zum gehärteten Host-Browser
  };

  # --- Benutzerverwaltung ohne Konflikte (Mensch bleibt ROOT) ---
  users.users.audit-user = {
    isNormalUser = true;
    initialPassword = "pixel";
    description = "Passive Forensic Auditor";
    home = "/home/audit-user";
    createHome = true;
    homeMode = "0700"; # Strikte F02-Isolierung des Benutzer-Verzeichnisses
    shell = pkgs.bashInteractive;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "wireshark" ]; # Wireshark ohne Root-Zwang!
  };

  # --- Sicherheits-Infrastruktur für passive Scans ---
  security.wrappers.dumpcap = {
    source = "${pkgs.wireshark-cli}/bin/dumpcap";
    capabilities = "cap_net_raw,cap_net_admin+eip";
    owner = "root";
    group = "wireshark";
  };
}
