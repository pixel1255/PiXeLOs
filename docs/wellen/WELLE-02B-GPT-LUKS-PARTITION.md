# Welle 2B – GPT und LUKS-Zielpartition

Stand: 2026-09-20
Status: grün

## 1. Zweck

Die gesamte SanDisk besitzt genau eine GPT-Partition mit dem standardisierten Linux-LUKS-Typ. Sie enthält selbst noch kein direkt mountbares Dateisystem.

## 2. Bestätigte Metadaten

| Feld | Wert |
| --- | --- |
| GPT-Datenträger-GUID | `645AB585-FD1D-4E8F-9FC0-48FCE25266C4` |
| PARTUUID | `c834f289-cff5-401d-a584-0899019042ed` |
| PARTLABEL | `PIXEL_LAB_CRYPT` |
| PARTTYPE | `CA7D7CCB-63ED-4C53-861C-1742536059CC` |
| Startsektor | 2048 |
| Endsektor | 234452991 |
| Sektoren | 234450944 |
| Größe | 111,8 GiB |

## 3. Was wurde getestet?

- zunächst eine vollständig schreibgeschützte `sfdisk --no-act`-Simulation,
- danach genau ein bestätigter GPT-Schreibvorgang,
- erneutes Einlesen über udev,
- Existenz von genau einer Partition,
- exakter PARTTYPE und PARTLABEL,
- strukturelle GPT-Prüfung mit `sfdisk --verify`.

Das lokale `sfdisk` zeigte für die direkte GUID den Namen „unbekannt“. Das war nur eine fehlende Bezeichnung im Typenkatalog. `lsblk PARTTYPE` bestätigte die tatsächlich geschriebene GUID exakt.

## 4. Wann und wie oft?

| Prüfung | Häufigkeit |
| --- | --- |
| PARTUUID, PARTTYPE und PARTLABEL lesen | vor jedem Storage-Build und nach Hardwareänderungen |
| `sfdisk --verify` | nach Partitionsänderungen und bei GPT-Warnungen |
| GPT neu schreiben | niemals als Routine |
| Partition vergrößern oder ändern | nur mit eigener Welle, Backup und expliziter Freigabe |

## 5. Grün

- genau eine Partition,
- PARTTYPE entspricht der LUKS-GUID,
- PARTLABEL entspricht `PIXEL_LAB_CRYPT`,
- GPT-Prüfung meldet keine Fehler,
- keine Hostpartition wurde verändert.

## 6. Rot

- zusätzliche Partitionen,
- geänderte PARTUUID ohne geplanten Neuaufbau,
- Typ oder Label weichen ab,
- GPT-Kopf oder Backup-GPT fehlerhaft,
- Zielgerät stimmt nicht mit der stabilen SanDisk-Identität überein.

## 7. Aktueller Laufeintrag

- Simulationen: 1 erfolgreiche No-Act-Simulation
- Schreibvorgänge: 1
- Verifikation: `sfdisk --verify` ohne Fehler
- Status: GRÜN
- Wiederholung: nur read-only Metadatenprüfung; kein erneutes Schreiben
