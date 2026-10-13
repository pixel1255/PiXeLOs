## ==============================================================================
## MODULES/SYSTEM/NIX-SETTINGS.NIX — NIX-DAEMON GLOBAL FLAGS & OPTIMIERUNGEN
## Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)
## ==============================================================================
{ ... }: # Leerer Funktionskopf, da hier nur native Nix-Einstellungen vorgenommen werden
{
  nixpkgs.config.allowUnfree = true; # Erlaubt global das Installieren proprietärer Software (wie Intel-Firmware oder Obsidian)

  nix = { # Konfigurationsblock für den internen Nix-Paketmanager-Daemon
    settings = { # Feineinstellungen des Daemons zur Steuerung von Compilern und Isolation
      experimental-features = [ # Aktiviert moderne Nix-Funktionen, die für dieses Repository zwingend erforderlich sind
        "nix-command" # Ermöglicht die Nutzung der neuen, modernen 'nix'-Subbefehle im Terminal
        "flakes" # Aktiviert die Flake-Infrastruktur inklusive Isolation und flake.lock-Pinning
      ];
      auto-optimise-store = true; # Erkennt identische Dateien im Nix-Store und ersetzt sie durch Hardlinks zur Platzersparnis
      sandbox = true; # HÄRTUNG GATE 13: Erzwingt die absolute, isolierte Compiler-Sandbox im Kernel gegen Host-Zugriffe
      sandbox-paths = [ "/dev/kvm" ]; # Erlaubt Sandbox-Prozessen den sicheren Zugriff auf das KVM-Gerät für Hardware-Virtualisierung
      trusted-users = [ # Definiert Benutzerkonten, die erweiterte Befehle an den Nix-Daemon senden dürfen
        "root" # Der Systemadministrator hat volles Vertrauen für erweiterte Daemon-Operationen
      ];
    };

    gc = { # Automatische Müllabfuhr (Garbage Collection) für den Nix-Store, um Altlasten loszuwerden
      automatic = true; # Schaltet die automatische Bereinigung des gesamten Systems permanent ein
      dates = "weekly"; # Der Aufräumprozess wird einmal wöchentlich systemd-gesteuert im Hintergrund ausgeführt
      options = "--delete-older-than 14d"; # Löscht alle ungenutzten Systemgenerationen und Pakete, die älter als 14 Tage sind
    };
  };

  zramSwap.enable = true; # Aktiviert ZRAM (erzeugt ein komprimiertes Swap-Laufwerk direkt im RAM; schont die Intel-SSD)
}
