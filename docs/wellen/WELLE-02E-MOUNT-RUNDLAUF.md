# Welle 2E – Mount-, Schreib- und Wiederöffnungsrundlauf

Stand: 2026-09-20
Status: grün

## 1. Zweck

Dieser End-to-End-Test beweist, dass die Passphrase, der LUKS-Mapper, ext4, der Mountpunkt und die Datenpersistenz gemeinsam funktionieren und anschließend keinen offenen Zustand zurücklassen.

## 2. Testablauf

### Runde 1

1. LUKS2 öffnen.
2. ext4-Typ, Label und UUID prüfen.
3. unter `/srv/pixel-lab` mit `rw,nosuid,nodev` mounten.
4. genau eine eindeutig benannte Testdatei schreiben.
5. SHA-256 bilden.
6. aushängen und LUKS schließen.

### Runde 2

1. LUKS2 erneut öffnen.
2. dasselbe ext4 erneut mounten.
3. Testdatei lesen.
4. Inhalt und SHA-256 mit Runde 1 vergleichen.
5. ausschließlich die eigene Testdatei entfernen.
6. aushängen und LUKS schließen.

## 3. Gemessenes Ergebnis

| Messung | Wert |
| --- | --- |
| Mountpunkt | `/srv/pixel-lab` |
| Quelle | `/dev/mapper/pixel-lab-crypt` |
| Typ | ext4 |
| Optionen | `rw,nosuid,nodev,relatime` |
| Hash Runde 1 | `155721fc8488258f204c239c2d35415647114bdd0cd467259b91c9388c798e92` |
| Hash Runde 2 | `155721fc8488258f204c239c2d35415647114bdd0cd467259b91c9388c798e92` |
| Testdatei danach | entfernt |
| Mount danach | nicht vorhanden |
| Mapper danach | geschlossen |

Beim ersten Öffnen gab es eine abgelehnte Passphrase-Eingabe. Das war ein erwarteter Authentifizierungsfehler ohne Datenänderung. Die folgende Eingabe öffnete den Container; der vollständige Rundlauf war erfolgreich.

## 4. Wann und wie oft?

| Anlass | Häufigkeit |
| --- | --- |
| nach erstmaliger Einrichtung | einmal vollständig |
| nach Änderung des Storage-Moduls oder Mountwrappers | einmal vollständig |
| nach Kernel-, Cryptsetup- oder ext4-relevanter Änderung | einmal kontrolliert |
| vor Aufnahme wertvoller Daten | einmal nach Fertigstellung des deklarativen Moduls |
| normale tägliche Nutzung | kein künstlicher Vollrundlauf; normale Open/Mount/Unmount/Close-Prüfung reicht |
| bei I/O- oder Persistenzverdacht | vollständiger Rundlauf mit neuer, eindeutig eigener Testdatei |

Der Test löscht nur seine selbst erzeugte, vorher exakt geprüfte Testdatei. Fremde Dateien werden niemals als Testbereinigung entfernt.

## 5. Grün

- beide Öffnungen funktionieren,
- Quelle, Typ, UUID und Label stimmen,
- Hash und Inhalt bleiben identisch,
- Testdatei wird gezielt entfernt,
- Dateisystem ist danach ausgehängt,
- Mapper ist danach geschlossen.

## 6. Rot

- zweite Öffnung zeigt ein anderes Dateisystem,
- Mountquelle oder UUID weichen ab,
- Hash oder Inhalt ändern sich,
- Testdatei fehlt unerwartet,
- Aushängen oder Schließen scheitert,
- nach Abschluss bleiben Mount oder Mapper bestehen.

## 7. Aktueller Laufeintrag

- vollständige Rundläufe: 1
- Öffnungen innerhalb des Laufs: 2 erfolgreich
- Hashvergleich: identisch
- Bereinigung: erfolgreich
- Endzustand: unmounted und geschlossen
- Status: GRÜN

## 8. Nächster Test

Der nächste vollständige Rundlauf erfolgt erst nach dem Bau des deklarativen Storage-Moduls und seiner kurzen Terminalkommandos. Bis dahin bleibt die SanDisk standardmäßig geschlossen.
