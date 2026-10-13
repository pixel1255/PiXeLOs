# Welle 2A – Einmalige SanDisk-Löschung

Stand: 2026-09-20
Status: abgeschlossen; nicht wiederholen

## 1. Zweck und Grenze

Die frühere SanDisk-Struktur mit alter EFI- und Root-Partition wurde vollständig entfernt, damit das Lab ohne Altlasten neu aufgebaut werden kann.

Dies war ein irreversibler Erzeugungsschritt und ist kein Gesundheits- oder Routinetest.

## 2. Freigegebenes Ziel

- stabiler Pfad: `/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_183903802232`
- Modell: SanDisk SSD PLUS 120GB
- Serienkennung: `183903802232`
- Größe: 120040980480 Byte

Die Intel-SSD war ausdrücklich ausgeschlossen.

## 3. Was wurde ausgeführt?

1. Zielidentität, Mounts und Swap wurden geprüft.
2. Die SanDisk wurde vollständig per SSD-Discard geleert.
3. Anfang und Ende des Datenträgers wurden zusätzlich genullt.
4. Partitionstabelle, Dateisystemsignaturen und alte Bootstruktur wurden erneut geprüft.
5. UEFI-Einträge wurden gegen die Intel-EFI-PARTUUID kontrolliert.

Die genaue destruktive Befehlsfolge wird absichtlich nicht als Routinekommando in diesem Dokument konserviert.

## 4. Ergebnis

Nach dem Lauf zeigte `lsblk` nur noch den leeren Datenträger:

- keine Partition,
- kein Dateisystem,
- kein Label,
- keine UUID,
- kein Mountpunkt.

Die UEFI-Prüfung zeigte ausschließlich die Intel-EFI als aktive Bootquelle.

## 5. Wann und wie oft?

| Anlass | Häufigkeit |
| --- | --- |
| aktueller Lab-Aufbau | genau einmal ausgeführt |
| normale Prüfung | niemals |
| Fehlerdiagnose | nur read-only prüfen, nicht erneut löschen |
| vollständiger, bewusst beschlossener Neuaufbau | neuer Plan und neue explizite Freigabe erforderlich |

## 6. Grün

- ausschließlich die bestätigte SanDisk wurde verändert,
- danach existierten keine Partitionen oder Signaturen,
- Intel-Root und Intel-EFI blieben unverändert,
- kein veralteter SanDisk-Bootpfad blieb aktiv.

## 7. Rot

- Zielidentität unklar,
- unerwarteter Mount oder Swap,
- Intel-Pfad taucht als Ziel auf,
- Daten müssen erhalten bleiben,
- Discard- oder Nullvorgang meldet einen ungeklärten Fehler.

## 8. Aktueller Laufeintrag

- Datum: 2026-09-20
- Ausführungszahl: 1
- Ergebnis: GRÜN
- Wiederholung geplant: nein
- Sicherer Folgezustand: anschließend GPT und genau eine LUKS-Zielpartition erzeugt
