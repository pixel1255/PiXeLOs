# Welle 8A – KI-Laufzeit und Modellmanager

Stand: 2026-09-20
Status: Grün geprüft.

## Ziel
Sichere Bereitstellung von zwei kleinen Rollen (Watcher, Coder) und einem großen Analysten in der Console-VM ohne Hostrechte, ohne Internet und ohne Modellgewichte im Quellbaum.

## Kontrollpunkte
- Manifestschema validiert Modellmetadaten und Prüfsummen.
- Speicherprofile verhindern Swap-Überlastung auf dem i3-4130.
- Striktes Git-Ignore für alle Binärformate (*.gguf, *.bin).
