{ config, pkgs, lib, ... }: { # Hauptfunktion für den Zugriff auf System-Hardware, Pakete und Bibliotheken[cite: 18].

  imports = [ # Import-Block für spezialisierte Module; trennt Logik von Hardware[cite: 19, 63].
    ./hardware-configuration.nix # Physische Definitionen und Partitionen[cite: 20].
    ./modules/boot.nix           # Steuerung des Bootloaders und Kernel-Parameter[cite: 20].
    ./modules/desktop.nix        # Grafische Oberfläche (KDE Plasma 6)[cite: 21, 1].
    ./modules/hardware.nix       # Eingabegeräte und Apple-Support (usbmuxd)[cite: 22, 6].
    ./modules/performance.nix    # RAM-Management und System-Optimierung[cite: 23, 7].
    ./modules/security.nix       # Lean Guardian (Event-basierte Überwachung)[cite: 24, 14].
  ];

  # --- Netzwerk & System-Basis ---
  networking.hostName = "PiXeL1255"; # Eindeutiger Netzwerkname des Rechners[cite: 25].
  system.stateVersion = "24.11";    # Software-Stand der Erstinstallation[cite: 26].

  # --- Hardware-Optimierung (Intel & Apple Fokus) ---
  hardware.graphics.enable = true; # Aktiviert Hardware-Beschleunigung[cite: 2, 27].
  hardware.cpu.intel.updateMicrocode = true; # Kritische Sicherheits-Patches für Intel[cite: 27].
  services.usbmuxd.enable = true; # Kommunikation mit iOS-Geräten via USB[cite: 28, 6].

  # --- User-Setup: Der Architect ---
  users.users.pixel1255 = { # Dein persönliches Benutzerprofil[cite: 29].
    isNormalUser = true; # Regulärer Account für den täglichen Gebrauch[cite: 30].
    description = "Andreas Weidenbach | PiXeLOs Architekt"; # Name und Titel im System-Logbuch[cite: 30, 31].
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "docker" "libvirtd" ]; # Admin- und Multimedia-Rechte[cite: 32].
    shell = pkgs.bash; # Standard-Shell für das Terminal[cite: 33].
  };

  # --- Nix-Paketmanager Einstellungen ---
  nix.settings = { # Konfiguriert das Verhalten des Paketmanagers[cite: 34].
    experimental-features = [ "nix-command" "flakes" ]; # Aktiviert moderne Flake-Befehle[cite: 35].
    auto-optimise-store = true; # Verhindert Speicherplatz-Verschwendung durch Hardlinks[cite: 35, 36].
  };

  nixpkgs.config.allowUnfree = true; # Erlaubt Software mit proprietären Lizenzen[cite: 37].

  # --- System-Werkzeuge (Die Werkzeugkiste) ---
  environment.systemPackages = with pkgs; [ # Installierte Pakete für Terminal und Desktop[cite: 38].
    firefox kdePackages.kate kitty git btop python3 fzf zoxide eza bat ripgrep tree pciutils usbutils
    inotify-tools libnotify bc gawk # Notwendig für Guardian-Services und RAM-Scripts[cite: 11, 17, 39].
  ];

  # --- Terminal-Branding & Interaktive Funktionen ---
  programs.bash.interactiveShellInit = '' # Wird bei jedem Terminal-Start ausgeführt[cite: 40].
    info-os() { # Funktion für Logo und System-Status[cite: 41].
      echo -e "\e[1;33m" # Gelbe Farbe für das Branding[cite: 42].
      cat << "LOGO"
 ██████╗  ██████╗  ██████╗ ██╗██╗  ██╗███████╗██╗          ██╗██████╗ ███████╗███████╗
 ██╔═══██╗██╔═══██╗██╔══██╗██║╚██╗██╔╝██╔════╝██║         ███║╚════██╗██╔════╝██╔════╝
 ██║   ██║██║   ██║██████╔╝██║ ╚███╔╝ █████╗  ██║         ╚██║ █████╔╝███████╗███████╗
 ██║   ██║██║   ██║██╔═══╝ ██║ ██╔██╗ ██╔══╝  ██║          ██║██╔═══╝ ╚════██╗╚════██╗
 ╚██████╔╝╚██████╔╝██║     ██║██╔╝ ██╗███████╗███████╗     ██║███████╗███████╗███████╗
  ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝     ╚═╝╚══════╝╚══════╝╚══════╝

                 >>>  C R E A T E D   B Y   G X G  <<<
LOGO
      echo -e "\e[0m" # Farbe zurücksetzen[cite: 46].
      echo -e "\e[1;33mVerfügbare Befehle & Aliase:\e[0m"[cite: 47].
      echo -e " \e[1;32mupdate\e[0m     : System-Update & Rebuild (Gold-Modus)"[cite: 48].
      echo -e " \e[1;32mcleanup\e[0m    : Müll löschen, Store optimieren & RAM leeren"[cite: 49].
      echo -e " \e[1;32mls / ll\e[0m    : Modernes Listing (eza) mit Icons"[cite: 50].
      echo -e " \e[1;32mtree\e[0m       : Verzeichnisstruktur als Baum anzeigen"[cite: 51].
      echo -e "\n\e[1;34mSystem:\e[0m PiXeL1255CreatedOs - Pure Architect Edition"[cite: 52].
    }
    info-os # Logo beim Start anzeigen[cite: 53].
    eval "$(zoxide init bash)" # Schnelle Verzeichnis-Navigation[cite: 54].
  '';

  # --- Aliase für Effizienz ---
  programs.bash.shellAliases = { # Abkürzungen für komplexe Abläufe[cite: 55].
    update = "sudo nixos-rebuild switch --flake /etc/nixos/#PiXeL1255"; # Gold-Update via Flake[cite: 57, 58].
    cleanup = "sudo sync; echo 3 | sudo tee /proc/sys/vm/drop_caches && nix-collect-garbage -d"; # Tiefenreinigung[cite: 59, 60].
    ll = "eza -l --icons"; # Detail-Liste[cite: 61].
    ls = "eza --icons"; # Schnelle Übersicht[cite: 62].
  };

  /* * 📜 ARCHITEKTEN-NOTIZ:
   * Die configuration.nix ist das neuronale Netzwerk von PiXeLOs[cite: 63].
   * Sie verbindet Hardware-Module, User-Präferenzen und System-Branding[cite: 63].
   * Modularität durch Imports macht das System wartbar und skalierbar[cite: 63, 64].
   * Aliase wie 'cleanup' und 'update' automatisieren die Pflege des Maschinenraums[cite: 64, 65].
   */
}
