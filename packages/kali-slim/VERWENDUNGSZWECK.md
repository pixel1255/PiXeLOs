# Kali-Kapsel: Zweck und Nutzung

Co-Created by Pixel1255, Anti-Gravity Gemini & ChatGPT (GxG-Prozess)

Stand: 15.10.2026

## Wofür diese VM da ist

Die Kali-Kapsel ist Pixel1255s separate Lern- und Analyseumgebung für
SecOps und defensive Sicherheitsarbeit auf einem NixOS-Host.
Zuerst werden Kali selbst, sein Aufbau und seine Bedienung verstanden.
Anschließend bestimmen konkrete Fragen, welches einzelne Werkzeug gebraucht
wird und wie seine Ergebnisse einzuordnen sind.

Vorgesehene Arbeit:

- Linux-Grundlagen, Benutzerrechte, Dienste und Paketverwaltung kennenlernen.
- Eigene oder ausdrücklich zur Analyse freigegebene Dateien, Logs und
  Netzwerkaufzeichnungen lesend untersuchen.
- Netzwerkprotokolle und das Verhalten eigener Dienste nachvollziehen.
- Einzelne Werkzeuge anhand klarer Lernziele und ihrer Dokumentation lernen.
- Beobachtungen, Belege, offene Fragen und Ergebnisse nachvollziehbar festhalten.

## Vereinbarter Rahmen

Der Schwerpunkt liegt auf Beobachten, Verstehen und Auswerten. Exploits,
das Umgehen fremder Zugangskontrollen und Angriffe gehören nicht zum
vereinbarten Nutzungszweck dieser Kapsel.

Bei fremden Systemen oder fremden Daten werden vor der Untersuchung die
ausdrückliche Erlaubnis und ihr Umfang geklärt: Ziel, erlaubte Handlungen,
Zeitraum und Umgang mit den Ergebnissen. Technische Erreichbarkeit ist keine
Erlaubnis. Eine VM oder ein installiertes Werkzeug erteilt ebenfalls keine.

Lesen bereits vorhandener Aufzeichnungen und aktives Ansprechen eines
Netzwerkziels sind unterschiedliche Vorgänge. Der Starter führt keine Scans
oder Untersuchungen automatisch aus. Die Dokumentation beschreibt den
Nutzungsrahmen; sie erzwingt ihn nicht technisch.

## Welche Umgebung hier läuft

Im Gast läuft echtes Kali Linux aus dem offiziellen NetInstaller.
Die Nix-Flake definiert den QEMU-Starter und die Ressourcen:

| Bestandteil | Einstellung |
| --- | --- |
| Arbeitsspeicher | 4096 MiB |
| Virtuelle CPUs | 2 |
| Virtuelle Platte | Eigenständige QCOW2-Datei, 30 GiB virtuelle Kapazität |
| Lokale Platte | `~/kali-audit-lab/kali-slim/disk.qcow2` auf dem Host |
| Desktop-Ziel | Xfce, Werkzeuge nach Bedarf einzeln ergänzen |
| Standardstart | `boot`: keine virtuelle Netzwerkkarte |
| Netzwerkstart | `boot-online`: ausdrücklich gewähltes QEMU-NAT |

NAT erlaubt Verbindungen ins Internet und zu erreichbaren Host- und
LAN-Diensten. Es ist keine vollständige Netzisolation. Im Starter sind
keine Portweiterleitungen, Host-Verzeichnisfreigaben, physischen Platten
oder USB-Durchreichungen eingerichtet. Die bestehende `lab`-VM ist separat.

## Bedienung auf dem Host

Die folgenden Befehle gelten für den lokalen Checkout
`~/pixelos-kali-publish`. Sie werden ohne `sudo` auf dem NixOS-Host ausgeführt:

```bash
nix run "$HOME/pixelos-kali-publish#kali-slim" -- check
nix run "$HOME/pixelos-kali-publish#kali-slim" -- status
nix run "$HOME/pixelos-kali-publish#kali-slim" -- boot
```

Für Netzwerkzugriff die laufende VM erst regulär herunterfahren und dann
ausdrücklich `boot-online` statt `boot` wählen. Herunterfahren erfolgt
über das Kali-Desktop-Menü. Strg+Alt+F schaltet QEMU-GTK-Vollbild um.
Das Kontopasswort wird im Kali-Terminal mit `passwd` geändert.

## Was Git festhält

Repository: https://github.com/pixel1255/PiXeLOs

Die versionierte Beschreibung steht in
`packages/kali-slim/VERWENDUNGSZWECK.md`. Eine lokale Kopie darf als
`~/kali-audit-lab/kali-slim/VERWENDUNGSZWECK.md` neben der VM-Platte liegen.
Nach Änderungen an der Repository-Datei die lokale Kopie aktualisieren.

Git dokumentiert Starter, Einstellungen, Prüfungen und Nutzungszweck.
Die laufende Installation, ihre Daten und später installierte Gastpakete
liegen in der VM-Platte. Diese Platte benötigt eine gesonderte Sicherung
bei ausgeschalteter VM. Zugangsdaten und private Analyseaufzeichnungen
gehören nicht in das öffentliche Repository.

Der Installer ist per SHA256 festgelegt. Später aus Kali Rolling geladene
Pakete sind dadurch nicht automatisch versionsfest oder vollständig
reproduzierbar. Boot und Anmeldung wurden am 15.10.2026 bis zum Xfce-Desktop
bestätigt; die genaue installierte Paketliste ist separat zu erfassen.
