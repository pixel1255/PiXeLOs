# ==============================================================================
# HOST/HARDWARE-CONFIGURATION.NIX — HARDWARE- UND DATENTRÄGER-BASELINES
# Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)
# ==============================================================================
{ config, lib, pkgs, modulesPath, ... }: # Standard-Funktionskopf inklusive modulesPath für automatische Hardware-Erkennung

{
  imports = [ # Importiert Hardware-Vorgaben aus dem NixOS-Core
    (modulesPath + "/installer/scan/not-detected.nix") # Automatisch generierter Standard-Import für nicht direkt erkannte Hardware
  ];

  boot.initrd.availableKernelModules = [ # Kernelmodule, die zwingend in der RAM-Disk (Initrd) geladen sein müssen, um zu booten
    "ehci_pci" # Treiber für Intel USB 2.0 Host-Controller (wichtig für Tastatur/Maus im Boot-Menü)
    "ahci" # Serial-ATA (SATA) Controller-Treiber für die Intel-SSD-Schnittstelle
    "usb_storage" # Basis-Treiber für USB-Massenspeicher (ermöglicht Booten und Rettung über USB-Sticks)
    "usbhid" # USB Human Interface Device Treiber (zwingend nötig für USB-Texttastaturen beim Booten)
    "sd_mod" # SCSI/SATA-Festplatten-Treiber (erzeugt die Gerätedateien wie /dev/sda und /dev/sdb)
  ];

  boot.initrd.kernelModules = [ ]; # Zusätzliche Initrd-Module (hier leer, da Standardmodule für den Intel-Host genügen)
  boot.extraModulePackages = [ ]; # Zusätzliche externe Out-of-Tree Kernel-Treiberpakete (derzeit nicht benötigt)

  fileSystems."/" = { # Definition des primären System-Wurzelverzeichnisses (Root)
    device = "/dev/disk/by-uuid/2812c87f-9d4f-4b4f-a554-579a4ae40d13"; # Die exakte physische UUID der Hauptpartition auf der Intel-SSD
    fsType = "ext4"; # Das native, robuste Linux-Dateisystem ext4 für die System-Closure
  };

  fileSystems."/boot" = { # Definition der EFI-Systempartition (ESP)
    device = "/dev/disk/by-uuid/28A0-0C37"; # Physische UUID der FAT32-formatierten Boot-Partition der Intel-SSD
    fsType = "vfat"; # Das UEFI-vorgeschriebene Dateisystem-Format (FAT32)
    options = [ # Wichtige Sicherheitsoptionen für die Boot-Partition (In Version 0 nach Audit verschärft)
      "fmask=0077" # Entzieht allen Usern außer Root jegliche Lese-/Schreibrechte für Dateien auf /boot
      "dmask=0077" # Entzieht allen Usern außer Root jegliche Rechte zum Auflisten von Ordnern auf /boot
    ];
  };

  swapDevices = [ ]; # Definition von Swap-Partitionen (ausgeschaltet, da das System auf ZRAM-Kompression im RAM setzt)

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux"; # Definiert standardmäßig die physische Prozessor-Architektur des Intel Core i3
}
