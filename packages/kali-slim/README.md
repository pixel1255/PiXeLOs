# Schlanke Kali-VM

Co-Created by Pixel1255, Anti-Gravity Gemini & ChatGPT (GxG-Prozess)

Die Flake baut den QEMU-Starter und stellt einen nach SHA256 festgelegten
offiziellen Kali-NetInstaller bereit. Der Gast wird mit dem Kali-Installer
installiert. Ein reproduzierbarer Nix-Starter bedeutet dabei nicht, dass die
spaeter von Kali Rolling geladenen Pakete unveraenderlich festgelegt sind.

Die neue Funktion wird als additive Flake-Ausgabe eingebunden. Die bisherige
Host-Konfiguration und der alte NixOS-Testgast `nixosConfigurations.kali-audit`
werden durch diesen Patch nicht geaendert. Fuer echtes Kali ausschliesslich
den neuen Starter `kali-slim` verwenden. Die alten Testpasswort-Definitionen
und die 20 vorhandenen lokalen Commits sind vor einer Veroeffentlichung
separat zu pruefen; dieser Patch behauptet keine Bereinigung der Git-Historie.

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
- Die Shell-Aliase `kali-start`, `kali-stop`, `update` und `lab` werden nicht geaendert.

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
Er startet keine VM und laedt den Installer nicht herunter. Der separate
Verhaltenstest ersetzt QEMU und die KVM-Zugriffspruefung durch Test-Doubles.
Er prueft unter anderem Ueberschreibschutz, SHA256-Abbruch, Offline-Start,
Ressourcen und die Ablehnung von Backing-Dateien. Er ist kein echter VM-Boottest.

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
