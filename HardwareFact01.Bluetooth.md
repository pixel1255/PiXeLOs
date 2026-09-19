# Bericht: HardwareFact01 — Bluetooth-Dienst-Verhalten

## Feststellung (Runtime-Audit)
- **Symptom:** Der systemweite `bluetooth.service` verbleibt dauerhaft im Zustand `inactive (dead)`.
- **Systemd-Log:** `Bluetooth service skipped, unmet condition check ConditionPathIsDirectory=/sys/class/bluetooth`

## Ursache
- **Hardware-Fakt:** Auf dem physischen Intel-Host (i3-4130) ist dauerhaft **kein Bluetooth-Controller verbaut**.
- **Erklärung:** Der Linux-Kernel stellt mangels Hardware den Pfad `/sys/class/bluetooth` nicht bereit. Systemd bricht den Start der Unit daher völlig korrekt und ressourcenschonend ab.

## Entscheidung für die Zukunft
- Die Deklaration `hardware.bluetooth.enable = true;` verbleibt als Standard-Vorgabe im Modul `modules/hardware/bluetooth.nix`.
- Sollte jemals ein USB-Bluetooth-Dongle angesteckt werden, ist das System sofort ohne Code-Änderung startbereit. Bis dahin bleibt der ruhende Dienst der dokumentierte Soll-Zustand.

**Status: VERIFIZIERT & DOKUMENTIERT (GREEN)**
