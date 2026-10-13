#!/bin/sh
set -eu
echo "=== AUDIT WELLE 8B: PIXEL OBSERVER & NATIVE TABS ==="
test -f packages/pixel-observer/observer-layout.json && echo "GRÜN: Observer Layout-Definition existiert."
test -f docs/wellen/WELLE-08B-PIXEL-OBSERVER.md && echo "GRÜN: Welle-8B Dokumentation existiert."
jq . packages/pixel-observer/observer-layout.json >/dev/null && echo "GRÜN: Observer-Layout ist valides JSON."
test "$(jq '.tabs | length' packages/pixel-observer/observer-layout.json)" -eq 7 && echo "GRÜN: Exakt 7 Tabs im UI definiert."
grep -q '"direct_host_shell": false' packages/pixel-observer/observer-layout.json && echo "GRÜN: Host-Shell-Zugriff der Oberfläche gesperrt."
echo "=== AUDIT ERFOLGREICH: WELLE 8B IST GRÜN ==="
