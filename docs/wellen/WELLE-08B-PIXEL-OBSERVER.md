# Welle 8B – Pixel Observer, Terminal und Web-Prüfung

Stand: 2026-09-20
Status: Grün geprüft.

## Ziel
Bereitstellung der nativen Benutzeroberfläche in der Console-VM ohne administrative Rechte, mit 7 isolierten Tabs, Quarantäne-Prüfung für Webdaten und strikter Trennung vom Host-Hypervisor.

## Kontrollpunkte
- UI-Layout definiert alle 7 Tabs deterministisch.
- Keine direkten Sockets zum Hypervisor aus der GUI.
- Webdaten-Handoff erfolgt ausschließlich über manuelle Quarantäne-Freigabe.
