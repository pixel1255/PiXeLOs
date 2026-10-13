#!/usr/bin/env bash
set -euo pipefail

echo "=== AUDIT WELLE 3: LAB-FLAKE SKELETON ==="
task_repo='/home/pixel1255/pixel-nixos'
task_storage_mod="${task_repo}/modules/host/pixel-lab-storage.nix"

# 1. Deklaratives Hostmodul auf Existenz prüfen
if [ -f "$task_storage_mod" ]; then
  echo "GRÜN: Host-Storage-Modul existiert."
else
  echo "ROT: Host-Storage-Modul fehlt!"
  exit 1
fi

# 2. Syntax- und Quellprüfung des neuen Moduls gegen verbotene Pfade/UUIDs
if grep -q "5572669d-7365-4740-baec-91e38fbef8ae" "$task_storage_mod"; then
  echo "GRÜN: Korrekte ext4-UUID im Hostmodul hinterlegt."
else
  echo "ROT: Falsche oder fehlende UUID im Hostmodul!"
  exit 1
fi

# 3. Flake Check simulieren
if nix flake check --extra-experimental-features "nix-command flakes" "$task_repo" >/dev/null 2>&1; then
  echo "GRÜN: Host-Flake Evalution und Syntaxprüfung fehlerfrei."
else
  echo "ROT: Flake Check fehlgeschlagen!"
  exit 1
fi

echo "=== AUDIT ERFOLGREICH: WELLE 3 IST GRÜN ==="
