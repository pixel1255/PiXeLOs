{ pkgs, ... }: { # Die Funktion greift auf die Paketbibliothek für die Sicherheits-Tools zu.

  # Ultra-Lean Guardian: Reagiert nur auf Datei-Events
  systemd.user.services.guardian-shell = { # Erstellt einen Hintergrunddienst auf Benutzerebene (User-Service).
    description = "Lean Guardian AI"; # Bezeichnung deines intelligenten Überwachungswächters.
    wantedBy = [ "graphical-session.target" ]; # Der Wächter startet automatisch, sobald deine grafische Oberfläche (KDE Plasma) bereit ist[cite: 40].

    serviceConfig = {
      # Nutzt inotify-tools um CPU-Last gegen Null zu fahren
      ExecStart = "${pkgs.bash}/bin/bash -c 'while ${pkgs.inotify-tools}/bin/inotifywait -e modify /var/log/lastlog; do ${pkgs.libnotify}/bin/notify-send \"🛡️ Lean Alert\" \"System-Event registriert\"; done'"; # Ein hocheffizientes Skript, das die Log-Datei '/var/log/lastlog' überwacht. Nur wenn eine Änderung (z.B. ein Login-Versuch) registriert wird, erfolgt eine Desktop-Benachrichtigung[cite: 40].

      Nice = 19; # Setzt die Priorität auf den niedrigsten Wert; der Wächter stört niemals andere Prozesse[cite: 41].
      CPUSchedulingPolicy = "idle"; # Der Kernel weist diesem Dienst nur dann Rechenzeit zu, wenn die CPU absolut nichts anderes zu tun hat[cite: 41].
      CPUWeight = 1; # Minimale Gewichtung der CPU-Ressourcen für maximale System-Effizienz[cite: 41].
    };
  };

  environment.systemPackages = [ pkgs.libnotify pkgs.inotify-tools ]; # Installiert die notwendigen Werkzeuge für Benachrichtigungen und die Datei-Überwachung im gesamten System[cite: 42].
}

/* * 📜 ARCHITEKTEN-NOTIZ FÜR DIE COMMUNITY:
 * ----------------------------------------
 * Die security.nix ist das Frühwarnsystem von PiXeLOs. Sie ist nach dem
 * "Lean-Prinzip" entworfen: Maximale Aufmerksamkeit bei minimalem Verbrauch. [cite: 39]
 *
 * 🛡️ EVENT-BASIERTE SICHERHEIT:
 * Statt permanent im Hintergrund zu pollen, "schläft" dieser Dienst
 * dank inotify-tools so lange, bis tatsächlich ein Ereignis eintritt. [cite: 40]
 *
 * 📉 ZERO-FOOTPRINT:
 * Durch die Einstufung als 'idle'-Prozess verbraucht der Guardian
 * spürbar keine Leistung, ist aber im Moment eines Logins sofort präsent. [cite: 41]
 *
 * 🏗️ SYSTEM-TRANSPARENZ:
 * Dieser Ansatz fördert das Bewusstsein für Systemvorgänge. Jede
 * Interaktion wird für den Architect sichtbar, ohne ihn zu behindern. [cite: 40]
 */
