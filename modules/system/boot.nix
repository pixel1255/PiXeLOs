# ==============================================================================
# MODULES/SYSTEM/BOOT.NIX — SYSTEMD-BOOT, LINUX-KERNEL & KERNEL-PARAMETER
# Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)
# ==============================================================================
{ pkgs, ... }: # Standard-Funktionskopf mit Zugriff auf das Paket-Repository für Kernel-Pakete

{
  boot.loader = { # Konfigurationsblock für den Linux-Bootloader
    systemd-boot = { # Aktiviert den modernen, schlanken systemd-boot UEFI-Bootloader
      enable = true; # Schaltet systemd-boot als Standard-Bootmanager ein
      configurationLimit = 5; # Begrenzt die Boot-Einträge auf 5 Generationen, um ein Überlaufen von /boot zu verhindern
      consoleMode = "max"; # Setzt die Konsolenauflösung im Boot-Menü auf das Maximum des Monitors
    };
    efi.canTouchEfiVariables = true; # Erlaubt NixOS, die EFI-Boot-Einträge im NVRAM des Mainboards direkt zu schreiben
    timeout = 3; # Setzt die Wartezeit im Bootmenü auf 3 Sekunden, bevor der Standard-Eintrag startet
  };

  boot.tmp = { # Konfigurationsblock für temporäre Dateien
    useTmpfs = true; # Mountet /tmp direkt in den flüchtigen Arbeitsspeicher (RAM) statt auf die Intel-SSD
    tmpfsSize = "50%"; # Begrenzt den maximalen RAM-Verbrauch von /tmp auf 50% des verfügbaren Arbeitsspeichers
  };

  boot.kernelPackages = pkgs.linuxPackages_6_12; # Fixiert den Linux-Kernel auf die stabile LTS-Linie 6.12 für optimale Intel-Stabilität
}
