#!/usr/bin/env bash
set -euo pipefail

echo "=== AUDIT WELLE 4: MINIMALE CONSOLE-VM ==="
task_repo='/home/pixel1255/pixel-nixos'
task_host_conf="${task_repo}/hosts/console/default.nix"
task_iso_conf="${task_repo}/modules/isolation/console.nix"

# 1. Existenz der Konfigurationsdateien prüfen
if [ -f "$task_host_conf" ] && [ -f "$task_iso_conf" ]; then
  echo "GRÜN: VM- und Isolationsdateien existieren im Workspace."
else
  echo "ROT: VM-Konfigurationsdateien fehlen!"
  exit 1
fi

# 2. Sicherheits-Check gegen Host-Dateisystemfreigaben (sharedDirectories)
if grep -q "sharedDirectories = lib.mkForce {};" "$task_iso_conf"; then
  echo "GRÜN: Host-Dateisystem-Shares sind explizit blockiert."
else
  echo "ROT: Sicherheitsrisiko! sharedDirectories sind nicht blockiert."
  exit 1
fi

# 3. Sicherheits-Check gegen offene Netzwerk-Dienste
if grep -q "services.openssh.enable = false;" "$task_iso_conf" && grep -q "networking.useDHCP = false;" "$task_iso_conf"; then
  echo "GRÜN: SSH-Dienst und DHCP-Netzwerk im Gast vollständig deaktiviert."
else
  echo "ROT: Netzwerk- oder SSH-Absperrungen sind unvollständig!"
  exit 1
fi

# 4. Ressourcen-Profil verifizieren (i3-4130 Schutzbetrieb)
if grep -q "memorySize = 1024;" "$task_host_conf" && grep -q "cores = 1;" "$task_host_conf"; then
  echo "GRÜN: Konservatives CPU/RAM-Ressourcenprofil eingehalten."
else
  echo "ROT: Ressourcenprofil überschreitet das Schutzbetrieb-Limit!"
  exit 1
fi

echo "=== AUDIT ERFOLGREICH: WELLE 4 CONFIG IST GRÜN ==="
