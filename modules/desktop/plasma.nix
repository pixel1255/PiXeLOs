# ==============================================================================
# MODULES/DESKTOP/PLASMA.NIX — XSERVER BASE, SDDM MANAGER & KDE PLASMA 6
# Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)
# ==============================================================================
{ pkgs, ... }: # Standard-Funktionskopf, erweitert um Zugriff auf pkgs für Autostart-Skripte

{
  services.xserver.enable = true; # Aktiviert das grundlegende X11-Display-Server-Subsystem (wird von SDDM als Fallback benötigt)

  services.displayManager.sddm = { # Konfigurationsblock für den grafischen Anmelde-Manager
    enable = true; # Aktiviert SDDM als primären Login-Bildschirm
    wayland.enable = true; # Schaltet SDDM nativ auf das moderne, sichere Wayland-Protokoll um
  };

  services.desktopManager.plasma6.enable = true; # Aktiviert die vollständige grafische Desktop-Umgebung KDE Plasma 6

  # --- Deklarativer XDG-Autostart für die OpenSnitch Application Firewall GUI ---
  environment.etc."xdg/autostart/opensnitch-ui.desktop".text = ''
    [Desktop Entry]
    Name=OpenSnitch Application Firewall
    Comment=Grafische Benutzeroberfläche für interaktive Netzwerk-Prompts
    Exec=opensnitch-ui
    Icon=opensnitch-ui
    Terminal=false
    Type=Application
    Categories=Network;Security;
    StartupNotify=false
    X-GNOME-Autostart-enabled=true
    X-KDE-autostart-after=panel
  '';
}
