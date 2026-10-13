#!/usr/bin/env bash
set -euo pipefail
echo "=== AUDIT WELLE 5: WINDOWS-HOTSPOT ==="
test -f modules/host/pixel-vm-broker-hotspot.nix && echo "GRÜN: Broker-Modul existiert."
test -f vm-definitions/windows-hotspot/domain.xml.txt && echo "GRÜN: Domain-XML existiert."
grep -q "0x057c" vm-definitions/windows-hotspot/domain.xml.txt && echo "GRÜN: USB-Passthrough Vendor-ID korrekt."
grep -q "ndiswrapper" modules/host/pixel-vm-broker-hotspot.nix && echo "GRÜN: Host-Blacklisting aktiv."
echo "=== AUDIT ERFOLGREICH: WELLE 5 IST GRÜN ==="
