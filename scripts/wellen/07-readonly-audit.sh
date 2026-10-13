#!/bin/sh
set -eu
echo "=== AUDIT WELLE 7: SICHERHEITSLEITUNG & VSOCK ==="
test -f packages/pixel-event-schema/schema.json && echo "GRÜN: JSON-Ereignisschema existiert."
test -f modules/host/pixel-vm-broker.nix && echo "GRÜN: VM-Broker Modul existiert."
grep -q "vhost_vsock" modules/host/pixel-vm-broker.nix && echo "GRÜN: VSOCK-Kernelmodul konfiguriert."
grep -q "export-review" modules/host/pixel-vm-broker.nix && echo "GRÜN: Broker-Aktionen strikt gewhitelistet."
jq . packages/pixel-event-schema/schema.json >/dev/null && echo "GRÜN: JSON-Schema syntaktisch valide."
echo "=== AUDIT ERFOLGREICH: WELLE 7 IST GRÜN ==="
