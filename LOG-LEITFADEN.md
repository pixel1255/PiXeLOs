# Pixel-Lab – Log-Leitfaden

Stand: 2026-09-20
Status: zentrale, sichtbare Prüfübersicht; keine Passwörter oder Schlüssel enthalten

## 1. Zweck

Diese Datei beantwortet für jede Lab-Schicht fünf Fragen:

1. Was wird geprüft?
2. Wie wird geprüft?
3. Wann wird geprüft?
4. Wie oft wird geprüft?
5. Woran erkennt man Grün, Gelb oder Rot?

Sie ist zugleich der Einstiegspunkt in alle wellenspezifischen Prüfdokumente. Rohprotokolle dürfen später in einem sichtbaren Verzeichnis `logs/` liegen; bereinigte Grünberichte gehören versioniert nach `docs/gruenberichte/`. Rohlogs werden nicht pauschal in Git aufgenommen.

## 2. Aktuell bestätigter Zustand

| Objekt | Bestätigter Wert |
| --- | --- |
| Hostdatenträger | `/dev/disk/by-id/ata-INTEL_SSDSA2M160G2LE_BTPO1271014V160AGN` |
| SanDisk | `/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_183903802232` |
| SanDisk-Größe | 120040980480 Byte / 234455040 Sektoren / 111,8 GiB |
| GPT-GUID | `645AB585-FD1D-4E8F-9FC0-48FCE25266C4` |
| Partitions-GUID | `c834f289-cff5-401d-a584-0899019042ed` |
| Partitionstyp | `CA7D7CCB-63ED-4C53-861C-1742536059CC` |
| PARTLABEL | `PIXEL_LAB_CRYPT` |
| LUKS-UUID | `ad69d3cf-31c0-4572-8d42-1eeadc49804d` |
| LUKS | Version 2, Argon2id, AES-XTS, manuelle Passphrase |
| ext4-UUID | `5572669d-7365-4740-baec-91e38fbef8ae` |
| ext4-Label | `PIXEL_LAB` |
| Mountpunkt | `/srv/pixel-lab` |
| geprüfte Mountoptionen | `rw,nosuid,nodev,relatime` |
| letzter Rundlauf-Hash | `155721fc8488258f204c239c2d35415647114bdd0cd467259b91c9388c798e92` |
| sicherer Endzustand | nicht gemountet; Mapper `pixel-lab-crypt` geschlossen |

Die Namen `/dev/sda` und `/dev/sda1` waren nur die damals beobachtete Kernelzuordnung. Schreibende Abläufe dürfen sich niemals allein darauf verlassen.

## 3. Dokumente je Prüfschicht

| Dokument | Inhalt | Stand |
| --- | --- | --- |
| [WELLE-01-INVENTUR.md](docs/wellen/WELLE-01-INVENTUR.md) | Host, Boot, Datenträger, Mounts und Swap | Teil der Welle 1 grün |
| [WELLE-02A-SANDISK-LOESCHUNG.md](docs/wellen/WELLE-02A-SANDISK-LOESCHUNG.md) | einmalige Entfernung der alten SanDisk-Struktur | abgeschlossen |
| [WELLE-02B-GPT-LUKS-PARTITION.md](docs/wellen/WELLE-02B-GPT-LUKS-PARTITION.md) | GPT und eine LUKS-Zielpartition | abgeschlossen |
| [WELLE-02C-LUKS2-CONTAINER.md](docs/wellen/WELLE-02C-LUKS2-CONTAINER.md) | LUKS2-Erstellung und Öffnen/Schließen | abgeschlossen |
| [WELLE-02D-EXT4-DATEISYSTEM.md](docs/wellen/WELLE-02D-EXT4-DATEISYSTEM.md) | inneres ext4-Dateisystem | abgeschlossen |
| [WELLE-02E-MOUNT-RUNDLAUF.md](docs/wellen/WELLE-02E-MOUNT-RUNDLAUF.md) | Schreiben, Schließen, Wiederöffnen und Lesen | abgeschlossen |
| [TEST-DOKU-VORLAGE.md](docs/wellen/TEST-DOKU-VORLAGE.md) | Pflichtstruktur für jede neue Schicht | bereit |

## 4. Fester Prüfrhythmus

| Zeitpunkt | Prüfung | Häufigkeit |
| --- | --- | --- |
| Beginn jeder Arbeitssitzung am Lab | Geräteidentität, Root/Boot-Quelle, aktueller Mapper- und Mountzustand | einmal pro Sitzung |
| Vor jedem Entsperren | stabiler SanDisk-Pfad, LUKS-UUID, erwarteter Mappername | jedes Mal |
| Nach jedem Mount | Quelle, ext4-UUID, Label und Mountoptionen | jedes Mal |
| Vor jedem Unmount/Close | keine laufenden Prozesse oder offenen Dateien im Mount | jedes Mal |
| Nach jedem Unmount/Close | Mount verschwunden, Mapper geschlossen | jedes Mal |
| Nach NixOS-, Kernel- oder Cryptsetup-Änderung | einmal Öffnen, UUID-Prüfung, read-only beziehungsweise kontrollierter Mount und Schließen | einmal pro relevante Änderung |
| Nach Änderung des Storage-Moduls | vollständiger Schreib-/Lese-Rundlauf | einmal pro Änderung |
| Vor einem Wellen-Commit | Quell-Audit, Flake-Check, wellenspezifische Positiv- und Negativtests | einmal pro Commitkandidat |
| Nach unerwartetem Ausschalten | nicht sofort schreibend mounten; erst Zustand und Dateisystem read-only prüfen | jedes Ereignis |
| Bei aktiver Nutzung | kurzer Gesundheits- und Kapazitätscheck | wöchentlich |
| SSD-Gesundheit | SMART-Auswertung, sobald das dafür gewählte deklarative Werkzeug eingebaut ist | monatlich und nach I/O-Fehlern |
| Löschen, Partitionieren, LUKS-Format, mkfs | niemals als Routine wiederholen | nur bei bewusst freigegebenem Neuaufbau |

„Wöchentlich“ bedeutet nur während das Lab aktiv benutzt wird. Ein ausgeschaltetes, unverändertes Lab braucht keine künstlichen Testläufe.

## 5. Ergebnisstufen

### Grün

- alle erwarteten Identitäten stimmen,
- nur erwartete Geräte, Mounts und Mapper sind sichtbar,
- Positiv- und Negativtest bestehen,
- keine unerwarteten Fehler, offenen Dateien oder Dienste bleiben zurück,
- der Endzustand entspricht dem Plan,
- ein bereinigter Ergebnisblock ist dokumentiert.

### Gelb

- der Haupttest ist erfolgreich, aber eine erklärbare Warnung bleibt offen,
- ein optionales Werkzeug fehlt,
- ein Test musste wegen Tippfehler oder falscher Passphrase wiederholt werden,
- keine Daten- oder Sicherheitsabweichung wurde festgestellt.

Gelb wird dokumentiert und vor dem Commit bewertet. Es wird nicht heimlich zu Grün erklärt.

### Rot

- Modell, Serienkennung, UUID, PARTUUID oder Mountquelle weichen ab,
- Root oder Boot liegen unerwartet auf einem anderen Gerät,
- ein Ziel ist bereits gemountet, geöffnet oder enthält unbekannte Daten,
- Hash, Dateisystemtyp oder Label stimmen nicht,
- nach dem Test bleiben Mapper, Mount oder unerwartete Prozesse bestehen.

Bei Rot gilt: stoppen, nichts reparieren oder wiederholen, bevor Ursache und Rückweg verstanden sind.

## 6. Was niemals protokolliert wird

- Passphrasen oder Teile davon,
- Schlüsseldateien oder LUKS-Header-Backups,
- API-Tokens, Cookies, private Schlüssel oder Browserprofile,
- unbereinigte Home-Verzeichnislisten,
- Windows-Produktschlüssel oder proprietäre Treiberdateien,
- vollständige Inhalte privater Dateien.

UUIDs, Labels, Prüfsummen eigener Testdateien und Hardware-Serienkennungen dürfen in der lokalen technischen Dokumentation stehen. Vor externer Veröffentlichung werden sie erneut bewertet.

## 7. Namensschema für spätere Logs

Ein maschinenlesbarer Lauf erhält später einen sichtbaren Namen nach diesem Muster:

`YYYYMMDD-HHMM-WELLE-XX-TESTNAME.log`

Der zugehörige bereinigte Grünbericht heißt:

`YYYYMMDD-WELLE-XX-GRUENBERICHT.md`

Ein Log wird nie überschrieben. Wiederholungen erhalten `-r02`, `-r03` und so weiter. Geheimnisse werden nicht nachträglich „weggefiltert“, sondern dürfen gar nicht erst in das Rohlog gelangen.

## 8. Vorlage für einen Laufeintrag

### Identität

- Datum und lokale Uhrzeit:
- Welle und Test:
- Git-Commit vor dem Test:
- Hostgeneration:
- Anlass:

### Erwartung

- erwartete Geräte:
- erwartete UUIDs:
- erwarteter Startzustand:
- erwarteter Endzustand:

### Ergebnis

- Positivtest:
- Negativtest:
- Abweichungen:
- verbleibende Prozesse, Mapper, Mounts oder Ports:
- Status: GRÜN / GELB / ROT

### Freigabe

- Grünbericht geprüft:
- Commit erlaubt:
- Commit-ID:
- optionaler Green-Tag:

## 9. Chronik bis 2026-09-20

| Schritt | Ausführung | Ergebnis |
| --- | --- | --- |
| Geräte-, Mount-, Swap- und Bootinventur | mehrfach read-only gegengeprüft | Intel als Host und SanDisk als Ziel eindeutig |
| SanDisk-Discard und Randnullung | genau einmal | alte Partitionen, Signaturen und Bootstruktur entfernt |
| UEFI-Gegenprüfung | einmal nach Löschung | aktive Bootloader verweisen ausschließlich auf Intel-EFI |
| GPT-Simulation | einmal | direkte LUKS-GUID akzeptiert; keine Änderung |
| GPT-Schreibvorgang | genau einmal | eine LUKS-Zielpartition, `sfdisk --verify` grün |
| LUKS2-Format | genau einmal | LUKS2, Argon2id und Label bestätigt |
| LUKS Öffnen/Schließen | einmaliger Test | Passphrase funktioniert, Mapper anschließend geschlossen |
| ext4-Format | genau einmal | Label und UUID bestätigt |
| Mount-Rundlauf | ein vollständiger Lauf mit zwei Öffnungen | identischer SHA-256 vor und nach Wiederöffnung |
| Authentifizierungswiederholung | ein falscher Versuch im ersten Rundlauf | erwartbar abgelehnt; danach erfolgreich, keine Datenabweichung |
| Abschlusskontrolle | einmal | Testdatei entfernt, unmounted, LUKS geschlossen |

## 10. Noch offene Punkte der Welle 2

- deklaratives NixOS-Modul für kontrolliertes manuelles Öffnen, Mounten und Schließen,
- kurze, selbstprüfende Storage-Kommandos aus der gepinnten Flake,
- Grundverzeichnisse und klare Eigentümer auf `PIXEL_LAB`,
- geschütztes, offline verwahrtes LUKS-Header-Backup vor wertvollen Daten,
- read-only Dateisystemprüfung und SMART-Prüfung als reproduzierbare Tests,
- Grünbericht und ausdrücklich freigegebener Git-Commit.

Bis diese Punkte gebaut sind, bleibt die SanDisk standardmäßig geschlossen und ungemountet.
