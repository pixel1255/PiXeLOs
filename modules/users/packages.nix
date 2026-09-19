## ==============================================================================## MODULES/USERS/PACKAGES.NIX — DEKLARATIVE SYSTEMWEITE PAKETLISTE## Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)## ==============================================================================
{ pkgs, ... }: # Standard-Funktionskopf mit Zugriff auf den vollständigen Paketbaum von Nixpkgs
{
environment.systemPackages = with pkgs; [ # Array für systemweit verfügbare Anwendungen (verfügbar für alle User im Pfad)
# --- KDE Plasma 6 Core Apps & Utilities ---
kdePackages.dolphin # Der native, leistungsstarke KDE-Dateimanager
kdePackages.konsole # Der Standard-KDE-Terminalemulator für die Werkbank-Arbeit
kdePackages.kate # Der fortschrittliche KDE-Texteditor für schnelles Editieren von Quellcode
kdePackages.spectacle # Das KDE-Dienstprogramm für präzise Screenshots und Bildschirmaufnahmen
kdePackages.ark # Das KDE-Archivierungswerkzeug zum Packen und Entpacken von ZIP/TAR/RAR
kdePackages.gwenview # Der schnelle und schlanke Bildbetrachter von KDE
kdePackages.okular # Universeller Dokumentenbetrachter (PDF, EPub, Comic-Bücher)
kdePackages.partitionmanager # Grafische Verwaltung von Festplatten, Partitionen und Dateisystemen
kdePackages.kcalc # Der wissenschaftliche KDE-Taschenrechner
kdePackages.plasma-systemmonitor # Moderner Taskmanager zur Überwachung von CPU, RAM und Intel-GPU-Last
kdePackages.kio-extras # Erweiterte Netzwerk- und Metadaten-Protokolle für den Dolphin-Dateimanager
# --- Spezialisierte Anwendungen & Multimedia ---
obsidian # Lokale, Markdown-basierte Wissensdatenbank für Notizen und Dokumentation
easyeffects # Fortschrittlicher Audio-Effektprozessor für PipeWire (Equalizer, Limiter)
# --- Apple iOS & iPhone Integration ---
libimobiledevice # Native Protokollbibliothek zur Kommunikation mit Apple iOS-Geräten über USB
ifuse # FUSE-Dateisystemtreiber zum sicheren Einbinden des iPhone-Speichers in Dolphin
# --- Hardware-Analyse & USB-Werkzeuge ---
usbutils # CLI-Werkzeuge zur Identifikation von USB-Geräten (enthält 'lsusb')
usb-modeswitch # Steuerungs-Tool für USB-Kombigeräte (wichtig für die AC 430 Initialisierung)
alsa-utils # Basis-Kommandozeilenwerkzeuge für ALSA-Soundkartensteuerung (enthält 'alsamixer')
# --- Core Editoren (Kommandozeile) ---
nano # Einfacher, intuitiver Terminal-Texteditor für schnelle Notfälle
vim # Leistungsstarker, modaler Terminal-Texteditor für fortgeschrittene Konfigurationen
# --- Netzwerk & Datenübertragung ---
curl # CLI-Werkzeug zum Übertragen von Daten über Webprotokolle (HTTP, HTTPS, FTP)
wget # Klassischer Kommandozeilen-Downloader für Webdateien
# --- Strukturierte Datenverarbeitung & Filter ---
jq # Leichtgewichtiger und flexibler CLI-Prozessor für JSON-Dateien (wichtig für flake.lock Analyse)
tree # Stellt Verzeichnisstrukturen visuell als übersichtlichen Baum im Terminal dar
ripgrep # Extrem schnelles Suchwerkzeug für Textmuster innerhalb von Verzeichnissen ('rg')
fd # Einfache, schnelle und benutzerfreundliche Alternative zum klassischen 'find'-Befehl
fzf # Interaktiver Fuzzy-Finder für die Befehlszeile (beschleunigt die Navigation enorm)
# --- Archivierungswerkzeuge ---
unzip # Werkzeug zum Entpacken von Standard-ZIP-Archiven
zip # Werkzeug zum Erstellen von Standard-ZIP-Archiven
p7zip # CLI-Portierung des 7-Zip-Archivierers mit maximaler Kompressionsrate
# --- System-Diagnose & Ablaufverfolgung ---
file # Bestimmt den exakten Dateityp einer Datei unabhängig von der Endung
lsof # Listet alle aktuell geöffneten Dateien und die dazugehörigen Prozesse auf
strace # Diagnose-Werkzeug zur Überwachung von Systemaufrufen und Signalen eines Programms
# --- System-Monitoring (Live-Ansicht) ---
htop # Interaktiver, farbiger Prozessmonitor für das Terminal
btop # Moderner, grafisch beeindruckender Monitor für CPU, Speicher, Festplatten und Netzwerk
fastfetch # Schnelles, anpassbares Systeminformations-Tool zur Darstellung der System-Baseline
# --- Physische Hardware-Auslesung ---
pciutils # Werkzeuge zum Auslesen des PCI-Busses (enthält 'lspci' für die Intel-Grafikkarte)
lm_sensors # CLI-Werkzeuge zum Auslesen von Hardware-Temperatursensoren und Lüfterdrehzahlen
smartmontools # Überwachungswerkzeuge für SSDs und Festplatten mittels S.M.A.R.T. (enthält 'smartctl')
# --- Datei- und Binäroptimierung ---
rsync # Schnelles, extrem vielseitiges Werkzeug zum Kopieren und Synchronisieren von Dateien
hexyl # Ein moderner, farbiger Hex-Viewer für das Terminal zur Untersuchung von Binärdaten
exiftool # Leistungsstarkes Werkzeug zum Lesen, Schreiben und Bearbeiten von Datei-Metadaten
binutils # Sammlung von Werkzeugen zur Bearbeitung von Binär- und Objektdateien
less # Text-Pager zum seitenweisen Betrachten langer Terminal-Ausgaben
# --- Entwicklung & Versionsverwaltung ---
git # Das verteilte Versionsverwaltungssystem für die Verwaltung dieses NixOS-Repositorys
python3 # Die interaktive Python-Programmierumgebung inklusive Standardbibliotheken
];
}
