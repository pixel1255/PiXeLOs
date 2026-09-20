# ==============================================================================
# MODULES/USERS/PACKAGES.NIX — DEKLARATIVE SYSTEMWEITE PAKETLISTE
# Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)
# ==============================================================================
{ pkgs, ... }: # Standard-Funktionskopf mit Zugriff auf den vollständigen Paketbaum von Nixpkgs

{
  environment.systemPackages = with pkgs; [
    # --- KI-Assistenten-Infrastruktur ---
    nodejs_22 # UPGRADE: Sichere Node.js 22 LTS-Laufzeitumgebung (npm ist hier integriert)

    # --- KDE Plasma 6 Core Apps & Utilities ---
    kdePackages.dolphin 
    kdePackages.konsole 
    kdePackages.kate 
    kdePackages.spectacle 
    kdePackages.ark 
    kdePackages.gwenview 
    kdePackages.okular 
    kdePackages.partitionmanager 
    kdePackages.kcalc 
    kdePackages.plasma-systemmonitor 
    kdePackages.kio-extras 

    # --- Spezialisierte Anwendungen & Multimedia ---
    obsidian 
    easyeffects 

    # --- Apple iOS & iPhone Integration ---
    libimobiledevice 
    ifuse 

    # --- Hardware-Analyse & USB-Werkzeuge ---
    usbutils 
    usb-modeswitch 
    alsa-utils 

    # --- Core Editoren (Kommandozeile) ---
    nano 
    vim 

    # --- Netzwerk & Datenübertragung ---
    curl 
    wget 

    # --- Strukturierte Datenverarbeitung & Filter ---
    jq 
    tree 
    ripgrep 
    fd 
    fzf 

    # --- Archivierungswerkzeuge ---
    unzip 
    zip 
    p7zip 

    # --- System-Diagnose & Ablaufverfolgung ---
    file 
    lsof 
    strace 

    # --- System-Monitoring (Live-Ansicht) ---
    htop 
    btop 
    fastfetch 

    # --- Physische Hardware-Auslesung ---
    pciutils 
    lm_sensors 
    smartmontools 

    # --- Datei- und Binäroptimierung ---
    rsync 
    hexyl 
    exiftool 
    binutils 
    less 

    # --- Entwicklung & Versionsverwaltung ---
    git 
    python3 
  ];
}
