{ pkgs, ... }: { # Die Funktion stellt die Verbindung zum Nix-Paketpool her.

  services.desktopManager.plasma6.enable = true; # Aktiviert KDE Plasma 6, deine moderne und hochgradig anpassbare Desktop-Umgebung.

  services.displayManager.sddm.enable = true; # Aktiviert SDDM als grafischen Login-Manager, der dich beim Systemstart begrüßt.

  services.displayManager.sddm.wayland.enable = true; # Schaltet Wayland für SDDM frei, das modernere Protokoll für flüssigere Grafik und bessere Sicherheit.

  # DBus Entlastung
  services.dbus.implementation = "broker"; # Ersetzt den alten DBus-Daemon durch den performanteren 'dbus-broker'. Das sorgt für eine schnellere Kommunikation zwischen Programmen und entlastet das System.

  # Grafik-Priorität: Schlanke Treiber-Wahl
  hardware.graphics.enable = true; # Aktiviert die grundlegende Unterstützung für Grafikbeschleunigung im System.

  services.xserver.videoDrivers = [ "virtio" ]; # Setzt den schlanken 'virtio'-Treiber als Priorität. Dies ist ideal für virtualisierte Umgebungen oder als Fallback, um maximale Kompatibilität zu gewährleisten.
}

/* * 📜 ARCHITEKTEN-NOTIZ FÜR DIE COMMUNITY:
 * ----------------------------------------
 * Die desktop.nix definiert die Brücke zwischen Mensch und Maschine.
 * Sie ist auf ein reaktionsschnelles und stabiles Nutzererlebnis getrimmt.
 *
 * 🚀 NEXT-GEN GRAFIK:
 * Durch die Kombination von Plasma 6 und Wayland nutzt PiXeLOs die
 * aktuellsten Standards für moderne Display-Technologie.
 *
 * ⚡ EFFIZIENZ IM HINTERGRUND:
 * Die Wahl des dbus-brokers zeigt den Fokus auf System-Performance.
 * Prozesse können so ohne unnötige Verzögerungen miteinander sprechen.
 *
 * 🖥️ HARDWARE-FOKUS:
 * Der Einsatz der virtio-Treiber in Kombination mit der Grafik-Aktivierung
 * sorgt dafür, dass die Desktop-Umgebung auch in anspruchsvollen
 * Konfigurationen flüssig läuft.
 */
