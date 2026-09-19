## ==============================================================================## MODULES/USERS/PIXEL1255.NIX — BENUTZERKONTO, SUDO & BASH-COMPLETION## Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)## ==============================================================================
{ pkgs, ... }: # Standard-Funktionskopf mit Zugriff auf pkgs für die interaktive Shell und Browser
{
users.users.pixel1255 = { # Definitionsblock für das primäre menschliche Benutzerkonto
isNormalUser = true; # Deklariert das Konto als regulären unprivilegierten Benutzer (kein System-Spezialaccount)
description = "PiXeL1255"; # Grafischer Anzeigename für den SDDM Login-Bildschirm
home = "/home/pixel1255"; # Pfad zum persönlichen Benutzerverzeichnis (Home-Ordner)
createHome = true; # Zwingt das System, das Home-Verzeichnis beim ersten Erstellen automatisch anzulegen
shell = pkgs.bashInteractive; # Setzt die interaktive GNU Bash inklusive Befehlszeilen-Erweiterungen als Standard-Shell
extraGroups = [ # Array von Systemgruppen, in die der Benutzer für Hardware- und Adminrechte aufgenommen wird
"wheel" # Ermöglicht dem Benutzer die Nutzung von 'sudo', um administrative Befehle auszuführen
"networkmanager" # Erlaubt das eigenständige Wechseln von WLANs und Profilen ohne Root-Passwort
"audio" # Gewährt direkten Zugriff auf physische Soundkarten und Audiogeräte
"video" # Gewährt direkten Zugriff auf die Intel-GPU (wichtig für Hardware-Videobeschleunigung)
"dialout" # Erlaubt den Zugriff auf serielle Schnittstellen (wichtig für Entwickler-Hardware/Arbeitswerkzeuge)
"kvm" # Gewährt Zugriff auf den Kernel-Virtualisierungs-Beschleuniger (wichtig für spätere VMs)
];
};
security.sudo = { # Konfigurationsblock für das Sudo-Rechte-System
enable = true; # Schaltet das Sudo-Framework für privilegierte Befehle ein
wheelNeedsPassword = true; # Zwingt Mitglieder der Gruppe 'wheel', immer ihr eigenes Passwort zur Bestätigung einzugeben (Sicherheitsschutz)
};
programs.bash.completion.enable = true; # Aktiviert die intelligente Tab-Vervollständigung für Bash-Befehle (In v0.002 syntaktisch gefixt)
programs.firefox = { # Konfigurationsblock für den Webbrowser Firefox
enable = true; # Aktiviert die systemweite Bereitstellung und Vorkonfiguration von Firefox
package = pkgs.firefox-beta; # Erzwingt die Installation der topaktuellen Firefox Beta-Version laut Logbuch-Ziel
};
}
