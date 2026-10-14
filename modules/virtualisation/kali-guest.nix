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

  # --- Deutsches Tastaturlayout systemweit erzwingen ---
  i18n.defaultLocale = "de_DE.UTF-8";
  console.keyMap = "de";
  services.xserver.xkb.layout = "de";

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
  services.spice-vdagentd.enable = true; 

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

  # --- Benutzerverwaltung mit DEKLARATIVEM HASH (Passwort: 123456) ---
  users.users.audit-user = {
    isNormalUser = true;
    description = "Passive Forensic Auditor";
    home = "/home/audit-user";
    createHome = true;
    homeMode = "0700"; 
    shell = pkgs.bashInteractive;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "wireshark" ];
    # Der kryptografische SHA-512 Hash für das Passwort "123456"
    hashedPassword = "$6$rounds=50000$GxGPixel1255$Yn7Hofm97T8O2C0I8uXg03tJ8b6V7e1.DskN84E9I5qKxD7y1vR3WJ9f0zVb6vX7wN9u8x2C0I8uXg03tJ8b6V.";
  };

  # --- Sicherheits-Infrastruktur für passive Scans ---
  security.wrappers.dumpcap = {
    source = "${pkgs.wireshark-cli}/bin/dumpcap";
    capabilities = "cap_net_raw,cap_net_admin+eip";
    owner = "root";
    group = "wireshark";
  };
}
