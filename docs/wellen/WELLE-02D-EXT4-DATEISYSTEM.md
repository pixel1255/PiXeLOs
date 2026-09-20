# Welle 2D – ext4-Dateisystem

Stand: 2026-09-20
Status: grün

## 1. Zweck

Innerhalb des LUKS2-Mappers liegt ein einzelnes ext4-Dateisystem als Lab-Ablage. Das äußere Blockgerät bleibt `crypto_LUKS` und ist nicht direkt mountbar.

## 2. Bestätigte Metadaten

| Feld | Wert |
| --- | --- |
| Typ | ext4 |
| Label | `PIXEL_LAB` |
| UUID | `5572669d-7365-4740-baec-91e38fbef8ae` |
| Dateisystemversion | 1.0 |
| Blockgröße | 4096 Byte |
| Blöcke | 29302272 |
| Inodes | 7331840 |
| Größe | 120022106112 Byte |
| reservierte Blöcke | 0 Prozent für dieses reine Datenvolume |

Das Dateisystem wurde mit deaktiviertem initialem Discard erzeugt, weil die SSD zuvor vollständig geleert worden war und Discard nicht ungeprüft durch dm-crypt gereicht werden sollte.

## 3. Was wurde getestet?

- Mapper war geöffnet und enthielt vor dem Format keine erkennbare Dateisystemsignatur,
- ext4 wurde genau einmal erzeugt,
- Typ, Label und UUID wurden direkt am Mapper ausgelesen,
- Journal, Superblöcke und Inode-Tabellen wurden erfolgreich angelegt,
- Mapper wurde anschließend geschlossen.

## 4. Wann und wie oft?

| Prüfung | Häufigkeit |
| --- | --- |
| Typ, UUID und Label | nach jedem Öffnen vor dem Mount |
| Kapazität und freier Platz | wöchentlich bei aktiver Nutzung sowie vor großen VM-Images |
| read-only Dateisystemprüfung | nach unsauberem Ausschalten und in einem später festgelegten Wartungsintervall |
| schreibende Reparatur | nur nach ausgewertetem read-only Befund und separater Freigabe |
| `mkfs.ext4` | genau einmal; niemals als Routinetest |

Ein künftiger read-only Prüflauf darf nur bei ausgehängtem Dateisystem und geöffnetem Mapper erfolgen. Das konkrete Kommando wird erst in das Storage-Prüfskript aufgenommen, nachdem es auf dieser Konfiguration getestet wurde.

## 5. Grün

- Typ ist ext4,
- UUID und Label stimmen,
- Mountquelle ist der geprüfte LUKS-Mapper,
- keine Dateisystemfehler werden gemeldet,
- Kapazität bleibt für den geplanten Betrieb ausreichend.

## 6. Rot

- unbekannter Dateisystemtyp,
- UUID oder Label weichen ab,
- Prüfung erfolgt auf einem gemounteten Dateisystem, obwohl sie unmounted sein muss,
- I/O-, Journal-, Superblock- oder Metadatenfehler,
- unerwartet starker Kapazitätsverlust.

## 7. Aktueller Laufeintrag

- Formatierungen: 1
- Metadatenprüfung nach Format: grün
- Schreib-/Leseprüfung: siehe `WELLE-02E-MOUNT-RUNDLAUF.md`
- Status: GRÜN
- Wiederholung: kein erneutes Formatieren
