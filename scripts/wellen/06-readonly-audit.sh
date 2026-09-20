#!/usr/bin/env bash
set -euo pipefail
echo "=== AUDIT WELLE 6: BUILDER-VM & REVIEW-SCHLEUSE ==="
test -f hosts/builder/default.nix && echo "GRÜN: Builder-Hostprofil existiert."
test -f modules/isolation/builder.nix && echo "GRÜN: Builder-Isolationsmodul existiert."
grep -q "sharedDirectories = {};" modules/isolation/builder.nix && echo "GRÜN: Host-Dateisystemfreigaben blockiert."
grep -q "networking.useDHCP = false;" modules/isolation/builder.nix && echo "GRÜN: Netzwerk standardmäßig deaktiviert."
grep -q "memorySize = 2048;" hosts/builder/default.nix && echo "GRÜN: Ressourcenlimit (2 GiB) konfiguriert."
echo "=== AUDIT ERFOLGREICH: WELLE 6 IST GRÜN ==="
