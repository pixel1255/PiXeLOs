# Welle 2C – LUKS2-Container

Stand: 2026-09-20
Status: grün; Header-Backup vor wertvollen Daten noch offen

## 1. Zweck

Die Lab-Daten liegen innerhalb eines LUKS2-Containers. Entsperrt wird bewusst manuell per Passphrase. Es existiert weder Auto-Unlock noch eine Klartext-Schlüsseldatei auf dem Host.

## 2. Bestätigte Metadaten

| Feld | Wert |
| --- | --- |
| LUKS-Version | 2 |
| UUID | `ad69d3cf-31c0-4572-8d42-1eeadc49804d` |
| Label | `PIXEL_LAB_CRYPT` |
| PBKDF | Argon2id |
| Cipher | `aes-xts-plain64` |
| Schlüsselgröße | 512 Bit |
| Sektorgröße | 512 Byte |
| Datenoffset | 16777216 Byte |
| Mappername | `pixel-lab-crypt` |

## 3. Was wurde getestet?

1. LUKS2-Header wurde einmalig auf der bestätigten SanDisk-Partition erzeugt.
2. `cryptsetup isLuks` erkannte den Container.
3. Version, UUID, Label, PBKDF und Cipher wurden gelesen.
4. Der Container wurde mit der Passphrase geöffnet.
5. Mappertyp, zugrunde liegendes Gerät und Status wurden geprüft.
6. Der Mapper wurde wieder geschlossen.

Die Passphrase erschien zu keinem Zeitpunkt im Chat oder Protokoll.

## 4. Wie wird künftig geprüft?

Der spätere Wrapper muss vor dem Öffnen mindestens Folgendes beweisen:

- by-id-Pfad zeigt auf die erwartete SanDisk,
- LUKS-UUID stimmt,
- Mappername ist noch frei,
- Partition ist nicht anderweitig gemountet oder geöffnet.

Nach dem Schließen muss `/dev/mapper/pixel-lab-crypt` verschwunden sein.

Der momentan verwendete Cryptsetup-Pfad im Nix Store war nur ein temporär gebautes Werkzeug. Er darf nicht als dauerhafte Abhängigkeit in Skripte kopiert werden; die Flake muss das Werkzeug später gepinnt bereitstellen.

## 5. Wann und wie oft?

| Prüfung | Häufigkeit |
| --- | --- |
| UUID und LUKS-Typ | vor jedem Öffnen |
| Öffnen und Mapperstatus | bei jeder Nutzung |
| sauberes Schließen | am Ende jeder Nutzung |
| vollständiger Open/Close-Smoke-Test | nach Kernel-, Cryptsetup- oder Storage-Modul-Änderung |
| Metadatenprüfung | monatlich bei aktiver Nutzung und nach LUKS-Änderungen |
| LUKS-Format | genau einmal; niemals als Test wiederholen |
| Header-Backup | einmal vor wertvollen Daten und erneut nach relevanter Header-/Keyslot-Änderung |

Ein Header-Backup enthält sicherheitskritisches Schlüsselmaterial und darf nur geschützt und offline verwahrt werden. Sein Pfad und Inhalt gehören nicht ins Git oder Rohlog.

## 6. Grün

- UUID und Version stimmen,
- Passphrase öffnet den erwarteten Container,
- Mapper zeigt auf die SanDisk-Partition,
- Cipher und PBKDF entsprechen dem dokumentierten Stand,
- Mapper lässt sich sauber schließen.

## 7. Gelb

- eine Passphrase-Eingabe wird abgelehnt, anschließend gelingt die korrekte Eingabe,
- ein nur kosmetischer Anzeigename fehlt,
- das gepinnte Prüfwerkzeug muss neu gebaut werden.

## 8. Rot

- unerwartete UUID oder LUKS-Version,
- Mapper existiert bereits,
- falsches zugrunde liegendes Gerät,
- Schließen scheitert,
- Headerfehler oder unbekannte Keyslot-Änderung.

## 9. Aktueller Laufeintrag

- LUKS-Format: 1
- isolierter Open/Close-Test: 1
- Öffnungen im späteren Mount-Rundlauf: 2 erfolgreiche
- Status: GRÜN
- offener Schutzpunkt: Header-Backup vor wertvollen Lab-Daten
