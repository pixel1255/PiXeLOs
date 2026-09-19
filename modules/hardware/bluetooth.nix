## ==============================================================================## MODULES/HARDWARE/BLUETOOTH.NIX — BLUEZ SUBSYSTEM & POWER-MANAGEMENT## Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)## ==============================================================================
{ ... }: # Leerer Funktionskopf, da hier nur native Bluetooth-Flags gesetzt werden
{
hardware.bluetooth = { # Konfigurationsblock für Funk-Konnektivität (BlueZ-Stack)
enable = true; # Aktiviert den Bluetooth-Systemdienst und lädt die nötigen Kernelmodule beim Start
powerOnBoot = true; # Schaltet den Bluetooth-Controller direkt beim Systemstart ein (spart manuelles Aktivieren im Desktop)
};
}
