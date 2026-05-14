{ config, pkgs, lib, ... }: { # Die Funktion erhält Zugriff auf die Systemkonfiguration und die Paketbibliothek.

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest; # Erzwingt die Nutzung des aktuellsten stabilen Kernels, um neueste Hardware-Features und Performance-Patches zu erhalten.

  boot.initrd.includeDefaultModules = false; # Deaktiviert das automatische Laden von Standard-Modulen in der Ramdisk, um den Bootvorgang schlank und kontrolliert zu halten.

  boot.initrd.availableKernelModules = [ # Definiert die exakten Treiber, die zum Einhängen des Dateisystems beim Start zwingend vorhanden sein müssen.
    "virtio_pci" "virtio_blk" "virtio_gpu" "virtio_net" # Optimierte Treiber für virtualisierte Hardware (Virtualisierungs-Support).
    "9p" "9pnet_virtio" # Ermöglicht den schnellen Dateiaustausch zwischen Host und Gastsystemen.
    "ext4" # Stellt sicher, dass das Linux-Standarddateisystem EXT4 sofort gelesen werden kann.
    "xhci_pci" "ahci" "usbhid" # Aktiviert USB 3.0, SATA-Festplatten-Controller und Eingabegeräte (Tastatur/Maus) für die frühe Bootphase.
  ];

  boot.loader.systemd-boot.enable = true; # Aktiviert den modernen systemd-boot Loader, der schnell und perfekt in das restliche System integriert ist.

  boot.loader.efi.canTouchEfiVariables = true; # Erlaubt NixOS, die EFI-Variablen des Mainboards direkt zu verwalten (notwendig für Boot-Einträge).

  boot.kernelParams = [ # Übergibt dem Kernel beim Start spezifische Anweisungen zur Optimierung.
    "quiet" # Reduziert die Textausgabe beim Booten für ein sauberes, professionelles Startbild.
    "loglevel=3" # Begrenzt die Fehlermeldungen auf das Wesentliche, um die Übersicht im Log zu behalten.
    "mitigations=off" # Deaktiviert Software-Bremsen gegen CPU-Sicherheitslücken (wie Spectre), um die volle Rechenleistung deiner Hardware freizuschalten.
  ];
}

/* * 📜 ARCHITEKTEN-NOTIZ FÜR DIE COMMUNITY:
 * ----------------------------------------
 * Die boot.nix ist das Fundament der System-Stabilität. Sie kontrolliert
 * den Übergang von der Hardware (Firmware) zur Software (Kernel).
 *
 * 🚀 PERFORMANCE-FOKUS:
 * Durch 'mitigations=off' und den neuesten Kernel wird die maximale
 * Geschwindigkeit aus dem Prozessor herausgeholt – ideal für Power-User.
 *
 * 🏗️ VIRTUALISIERUNGS-READY:
 * Die Einbindung der virtio-Module zeigt, dass PiXeLOs darauf vorbereitet
 * ist, hocheffizient in oder als virtuelle Maschine zu laufen.
 *
 * 🛠️ SCHLANKER START:
 * Durch das Deaktivieren der Default-Module ('includeDefaultModules = false')
 * ist die Initrd hochgradig optimiert und enthält nur das Nötigste.
 */
