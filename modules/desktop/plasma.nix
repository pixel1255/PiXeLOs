## ==============================================================================## MODULES/DESKTOP/PLASMA.NIX — XSERVER BASE, SDDM MANAGER & KDE PLASMA 6## Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)## ==============================================================================
{ ... }: # Leerer Funktionskopf, da hier rein deklarative Desktop-Dienste definiert werden
{
services.xserver.enable = true; # Aktiviert das grundlegende X11-Display-Server-Subsystem (wird von SDDM als Fallback benötigt)
services.displayManager.sddm = { # Konfigurationsblock für den grafischen Anmelde-Manager
enable = true; # Aktiviert SDDM als primären Login-Bildschirm
wayland.enable = true; # Schaltet SDDM nativ auf das moderne, sichere Wayland-Protokoll um
};
services.desktopManager.plasma6.enable = true; # Aktiviert die vollständige grafische Desktop-Umgebung KDE Plasma 6
}
