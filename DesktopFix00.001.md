# Bericht: DesktopFix00.001 — OpenSnitch-GUI Autostart

## Problem (Der Bug)
- **Symptom:** Nach der System-Härtung lief zwar der OpenSnitch-Hintergrunddienst (`opensnitchd.service`), aber die dazugehörige grafische Taskleisten-Oberfläche (`opensnitch-ui`) startete nach dem Desktop-Login nicht automatisch.
- **Ursache:** Das Aktivieren eines Dienstes in NixOS (`services.opensnitch.enable`) startet systemweit standardmäßig nur den Core-Daemon als Root. Die grafische UI erfordert Benutzerrechte im X11/Wayland-Kontext und wird von NixOS nicht standardmäßig in den Desktop-Autostart gehängt.

## Lösung
- **Maßnahme:** Einbau eines deklarativen XDG-Autostart-Eintrags im Desktop-Modul (`modules/desktop/plasma.nix`).
- **Mechanismus:** Über `environment.etc."xdg/autostart/opensnitch-ui.desktop"` generiert NixOS eine standardkonforme Desktop-Starterdatei im System-XDG-Pfad. 
- **Ergebnis:** Bei jedem Login in KDE Plasma wird `opensnitch-ui` nun vollautomatisch und benutzerspezifisch mit den passenden Wayland-Rechten im System-Tray gestartet.

**Status: BEHOBEN & VERIFIZIERT (GREEN)**
