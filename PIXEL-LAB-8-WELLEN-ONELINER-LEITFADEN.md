# Pixel-Lab – 8-Wellen-Oneliner-Leitfaden

Stand: 2026-09-20
Status: Welle 1 ist für Datenträger und Bootzuordnung praktisch geprüft. Die physische Basis von Welle 2 ist grün; ihre deklarative Einbindung und ihr Git-Commit sind noch offen. Wellen 3 bis 8 wurden noch nicht gebaut.

## 0. Reeller Fortschritt

| Bereich | Stand | Ergebnis |
| --- | --- | --- |
| Intel-Systemplatte | geprüft | Host bleibt auf `ata-INTEL_SSDSA2M160G2LE_BTPO1271014V160AGN`; Root und EFI wurden nicht verändert |
| SanDisk-Identität | geprüft | `ata-SanDisk_SSD_PLUS_120GB_183903802232`, 120040980480 Byte |
| Alte SanDisk-Struktur | einmalig entfernt | vollständiger SSD-Discard sowie Anfang und Ende genullt; danach keine Partition und keine Signatur |
| GPT | grün | Datenträger-GUID `645AB585-FD1D-4E8F-9FC0-48FCE25266C4` |
| LUKS-Zielpartition | grün | PARTUUID `c834f289-cff5-401d-a584-0899019042ed`, PARTLABEL `PIXEL_LAB_CRYPT` |
| LUKS2 | grün | UUID `ad69d3cf-31c0-4572-8d42-1eeadc49804d`, Argon2id, manuelle Passphrase |
| ext4 | grün | UUID `5572669d-7365-4740-baec-91e38fbef8ae`, Label `PIXEL_LAB` |
| Schreib-/Lese-Rundlauf | grün | identischer SHA-256 vor und nach Schließen und Wiederöffnen |
| Endzustand | sicher | `/srv/pixel-lab` vorhanden, aber nicht gemountet; LUKS-Mapper geschlossen |
| Automatisierung | offen | noch kein Auto-Unlock, Auto-Mount, Schlüsseldatei oder Hostmodul |

Die einzelnen Beweise, Wiederholungszeitpunkte und Häufigkeiten stehen im sichtbaren `LOG-LEITFADEN.md` und in den wellenspezifischen Prüfdokumenten.

## 1. Ziel

Auf der separaten SanDisk entsteht ein verschlüsseltes, vom PixelOS-Host klar getrenntes Labor. Es enthält:

- eine eigene Lab-Flake,
- eine minimale Console-VM,
- eine Windows-Hotspot-VM für den FRITZ!WLAN USB Stick,
- eine wegwerfbare Builder-VM,
- eine schmale Sicherheits- und Ereignisleitung,
- zuletzt zwei kleine KI-Rollen, einen größeren Analysten und den grafischen Pixel Observer.

PixelOS auf der Intel-SSD bleibt der kleine, nachvollziehbare Host. Es erhält nur die Funktionen, die zwingend auf der Hypervisor-Ebene liegen müssen.

## 2. Nicht verhandelbare Grenzen

1. Kein Host-Pfad und kein Datenträger wird anhand von `/dev/sdX` verändert. Schreibende Aktionen verwenden erst nach Gegenprüfung einen stabilen `/dev/disk/by-id/...`-Pfad und die gemessene UUID.
2. Die SanDisk wird weder partitioniert noch formatiert, bevor Bestand, Backupbedarf und exakte Geräteidentität geklärt sind.
3. Keine KI erhält den libvirt-Socket, einen Host-Shellzugang oder Schreibzugriff auf PixelOS.
4. Keine VM erhält das vollständige `/home`, den Host-Nix-Store, Browserprofile, Schlüssel, Cookies oder Tokens.
5. Die Builder-KI darf nur innerhalb einer wegwerfbaren Builder-VM weitreichende Rechte erhalten.
6. Die Windows-VM erhält ausschließlich die ausdrücklich benötigte virtuelle Netzwerkkarte und den FRITZ!WLAN USB Stick.
7. Modelle, ISO-Dateien, Windows-Datenträger, proprietäre AVM-Dateien, Passwörter und andere große oder geheime Laufzeitdaten kommen niemals in Git.
8. Keine Welle wird automatisch committed. Erst der Mensch bestätigt den grünen Zustand.
9. Ein fehlgeschlagener Test, eine unklare Gerätezuordnung oder eine unerwartete Änderung bedeutet: Stopp, dokumentieren, nicht committen.
10. Die visuelle Oberfläche und die KI kommen zuletzt. Zuerst müssen Isolation, Lebenszyklus und Tests ohne KI funktionieren.

## 3. Flake und Tunnel sind verschiedene Ebenen

Die PixelOS-Flake konfiguriert den Host. Die Lab-Flake auf der SanDisk baut und beschreibt die Gäste. Beide werden unabhängig gelockt und geprüft.

Zur Laufzeit „tunneln“ nicht die Flakes miteinander. Der Datenaustausch erfolgt über ein kleines versioniertes Protokoll, bevorzugt über `AF_VSOCK`:

```text
PixelOS-Sensor ── strukturierte Ereignisse ──> Console-VM
Console-VM ── fest definierte Anfrage ──> Host-Broker
Host-Broker ── nur nach Regel/Freigabe ──> bekannte Schwester-VM
```

Der Broker akzeptiert keine frei formulierten Shellbefehle. Er kennt nur vorher festgelegte Aktionen wie `status`, `start-hotspot`, `start-builder`, `stop-builder` und `export-review`.

## 4. Arbeitsrhythmus jeder Welle

Jede Welle besitzt dieselbe Reihenfolge:

1. **Lesen:** Ist-Zustand, Git-Status, Datenträger und Abhängigkeiten prüfen.
2. **Plan zeigen:** betroffene Dateien und genaue Wirkung vor dem Schreiben anzeigen.
3. **Bauen:** ausschließlich die Dateien dieser Welle ändern.
4. **Quellprüfung:** Format, Syntax, Geheimnisse, verbotene Pfade und unerwartete Kopplungen prüfen.
5. **Flake-Prüfung:** Flake evaluieren und alle Checks ausführen.
6. **Isolationstest:** Gast oder Hoständerung zunächst vergänglich testen.
7. **Grünbericht:** Soll/Ist, offene Warnungen und Rückweg dokumentieren.
8. **Commit:** nur explizit ausgewählte Dateien committen; danach optional einen Green-Tag setzen.

Die später gebauten kurzen Befehle folgen diesem Muster:

```text
nix run .#welle-XX-audit
nix flake check
nix run .#welle-XX-test
git status --short
```

Die echten App-Namen werden erst angelegt, wenn das aktuelle Repository vorliegt. Bis dahin sind diese Zeilen Zielnamen und keine bereits vorhandenen Befehle.

Für Hoständerungen gilt zusätzlich:

```text
nixos-rebuild build
→ Test in VM, soweit möglich
→ nixos-rebuild test auf dem Host
→ Grünbericht
→ Git-Commit
→ erst danach dauerhaft switchen
```

Es wird niemals blind `git add -A` verwendet. Jede Welle nennt ihre eigenen Commit-Dateien.

---

## Welle 1 – Bestand, Geräteidentität und rote Linien

**Ist-Stand 2026-09-20:** Datenträger-, Mount-, Swap- und Bootzuordnung wurden am echten Host geprüft. Vor Welle 3 werden Git-Bestand, KVM/libvirt und der dann aktuelle Quellbaum nochmals als eigener reproduzierbarer Auditlauf erfasst.

### Ziel

Der komplette Startzustand ist bekannt, ohne etwas am System oder an der SanDisk zu verändern.

### Inhalt

- aktuellen PixelOS-Quellbaum und Git-Status erfassen,
- Intel-SSD und SanDisk über Modell, Serienkennung, Größe, Partitionen, Dateisysteme, UUIDs und `/dev/disk/by-id` eindeutig zuordnen,
- aktuelle Mounts und Bootquelle bestätigen,
- KVM, libvirt, QEMU, IOMMU/VT-x und verfügbare Ressourcen erfassen,
- FRITZ!WLAN USB Stick mit beiden bekannten USB-IDs dokumentieren,
- prüfen, ob auf der SanDisk Daten erhalten werden müssen,
- vorhandene Leitfäden und frühere Lab-Dateien zuordnen,
- sensible Werte aus dem Bericht entfernen.

### Geplante Dateien

```text
docs/wellen/WELLE-01-INVENTUR.md
scripts/wellen/01-readonly-audit.sh
tests/wellen/01-audit-test.sh
```

### Geplanter Oneliner

```text
nix run .#welle-01-audit
```

Dieser Befehl muss garantiert read-only sein und darf kein `sudo` benötigen.

### Grün, wenn

- Host-SSD und Lab-SSD nicht verwechselt werden können,
- Bootdatenträger und Root-Dateisystem zweifelsfrei feststehen,
- der Zustand der SanDisk und der Erhaltungsbedarf geklärt sind,
- KVM funktioniert,
- der Quellbaum bekannt und unerwartete lokale Änderungen dokumentiert sind,
- der Bericht keine Geheimnisse enthält.

### Commit-Ziel

Nur Audit-Skript, Test und bereinigte Dokumentation. Keine Rohlogs mit privaten Daten.

### Abbruch

Bei unklarer Gerätezuordnung, unbekannten bestehenden Daten, fehlendem Backup oder überraschendem Git-Status wird Welle 2 nicht begonnen.

---

## Welle 2 – SanDisk als verschlüsselte Lab-Ablage

**Ist-Stand 2026-09-20:** Löschen, GPT, LUKS2, ext4 sowie ein vollständiger Mount-/Schreib-/Lese-/Unmount-/Wiederöffnungstest sind grün. Noch offen sind das deklarative Hostmodul, kurze Prüfprogramme, die Grundverzeichnisse auf dem Datenträger und der freigegebene Git-Commit.

### Ziel

Die SanDisk erhält eine eindeutige, verschlüsselte und reproduzierbar eingehängte Ablage für das Labor.

### Entscheidung vor dem Bau

- **Variante A:** Die SanDisk darf vollständig neu eingerichtet werden.
- **Variante B:** Vorhandene Daten müssen erhalten bleiben. Dann wird in dieser Welle nicht spontan verkleinert oder umpartitioniert; zunächst entsteht ein eigener Sicherungs- und Migrationsplan.

### Inhalt

- exakten stabilen Gerätepfad aus Welle 1 erneut prüfen,
- bei freigegebener Variante A: GPT/LUKS2/Dateisystem planen,
- Entsperrung zunächst bewusst manuell halten,
- Mount ausschließlich über UUID beziehungsweise Mapper-Namen definieren,
- Eigentümer, Rechte und sichere Mountoptionen setzen,
- Grundverzeichnisse für Flake, Images, Modelle, Overlays, Ereignisse und Review anlegen,
- Host-SSD vor und nach der Aktion unverändert nachweisen.

### Zielstruktur

```text
pixel-lab/
├── source/
├── images/
├── models/
├── overlays/
├── events/
├── review/
└── backups/
```

### Geplante Dateien

```text
docs/wellen/WELLE-02-SANDISK.md
scripts/wellen/02-storage-precheck.sh
scripts/wellen/02-storage-verify.sh
modules/host/pixel-lab-storage.nix
tests/wellen/02-storage-test.sh
```

### Geplanter sicherer Oneliner

```text
nix run .#welle-02-precheck
```

Welle 2 bekommt absichtlich **keinen destruktiven Mega-Oneliner**. Partitionierung und LUKS-Erstellung werden erst nach Ausgabe und Gegenprüfung des exakten Geräts in kleinen, einzeln bestätigten Schritten ausgeführt.

### Grün, wenn

- LUKS2 korrekt erkannt wird,
- die Ablage nach manuellem Entsperren am vorgesehenen Ort erscheint,
- ein Schreib-/Lese-/Unmount-/Remount-Test funktioniert,
- der Host auch ohne entsperrte SanDisk normal startet,
- Intel-SSD, EFI und PixelOS unverändert sind,
- keine Schlüsseldatei unverschlüsselt auf dem Host liegt.

### Commit-Ziel

Nur Modul, Prüfskripte und Dokumentation. Keine UUID wird eingetragen, bevor sie real gemessen wurde.

### Abbruch

Bei jeder Abweichung von Modell, Größe, Serienkennung, Partitionstabelle oder stabilem Gerätepfad wird nicht geschrieben.

---

## Welle 3 – Eigenständige Lab-Flake und Shell-Steuerung

### Ziel

Auf der SanDisk entsteht eine eigenständige, kleine Flake. Sie enthält noch keine KI, keine grafische Oberfläche und keine Windows-Dateien.

### Inhalt

- eigenes `flake.nix` und `flake.lock`,
- gemeinsame minimale Gastbasis,
- deklarative Verzeichnis- und Image-Metadaten,
- `labctl` zunächst nur mit `status`, `doctor` und `list`,
- Quell-Audit gegen Hostpfade, alte UUIDs, Secrets und unerlaubte Shares,
- Checks, die ohne gestartete VM laufen,
- klare Trennung: Die PixelOS-Flake importiert nicht unbemerkt die gesamte Lab-Flake.

### Zielbaum

```text
pixel-lab/source/
├── flake.nix
├── flake.lock
├── README.md
├── hosts/
│   ├── console/
│   └── builder/
├── modules/
│   ├── common/
│   ├── isolation/
│   └── transport/
├── packages/
│   └── labctl/
├── scripts/
│   └── wellen/
├── tests/
│   └── wellen/
└── docs/
    └── wellen/
```

### Geplanter Oneliner

```text
nix run .#welle-03-check
```

### Grün, wenn

- `nix flake check` ohne implizite Internet- oder Hostabhängigkeit grün ist,
- der lokale Lock reproduzierbar verwendet wird,
- `labctl status` ohne Rootrechte funktioniert,
- keine VM und kein Port automatisch gestartet wird,
- kein Modell, Token, ISO oder fremder Binärtreiber im Quellbaum liegt.

### Commit-Ziel

Die vollständige, aber noch funktionsarme Lab-Flake als erstes sauberes Fundament.

---

## Welle 4 – Minimale Console-VM ohne KI und Grafik

### Ziel

Die erste NixOS-Gastmaschine bootet reproduzierbar von der SanDisk und bietet nur eine lokale Textkonsole.

### Inhalt

- minimale NixOS-Console-VM,
- zunächst konservatives RAM-/CPU-Profil,
- lokale TTY-Anmeldung ohne Hostpasswort und ohne Netzwerk-Login,
- SSH, geteilter Host-Nix-Store, `/home`-Share, Clipboard, Kamera, Mikrofon und USB deaktiviert,
- serielle Konsole und begrenztes Gast-Journal,
- Netzwerk zuerst aus oder streng beschränkt,
- sauberer Start/Stopp/Status über `labctl`,
- noch kein Firefox, keine KI und kein Pixel Observer.

### Geplante Dateien

```text
hosts/console/default.nix
modules/common/base.nix
modules/isolation/console.nix
tests/wellen/04-console-vm-test.nix
docs/wellen/WELLE-04-CONSOLE-VM.md
```

### Geplanter Oneliner

```text
nix run .#welle-04-test-console
```

### Grün, wenn

- die VM bootet und sauber herunterfährt,
- die lokale Shell funktioniert,
- im Gast keine Host-Datenträger oder Hostverzeichnisse erscheinen,
- vom Gast kein Hostdienst erreichbar ist,
- nach dem Stoppen keine verwaisten QEMU-Prozesse oder offenen Sockets bleiben,
- das Ressourcenprofil den Host nicht ins Swapping zwingt.

### Commit-Ziel

Console-Gast, Isolation und automatisierter Boot-/Shutdown-Test.

---

## Welle 5 – Windows-Hotspot-VM als abgeschlossene Appliance

### Ziel

Eine eigenständige Windows-VM erhält Internet vom Host und reicht es ausschließlich über den FRITZ!WLAN USB Stick als Hotspot weiter.

### Inhalt

- QEMU/libvirt-Definition mit UEFI und den für Windows 11 nötigen virtuellen Komponenten,
- eigenes virtuelles Laufwerk auf der SanDisk,
- virtuelle Netzwerkkarte als Eingang,
- exklusives USB-Passthrough für den FRITZ!WLAN Stick,
- Behandlung der USB-Umschaltung `057c:62ff` → `057c:8602`,
- keine Hostordner, kein Clipboard, kein Audio, keine Kamera und kein Mikrofon,
- lokale, geheimnisfreie Anmeldung; keine Zugangsdaten im Git,
- AVM-Treiber und Windows-Medium nur lokal, nicht im Repository,
- begrenzter Logausgang; keine Steuerleitung zum Host,
- Start, Status und Stopp über feste Brokeraktionen.

### Geplante Dateien

```text
vm-definitions/windows-hotspot/
modules/host/pixel-vm-broker-hotspot.nix
scripts/wellen/05-hotspot-smoke-test.sh
docs/wellen/WELLE-05-WINDOWS-HOTSPOT.md
```

### Geplanter Oneliner

```text
nix run .#welle-05-test-hotspot
```

Der Befehl testet nur bekannte Zustände. Windows-Installation und AVM-Treiberinstallation bleiben sichtbar geführte Schritte.

### Grün, wenn

- Windows reproduzierbar startet,
- der Stick innerhalb der VM nach dem Moduswechsel stabil erscheint,
- Windows die benötigte Hotspot-Funktion mit diesem Stick tatsächlich anbietet,
- ein separates Testgerät den Hotspot sieht, verbindet und Internet erreicht,
- PixelOS den Stick währenddessen nicht selbst bindet,
- Stop/Start und ein vollständiger Neustart erneut funktionieren,
- keine unerwartete Hostfreigabe entstanden ist.

### Commit-Ziel

Nur Domain-/Brokerdefinition, Tests und Dokumentation. Keine VM-Disk, ISO, Firmware oder proprietäre Treiberdatei.

### Abbruch

Wenn USB-Reenumeration, AVM-Treiber oder Windows-Hotspot mit diesem Gerät nicht stabil funktionieren, bleibt die Welle offen. Es wird keine Scheinlösung nach oben weitergebaut.

---

## Welle 6 – Wegwerfbare Builder-VM und Review-Schleuse

### Ziel

Experimente dürfen innerhalb eines frischen Overlays weitreichende Rechte haben, ohne den Host oder die Basis zu verändern.

### Inhalt

- unveränderliche Builder-Basis,
- pro Versuch ein neues `qcow2`-Overlay,
- Terminal und Buildwerkzeuge, aber noch keine KI,
- standardmäßig kein Netzwerk,
- kein Hostdateisystem, kein USB und kein libvirt-Socket,
- Eingabe nur als bewusst erzeugtes, read-only Jobpaket,
- Ausgabe ausschließlich in die Review-Schleuse,
- Exportformat: Patch, Dateiliste, Prüfsummen, Build- und Testprotokoll,
- sichere Löschung eines einzelnen Overlays erst nach expliziter Zielprüfung.

### Geplante Dateien

```text
hosts/builder/default.nix
modules/isolation/builder.nix
packages/labctl/builder-lifecycle.*
tests/wellen/06-builder-disposable-test.*
docs/wellen/WELLE-06-BUILDER.md
```

### Geplanter Oneliner

```text
nix run .#welle-06-test-builder
```

### Grün, wenn

- ein frisches Overlay erstellt und eindeutig benannt wird,
- Änderungen im Gast sichtbar sind,
- die Basis-Prüfsumme unverändert bleibt,
- ein zweiter frischer Gast die Änderungen des ersten nicht kennt,
- keine Hostgeräte oder Hostpfade sichtbar sind,
- der Export nur erlaubte Dateitypen und begrenzte Größen akzeptiert,
- das exakt bezeichnete Testoverlay gefahrlos entfernt werden kann.

### Commit-Ziel

Builder-Konfiguration, Lifecycle-Werkzeug, Review-Schema und Isolationstests.

---

## Welle 7 – Sicherheitsleitung, Sensoren und enger VM-Broker

### Ziel

Host und Console-VM tauschen nur streng validierte Ereignisse und Anfragen aus. Noch entscheidet keine KI.

### Inhalt

- versioniertes JSON-Ereignisschema,
- Host-Sensor für ausgewählte systemd-, Netzwerk-, NixOS- und VM-Zustände,
- Benutzer-Sensor für Metadaten ausgewählter Home-Bereiche,
- Vergleich gegen einen bestätigten grünen Ausgangszustand,
- Erkennung neuer Autostarts, ausführbarer Dateien, Rechte-/Besitzerwechsel und neuer Listener,
- keine Übertragung von Cookies, Tokens, Browserprofilen oder vollständigen Dateiinhalten,
- `AF_VSOCK` mit Größen-, Typ- und Ratenbegrenzung,
- Broker mit fester Aktionsliste und menschlicher Bestätigung,
- Dummy-Ereignissenke in der Console-VM,
- vollständige Negativtests gegen freie Kommandos und fehlerhafte Nachrichten.

### Geplante Dateien

```text
modules/host/pixel-sensor.nix
modules/host/pixel-vm-broker.nix
modules/transport/vsock.nix
packages/pixel-event-schema/
packages/pixel-event-sink/
tests/wellen/07-safety-bridge-test.*
docs/wellen/WELLE-07-SAFETY-BRIDGE.md
```

### Geplante Oneliner

```text
nix run .#welle-07-protocol-test
nix run .#welle-07-isolation-test
```

### Grün, wenn

- erlaubte Testereignisse unverändert ankommen,
- übergroße, fehlerhafte und unbekannte Ereignisse verworfen werden,
- Rate-Limits einen Gast nicht den Host fluten lassen,
- die Console-VM keine freien Hostkommandos auslösen kann,
- nur bekannte VM-Namen angefragt werden können,
- der Broker weder libvirt-Socket noch Shell weiterreicht,
- der Host auch bei gestoppter Console-VM weiter protokolliert,
- alle Hoständerungen mit `nixos-rebuild test` wieder verschwinden können.

### Commit-Ziel

Protokoll, Sensor, Broker, Dummy-Empfänger, Negativtests und Grünbericht.

---

## Welle 8 – KI-Rollen und Pixel Observer zuletzt

Diese Abschlusswelle hat zwei getrennte Landungen. Beide brauchen ihren eigenen grünen Test und eigenen Commit, obwohl sie zur gleichen obersten Welle gehören.

### Welle 8A – KI-Laufzeit

#### Ziel

Zwei kleine Rollen und ein größerer Analyst arbeiten innerhalb der Console-VM, ohne Hostrechte und ohne direkte Aktionswerkzeuge.

#### Inhalt

- kleiner Watcher für strukturierte Ereignisse,
- kleiner Coder für Nix/Bash/Debugging,
- größerer Analyst für ausdrücklich angeforderte Tiefenanalyse,
- Modelle ausschließlich auf der SanDisk,
- Modellmanifest mit Quelle, Lizenz, Version, Prüfsumme und Quantisierung,
- kein Hugging-Face- oder anderer Downloadtoken auf dem Host,
- Speicherwächter und gegenseitige Ausschlüsse: Nicht alle Modelle rechnen gleichzeitig,
- Watcher verarbeitet eine Warteschlange; die deterministische Erfassung läuft unabhängig weiter,
- strukturierte Antworten: Schweregrad, Begründung, vorgeschlagene Prüfung,
- keine Shell-, Datei-, Browser- oder VM-Werkzeuge für das Modell,
- Tests ausschließlich mit synthetischen Ereignissen, bevor echte Ereignisse freigegeben werden.

#### Geplanter Oneliner

```text
nix run .#welle-08a-test-ai
```

#### Grün, wenn

- jedes Modell separat startet und wieder vollständig freigibt,
- Speicher- und CPU-Grenzen eingehalten werden,
- der Host nicht in eine Swap-Spirale gerät,
- manipulierte Ereignistexte keine Aktion auslösen,
- das Modell nur Vorschläge produziert,
- bei Modellabsturz Sensor, Queue und Host weiterlaufen.

#### Commit-Ziel

Modellmanager, Rollenprofile, Manifestschema und synthetische Tests. Keine Modellgewichte.

### Welle 8B – Pixel Observer, Terminal und Web-Prüfung

#### Ziel

Die Console-VM erhält das grafische Popup mit Tabs, ohne dass die Oberfläche zur Host-Steuerzentrale mit freien Rechten wird.

#### Inhalt

- Pixel Observer als leichtes natives Qt/QML-Fenster,
- Tabs für Überblick, Netzwerk, Dienste, VMs, Watcher, Builder und Review,
- normales Terminal in der Console-VM,
- getrennte Chatansichten für Watcher, Coder und Analyst,
- Startanfragen nur über den festen Brokerdialog,
- Firefox innerhalb der Console-VM zunächst streng getrennt vom Watcher,
- Webseiteninhalt gelangt nur nach ausdrücklichem „Prüfen“ als markierter, nicht vertrauenswürdiger Text zum Analysten,
- Downloads landen in Quarantäne und werden niemals automatisch ausgeführt,
- Pause stoppt nur die Darstellung, nicht die Ereigniserfassung,
- keine versteckten automatischen Reparaturen.

#### Geplanter Oneliner

```text
nix run .#welle-08b-test-observer
```

#### Grün, wenn

- alle Tabs mit künstlichen und anschließend echten Testereignissen funktionieren,
- Pause, Start, Stop und erneutes Verbinden keine Ereignisse verlieren,
- die Oberfläche ohne Rootrechte läuft,
- Firefox keinen direkten Kanal zum Watcher oder Broker besitzt,
- Fenster schließen weder Sensor noch Hotspot beendet,
- Ressourcenverbrauch auf dem i3-4130 mit 15 GiB RAM akzeptabel bleibt,
- der gesamte Stack nach Neustart reproduzierbar ist,
- jede gewünschte Hoständerung weiterhin deine ausdrückliche Entscheidung verlangt.

#### Commit-Ziel

Observer, lokale Terminal-/Chatoberfläche, Web-Handoff und UI-Tests.

---

## 5. Betriebsprofile für die aktuelle Hardware

Auf dem aktuellen Core i3-4130 mit 2 Kernen/4 Threads und 15 GiB RAM dürfen alle Komponenten definiert, aber nicht alle gleichzeitig unter Volllast betrieben werden.

### Schutzbetrieb

```text
PixelOS + Console-VM/Watcher + Windows-Hotspot
```

Der Coder und große Analyst schlafen.

### Baubetrieb

```text
PixelOS + Console-VM/Watcher + Builder-VM
```

Der größere Analyst wird nur bei Bedarf geladen. Falls der Hotspot parallel benötigt wird, erhält Modellinferenz niedrigere CPU-/I/O-Priorität.

### Tiefenanalyse

```text
PixelOS + Console-VM + großer Analyst
```

Keine parallele schwere Builder-Kompilierung. Swap wird nicht als zusätzlicher Arbeitsspeicher eingeplant.

## 6. Einheitliche Grünprüfung vor jedem Commit

Die genaue Kommandofolge wird pro Welle erzeugt. Inhaltlich muss sie immer Folgendes beweisen:

```text
1. Arbeitsbaum vor der Welle bekannt
2. nur erwartete Dateien verändert
3. git diff --check grün
4. Quell-Audit grün
5. nix flake check grün
6. wellenspezifischer Build grün
7. Positivtest grün
8. Negativ-/Isolationstest grün
9. keine neuen unerwarteten Ports oder Dienste
10. Grünbericht geschrieben
11. explizite menschliche Commit-Freigabe
```

Empfohlenes Commit-Schema:

```text
lab(w01): document verified hardware baseline
lab(w02): add encrypted lab storage layer
lab(w03): add standalone lab flake skeleton
lab(w04): add isolated console vm
lab(w05): add windows hotspot appliance
lab(w06): add disposable builder lifecycle
lab(w07): add constrained safety event bridge
lab(w08a): add local model roles
lab(w08b): add pixel observer interface
```

Nach jedem grünen Commit kann zusätzlich ein lokaler, sprechender Tag gesetzt werden, beispielsweise `pixel-lab-w04-green`. Das Tagging wird nicht automatisiert.

## 7. Was für den echten Build in Work benötigt wird

Für die Umsetzung reichen folgende Übergaben:

1. das aktuelle PixelOS-/`pixel-local-lab`-Repository als Archiv oder freigegebener Projektordner,
2. der bisherige Oneliner-Leitfaden, falls dessen genaue Form beibehalten werden soll,
3. gegebenenfalls die aktuelle `/etc/nixos`-Quelle, falls sie vom Repository abweicht,
4. in Welle 1 erzeugte, bereinigte Hardware- und Datenträgerausgabe.

Nicht benötigt und nicht erwünscht sind:

- Passwörter,
- private Schlüssel,
- API-Tokens,
- Browserprofile oder Cookies,
- das vollständige Home-Verzeichnis,
- Windows-Produktschlüssel,
- proprietäre Treiberdateien,
- Modellgewichte im Chat oder Git.

## 8. Fortsetzungsregel

Die physische Speicherbasis von Welle 2 wird nicht erneut erzeugt. Der nächste Build beginnt mit einer read-only Gegenprüfung der gemessenen UUIDs und erstellt anschließend ausschließlich die noch fehlenden deklarativen Teile von Welle 2. Erst nach reproduzierbarem Audit, Flake-Test, Grünbericht und deiner ausdrücklichen Commit-Freigabe beginnt Welle 3.
