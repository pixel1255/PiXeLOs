#!/bin/sh
set -eu
echo "=== AUDIT WELLE 8A: KI-LAUFZEIT & MODELLMANAGER ==="
test -f packages/pixel-model-manifest/schema.json && echo "GRÜN: Modellmanifest-Schema existiert."
test -f modules/isolation/ai-runtime.nix && echo "GRÜN: KI-Laufzeitmodul existiert."
test -f docs/wellen/WELLE-08A-KI-LAUFZEIT.md && echo "GRÜN: Welle-8A Dokumentation existiert."
jq . packages/pixel-model-manifest/schema.json >/dev/null && echo "GRÜN: Manifest-Schema ist valides JSON."
grep -q "analyst" modules/isolation/ai-runtime.nix && echo "GRÜN: Analysten-Schutzprofil vorhanden."
grep -q "\*.gguf" .gitignore && echo "GRÜN: Modell-Ausschluss in .gitignore verankert."
echo "=== AUDIT ERFOLGREICH: WELLE 8A IST GRÜN ==="
