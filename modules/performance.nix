{ pkgs, lib, ... }: { # Die Funktion nutzt Standard-Pakete und Helfer-Bibliotheken für die Systemautomatisierung[cite: 32].

  # 1. Automatischer Nix-Store Putzer (Wöchentlich & Optimierung)
  nix.gc = { # Konfiguriert die Garbage Collection (Müllabfuhr) des Nix-Stores[cite: 32].
    automatic = true; # Aktiviert die regelmäßige automatische Reinigung[cite: 32].
    dates = "weekly"; # Legt fest, dass der Müll einmal pro Woche entsorgt wird[cite: 33].
    options = "--delete-older-than 7d"; # Löscht alle System-Generationen, die älter als 7 Tage sind, um Platz zu sparen[cite: 33].
  };
  nix.settings.auto-optimise-store = true; # Erkennt identische Dateien im Store und führt sie zusammen, um den Festplattenverbrauch zu minimieren[cite: 33].

  # 2. Reactive RAM-Guardian (Hintergrunddienst bei > 80% RAM)
  systemd.services.ram-guardian = { # Erstellt einen eigenen Hintergrunddienst zur Überwachung des Arbeitsspeichers[cite: 34].
    description = "Putzdienst bei RAM-Engpass (>80%)"; # Beschreibt die Aufgabe des Wächters[cite: 34].
    wantedBy = [ "multi-user.target" ]; # Sorgt dafür, dass der Dienst beim Systemstart automatisch im Hintergrund geladen wird[cite: 35].
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash -c 'while true; do free | awk \"/Mem:/ {print \\$3/\\$2 * 100.0}\" | while read usage; do if (( \$(echo \"\$usage > 80\" | bc -l) )); then sync; echo 3 > /proc/sys/vm/drop_caches; notify-send \"🛡️ RAM-Guardian\" \"RAM bei \${usage}%% - Putzaktion durchgeführt!\"; fi; done; sleep 30; done'"; # Ein Skript, das alle 30 Sekunden den RAM prüft und bei über 80% Auslastung die Caches leert und eine Benachrichtigung sendet[cite: 35].
      User = "root"; # Der Dienst benötigt Administratorrechte, um die System-Caches leeren zu dürfen[cite: 36].
    };
    path = with pkgs; [ bash coreutils gawk bc libnotify ]; # Stellt die notwendigen Werkzeuge (awk, bc, notify-send) für das Skript bereit[cite: 36].
  };

  # 3. Aliase für den manuellen Notfall
  environment.shellAliases = { # Definiert Abkürzungen für das Terminal, um schnell manuell eingreifen zu können[cite: 37].
    putz-ram = "sudo sync; echo 3 | sudo tee /proc/sys/vm/drop_caches"; # Ein Befehl, um sofort den RAM-Cache zu leeren und Daten auf die Platte zu schreiben[cite: 37].
    putz-nix = "nix-collect-garbage -d"; # Ein Befehl, um sofort alle alten System-Versionen zu löschen und Speicherplatz freizugeben[cite: 38].
  };
}

/* * 📜 ARCHITEKTEN-NOTIZ FÜR DIE COMMUNITY:
 * ----------------------------------------
 * Die performance.nix ist das Immunsystem von PiXeLOs. Sie schützt das
 * System vor schleichender Verlangsamung und Datenmüll.
 *
 * 🛡️ REAKTIVER SCHUTZ:
 * Der 'RAM-Guardian' ist eine Eigenentwicklung, die aktiv wird, bevor
 * das System einfriert. Das ist besonders bei intensiven Workflows Gold wert.
 *
 * 🧹 AUTOMATISCHE HYGIENE:
 * Durch die wöchentliche Garbage Collection bleibt PiXeLOs schlank,
 * ohne dass der Architect manuell eingreifen muss.
 *
 * ⚡ SCHNELLE INTERVENTION:
 * Die Aliase 'putz-ram' und 'putz-nix' geben dem User die volle
 * Kontrolle über die Ressourcen, direkt über die Kommandozeile.
 */
