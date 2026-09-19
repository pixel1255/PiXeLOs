# ==============================================================================
# MODULES/SYSTEM/LOCALE.NIX — SPRACHE, TASTATURLAYOUTS & INTERNATIONALISIERUNG
# Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)
# ==============================================================================
{ ... }: # Leerer Funktionskopf, da hier keine externen Pakete oder Hilfsfunktionen gebraucht werden

{
  time.timeZone = "Europe/Berlin"; # Setzt die physische System-Zeitzone auf deutsche mitteleuropäische Zeit (CET/CEST)

  i18n = { # Internationalisierungs-Block
    defaultLocale = "de_DE.UTF-8"; # Setzt die Standard-Systemsprache und Zeichenkodierung auf Deutsch im modernen UTF-8-Format
    extraLocaleSettings = { # Definiert länderspezifische Formatierungen nach deutschen DIN-Standards
      LC_ADDRESS = "de_DE.UTF-8"; # Format für Postadressen
      LC_IDENTIFICATION = "de_DE.UTF-8"; # Format für System-Metadaten
      LC_MEASUREMENT = "de_DE.UTF-8"; # Format für Maßeinheiten (Metrisches System)
      LC_MONETARY = "de_DE.UTF-8"; # Format für Währungen (Euro-Darstellung)
      LC_NAME = "de_DE.UTF-8"; # Format für Personen- und Namensdarstellungen
      LC_NUMERIC = "de_DE.UTF-8"; # Format für Zahlenstrukturen (Komma als Dezimaltrenner)
      LC_PAPER = "de_DE.UTF-8"; # Format für Papiergrößen (Standard DIN A4)
      LC_TELEPHONE = "de_DE.UTF-8"; # Format für Telefonnummernstrukturen
      LC_TIME = "de_DE.UTF-8"; # Format für Datum und Uhrzeit (24-Stunden-Anzeige, DD.MM.YYYY)
    };
  };


console.keyMap = "de-latin1"; # Setzt das deutsche Tastaturlayout für die reine TTY-Textkonsole (vor dem Desktop-Start)
services.xserver.xkb = { # Konfigurationsblock für die grafischen Tastaturlayouts des X11/Wayland-Subsystems
layout = "de"; # Aktiviert das deutsche QWERTZ-Tastaturlayout für alle grafischen Anwendungen
variant = ""; # Nutzt die Standardvariante ohne Modifikationen (wie z.B. ohne deadkeys)
};
}
