## ==============================================================================## MODULES/HARDWARE/USB-DEVICES.NIX — IPHONE TETHERING, FIRMWARE & FRITZ!WLAN## Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)## ==============================================================================
{ config, pkgs, lib, ... }: # Standard-Funktionskopf für Firmware-Bedingungen und Paket-Zuweisungen
{
boot.kernelModules = [ # Kernelmodule, die direkt nach der Initrd-Phase fest in den laufenden Kernel geladen werden
"kvm-intel" # Aktiviert die Hardware-Virtualisierung für Intel-CPUs (Voraussetzung für spätere VMs)
"ipheth" # Offizieller Linux-Treiber für USB-Netzwerktethering via Apple iPhone
"mt76x0u" # Mediatek-Treiber für USB-WLAN-Geräte (wichtig für den FRITZ!WLAN AC 430 Stick)
"mt76x2u" # Erweitertes Mediatek-WLAN-Modul für USB-Schnittstellen
"mt76x02-usb" # Gemeinsame USB-Basisbibliothek für Mediatek mt76-Chipsätze
"mt76x02-lib" # Core-Bibliothek für die Signalverarbeitung der mt76-WLAN-Treiber
"mt76-usb" # USB-Busschnittstellen-Modul des mt76-WLAN-Frameworks
"mt76" # Das übergeordnete Mediatek Wireless-Core-Modul im Linux-Kernel
];
hardware.enableRedistributableFirmware = true; # Erlaubt das Laden von herstellerspezifischer, unfreier Firmware (wichtig für WLAN/Netzwerk)
hardware.cpu.intel.updateMicrocode = # Konfiguriert das Laden von Sicherheits- und Stabilitätsupdates für den Prozessor
lib.mkDefault config.hardware.enableRedistributableFirmware; # Lädt den neuesten Intel-Microcode, sofern Firmware erlaubt ist
hardware.usb-modeswitch.enable = true; # Aktiviert usb-modeswitch (schaltet Kombi-USB-Sticks vom CD-Rom-Modus in den echten Modem/WLAN-Modus)
services.usbmuxd = { # Aktiviert den Apple USB-Multiplex-Dienst (stellt die USB-Kommunikation mit iOS-Geräten her)
enable = true; # Schaltet den Dienst permanent ein
package = pkgs.usbmuxd2; # Erzwingt die Nutzung des modernen, performanteren usbmuxd2-Backends für stabiles Tethering
};
  # HÄRTUNG F04/F05: Kapselung der KVM und VSOCK Interfaces auf die Gruppe KVM mit Rechten 660
  services.udev.extraRules = ''
    KERNEL=="kvm", GROUP="kvm", MODE="0660"
    KERNEL=="vhost-vsock", GROUP="kvm", MODE="0660"
  '';
}
