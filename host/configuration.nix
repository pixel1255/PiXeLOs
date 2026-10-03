# ==============================================================================
# HOST/CONFIGURATION.NIX — DER MODULARE SYSTEM-DIRIGENT (HAUPTKONFIGURATION)
# Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)
# ==============================================================================
{ config, pkgs, lib, ... }: # Standard-Funktionskopf mit Zugriff auf globale Config, Paketbaum und Hilfsfunktionen

{
  imports = [ # Import-Array: Lädt alle spezialisierten Kategorien-Flakes/Module in die Haupt-Closure
    ./hardware-configuration.nix # Bindet die physischen Datenträger-Mounts und Dateisystem-UUIDs ein

    ../modules/system/boot.nix # Lädt die UEFI, systemd-boot und Kernel-Infrastruktur
    ../modules/system/locale.nix # Lädt Tastaturlayouts, Zeitzone und die Sprach-Lokalisierung
    ../modules/system/nix-settings.nix # Lädt globale Nix-Optimierungen, Flake-Flags und die wöchentliche Garbage Collection

    ../modules/hardware/graphics.nix # Lädt den Intel i915 Grafiktreiber und VA-API Videobeschleunigung
    ../modules/hardware/bluetooth.nix # Lädt das BlueZ-Subsystem inklusive automatischem Boot-Power-On
    ../modules/hardware/usb-devices.nix # Lädt usbmuxd2, iPhone-Tethering und die FRITZ!WLAN-Kerneltreiber

    ../modules/desktop/plasma.nix # Lädt den grafischen XServer, SDDM Display Manager und KDE Plasma 6 (Wayland)
    ../modules/desktop/audio.nix # Lädt den RTKit-Echtzeit-Scheduler und PipeWire mit Low-Latency-Audioprofil

    ../modules/network/network.nix # Lädt das NetworkManager-Backend sowie Avahi-mDNS und den CUPS-Druckdienst
    ../modules/security/hardening.nix # Lädt den Sysctl-Kernel-Schutzwall, nftables und die OpenSnitch Application Firewall

    ../modules/users/pixel1255.nix # Lädt die Benutzerdefinition für pixel1255 inklusive Sudo- und Gruppenrechte
    ../modules/users/packages.nix # Lädt die explizite, deklarierte Liste aller installierten CLI- und GUI-Systempakete

    # Pixel-Lab Host-Infrastruktur (Storage, Broker, Hotspot)
    ../modules/host/pixel-lab-storage.nix
    ../modules/virtualisation/kvm-broker.nix
    ../modules/services/local-ai.nix
    ../modules/host/pixel-vm-broker-hotspot.nix
  ];

  fileSystems."/mnt/Ablage" = { # Deklariert den Mountpoint für die interne, sekundäre Datenfestplatte
    device = "/dev/disk/by-uuid/9ceeac28-81cc-461e-928a-a4064ff0f8c8"; # Verweist auf die unveränderliche, physische UUID des ext4-Dateisystems
    fsType = "ext4"; # Definiert das Dateisystem-Format als Standard Linux Extended 4
    options = [ # Array spezifischer Mount-Optionen für systemd
      "nofail" # Verhindert Boot-Abbrüche, falls die Festplatte beim Start physisch nicht erreichbar ist
      "x-systemd.device-timeout=5s" # Begrenzt die Wartezeit beim Booten auf maximal 5 Sekunden, falls die Platte schläft
    ];
  };

  system.stateVersion = "24.11"; # Fixiert den Software-Zustand historischer Standardwerte (wichtig für interne NixOS-Upgrades)
}
