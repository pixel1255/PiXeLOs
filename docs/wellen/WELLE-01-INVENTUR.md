# Welle 1 – Inventur und Zielzuordnung

Stand: 2026-09-20
Status: Datenträger- und Bootteil grün; vollständiger Repo-/KVM-Audit vor Welle 3 nochmals erforderlich

## 1. Zweck

Diese Prüfung verhindert, dass Host und Lab-Datenträger verwechselt werden. Sie ist read-only und muss vor jeder späteren schreibenden Speicheraktion bestanden sein.

## 2. Bestätigte Zuordnung

| Rolle | Stabiler Pfad | damalige Kernelzuordnung |
| --- | --- | --- |
| PixelOS-Host | `/dev/disk/by-id/ata-INTEL_SSDSA2M160G2LE_BTPO1271014V160AGN` | `/dev/sdb` |
| SanDisk-Lab | `/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_183903802232` | `/dev/sda` |
| Host-EFI | PARTUUID `89e4198a-52a4-4bcd-8d21-422ca130c79b` | `/dev/sdb1` |
| Host-Root | UUID `2812c87f-9d4f-4b4f-a554-579a4ae40d13` | `/dev/sdb2` |

`/dev/sda` und `/dev/sdb` sind Beobachtungswerte, keine dauerhaften Identitäten.

## 3. Was wurde getestet?

- Modell, Serienkennung, Größe und stabiler by-id-Pfad beider SSDs,
- Partitionen, Dateisysteme, Labels, UUIDs und PARTUUIDs,
- aktuelle Mounts und Root-/Bootquelle,
- aktiver Swap,
- Discard-Fähigkeit,
- aktive UEFI-Bootloader nach Entfernung der alten SanDisk-Struktur.

## 4. Wie wurde getestet?

Read-only mit `lsblk`, `findmnt`, `swapon --show`, `blkid`, `/dev/disk/by-id` und `bootctl status`. Ergebnisse wurden gegeneinander geprüft; kein einzelner Anzeigename war allein entscheidend.

Die UEFI-Gegenprüfung ergab:

- `Linux Boot Manager` verweist auf die Intel-EFI-Partition,
- `Fallback Linux Boot Manager` verweist ebenfalls auf Intel,
- die frühere SanDisk-EFI-PARTUUID erscheint nicht mehr.

## 5. Wann und wie oft?

| Anlass | Häufigkeit |
| --- | --- |
| Beginn einer Lab-Arbeitssitzung | kurze Geräte-, Mount- und Mapperprüfung |
| vor jeder schreibenden Datenträgeraktion | vollständige Identitätsprüfung |
| nach Hardwareumbau oder SATA-Portwechsel | vollständige Inventur |
| nach Bootloader-/EFI-Änderung | Bootquellenprüfung |
| vor Welle 3 | vollständiger Welle-1-Audit einschließlich Git, KVM und libvirt |

## 6. Grün

- beide SSDs stimmen in stabilem Pfad, Modell und Serienkennung,
- Root und `/boot` liegen auf Intel,
- SanDisk ist das einzige freigegebene Lab-Ziel,
- keine unerwarteten Mounts oder Swap-Geräte liegen auf der SanDisk,
- Bootloader verweisen nicht auf die SanDisk.

## 7. Rot

- ein by-id-Pfad fehlt oder zeigt auf ein anderes Gerät,
- Root oder `/boot` weichen ab,
- die SanDisk ist gemountet oder als Swap aktiv,
- Modell, Serienkennung, Größe oder UUID sind unerwartet,
- ein alter SanDisk-Bootloader erscheint erneut.

Bei Rot wird keine schreibende Aktion ausgeführt.

## 8. Aktueller Laufeintrag

- Datum: 2026-09-20
- Ergebnis: Host und Ziel eindeutig getrennt
- Abweichungen: `efibootmgr` war nicht installiert; `bootctl status` lieferte die benötigte UEFI-Zuordnung
- Status: GRÜN für Datenträger und Boot
- Wiederholung: vor deklarativer Storage-Einbindung als automatisierter read-only Precheck
