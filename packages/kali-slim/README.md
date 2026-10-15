# Schlanke Kali-VM

Co-Created by Pixel1255, Anti-Gravity Gemini & ChatGPT (GxG-Prozess)

Zweck und vereinbarter Nutzungsumfang stehen in
[VERWENDUNGSZWECK.md](VERWENDUNGSZWECK.md). Diese Beschreibung kann auch
als lesbare Begleitdatei neben der lokalen VM-Platte abgelegt werden.

Die Flake baut den QEMU-Starter und stellt einen nach SHA256 festgelegten
offiziellen Kali-NetInstaller bereit. Der Gast wird mit dem Kali-Installer
installiert. Ein reproduzierbarer Nix-Starter bedeutet dabei nicht, dass die
spaeter von Kali Rolling geladenen Pakete unveraenderlich festgelegt sind.

Das Paket `kali-slim` ergänzt die Flake um einen eigenständigen QEMU/KVM-Gast.
Der Host-Alias `kali` startet diese VM offline. Die separate Ausgabe
`nixosConfigurations.kali-audit` und die Libvirt-Aliasse bleiben als frühere
Testkonfiguration erhalten; sie beschreiben nicht die installierte Kali-Slim-VM.
Die festen `p`-Passwortzuweisungen wurden aus diesem Testgast entfernt. Es
wurden dort keine neuen Zugangsdaten eingerichtet; die Ausgabe ist daher nicht
als einsatzbereite oder anmeldefähige VM dokumentiert. Hostkonto und installierte
Kali-VM werden dadurch nicht umkonfiguriert.

## Ressourcen und Grenzen

- 4096 MiB RAM, zwei virtuelle CPUs, neue virtuelle Platte mit 30 GiB.
- Platte: `~/kali-audit-lab/kali-slim/disk.qcow2`; wird nur durch `init` angelegt.
- Eine vorhandene Platte wird nicht automatisch ersetzt oder vergroessert.
- Die fertige `lab`-VM und die alte NixOS-Testplatte werden nicht eingebunden.
- `boot` hat keine Netzwerkkarte. `install` und `boot-online` verwenden QEMU-NAT.
- NAT erlaubt dem Gast auch den Zugriff auf erreichbare Host-/LAN-Dienste;
  es ist keine vollstaendige Netzisolation. Es gibt keine Portweiterleitungen.
- Es werden keine Host-Verzeichnisse oder physischen Geraete durchgereicht.
- Der Starter laeuft als normaler Benutzer und benoetigt Zugriff auf `/dev/kvm`.
- `kali-start`, `kali-stop` und `kali-status` bleiben Libvirt-Aliasse fuer
  die historische Domain `pixel-lab-kali-audit`; sie starten nicht diese VM.
  Der bestehende Alias `lab` bleibt fuer die separate Hotspot-VM.
- QEMU nutzt GTK-Anzeige. Auf dem Host ist eine grafische X11- oder Wayland-
  Sitzung erforderlich; ein Headless- oder SPICE-Modus ist nicht eingerichtet.
- Die Starter-Sperre `$vm_dir/.lock` koordiniert nur andere Prozesse, die dieselbe
  Sperrdatei verwenden. Manuell gestartetes QEMU wird dadurch nicht erfasst.

## Datenschutz beim `wiki`-Alias

Die Bash-Funktion `wiki` übergibt den gesamten angegebenen Text als Prompt an
`ollama run phi3.5` auf dem Host. Der Text wird dabei nicht als Shell-Befehl
ausgeführt; er geht aber an den auf diesem Host konfigurierten Ollama-Dienst.
Keine Passwörter, Tokens, privaten Logs oder sonstigen vertraulichen Daten
übergeben. Die Funktion selbst belegt nicht, wie der Ollama-Dienst Prompts
speichert oder protokolliert.

## Pruefen und bauen

Die neuen Dateien muessen in Git aufgenommen werden, damit eine Git-Flake sie sieht.

```bash
nix flake check --no-build --no-update-lock-file
nix build .#kali-slim --no-link --no-update-lock-file -L
nix build .#checks.x86_64-linux.kali-slim-behaviour --no-link --no-update-lock-file -L
nix run .#kali-slim -- help
nix run .#kali-slim -- check
```

Der Starter-Build prueft das Bash-Skript mit bash -n und ShellCheck.
Der GitHub-Actions-Workflow führt Flake-Evaluation, Paket- und Verhaltenstest
sowie die Python-Tests aus. Diese Prüfungen starten keine VM, legen keine
virtuelle Platte an und aktivieren kein Host-System. Der separate
Verhaltenstest ersetzt QEMU und die KVM-Zugriffspruefung durch Test-Doubles.
Er prueft unter anderem Ueberschreibschutz, SHA256-Abbruch, Offline-Start,
Ressourcen und die Ablehnung von Backing-Dateien. Er ist kein echter VM-Boottest.

## Betrieb der installierten VM

Nach dem Host-Rebuild steht in einer neuen Bash der Alias `kali` bereit.
Er startet die vorhandene Kali-Platte offline. Der Starter ist als Nix-Paket
im Benutzerprofil eingebunden; ein Aufruf ueber den Git-Checkout ist fuer
`kali` nicht erforderlich. Startmeldungen bleiben im Terminal sichtbar.

Vom Repository-Hauptverzeichnis aus, als normaler Host-Benutzer:

```bash
nix run .#kali-slim -- boot
```

Das ist der Standardstart ohne virtuelle Netzwerkkarte. Fuer bewusst
gewaehlten Netzwerkzugriff die VM zuerst herunterfahren und anschliessend
mit `nix run .#kali-slim -- boot-online` starten. In Kali ueber das
Desktop-Menue herunterfahren. QEMU-GTK-Vollbild umschalten: Strg+Alt+F.
Für die GTK-Anzeige ist eine grafische Host-Sitzung nötig; Headless-Betrieb
oder ein SPICE-Endpunkt sind nicht eingerichtet.

Passwoerter werden im Gast verwaltet; `passwd` im Kali-Terminal aendert
das Passwort des angemeldeten Kontos. Gast und Host haben getrennte Konten.

Nach Git-Updates laesst sich die Zweckbeschreibung neben der bereits
vorhandenen VM-Platte ablegen; folgenden Befehl im Repository ausfuehren:

```bash
install -m 0644 packages/kali-slim/VERWENDUNGSZWECK.md "$HOME/kali-audit-lab/kali-slim/VERWENDUNGSZWECK.md"
```

Git versioniert den Starter und die Dokumentation. Es sichert weder die
installierte QCOW2-Platte noch nachtraegliche Aenderungen im Gast. Für eine
Plattenkopie Kali herunterfahren und alle QEMU-Prozesse beenden, die genau
diese Platte nutzen. Danach die Kopie mit `sha256sum` gegen das Original
prüfen. Die Starter-Sperre schützt nur kooperierende Prozesse, die dieselbe
`.lock`-Datei verwenden.

Am 15.10.2026 wurden Installation, Boot und Anmeldung bis zum Xfce-Desktop
auf dem NixOS-Host im gemeinsamen Durchlauf bestaetigt. Die Ursache des
Anmeldefehlers der ersten Installation wurde nicht abschliessend bestimmt.

## Spaetere Installation, erst nach dem Review

```bash
KALI_INSTALLER=$(nix build .#kali-installer --no-link --print-out-paths --no-update-lock-file -L)
nix run .#kali-slim -- init
nix run .#kali-slim -- install "$KALI_INSTALLER"
```

Diese drei Befehle laden den Installer, erzeugen die Platte und starten die
Installation. Sie gehoeren NICHT zur blossen Evaluation oder zum Starter-Testbuild.
Nur die neue virtuelle 30-GiB-Platte wird dem Installer als Festplatte angeboten.

Im Installer einen eigenen Benutzernamen und ein eigenes Passwort festlegen.
Als Desktop Xfce auswaehlen. Die Tool-Sammlungen `top10` und `default`
abwaehlen; benoetigte Werkzeuge spaeter einzeln hinzufuegen. Keine Passwoerter
in die Flake, Shell-History oder Git schreiben.

Beim abschliessenden Neustart beendet sich QEMU durch `-no-reboot`.
Anschliessend die installierte VM mit `nix run .#kali-slim -- boot` starten.

## Herkunft des Installationsmediums

Festgelegt: Kali 2026.2 NetInstaller amd64, nicht als Behauptung einer neuesten Version.

- https://www.kali.org/get-kali/
- https://archive.kali.org/kali-images/kali-2026.2/SHA256SUMS
- https://www.kali.org/docs/introduction/what-image-to-download/

Die SHA256-Pruefsumme wird in `settings.nix` versioniert, von Nix beim
Download geprueft und vom Starter vor dem Installer-Start nochmals kontrolliert.
Ein eigenstaendiger GPG-Signaturcheck wurde in dieser Vorbereitung nicht ausgefuehrt.
