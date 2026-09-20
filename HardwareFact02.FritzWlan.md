# Bericht: HardwareFact02 — FRITZ!WLAN AC 430 Host-Verhalten

## Feststellung (Stand des Wissens)
- **Symptom:** Das USB-Gerät `057c:8602` (FRITZ!WLAN USB Stick AC 430 MU-MIMO) lädt zwar im Kernel die generischen `mt76`-Module, stellt jedoch im Host-System kein Netzwerkinterface bereit.

## Ursache & Rechtlicher Fakt
- **Hersteller-Restriktion:** Offizieller E-Mail-Verkehr mit dem AVM-Support (Ticket-ID 7893301 vom 14. Sept. 2026) bestätigt: Für den FRITZ!WLAN USB Stick AC 430 MU-MIMO ist keine Linux-Unterstützung vorgesehen oder freigegeben. Das Gerät wird ausschließlich für Windows 11 und Windows 10 auf Intel-x86-Plattformen unterstützt.
- **Entscheidung:** Es wird auf Host-Ebene kein unautorisierter Eingriff vorgenommen. Der Stick bleibt auf der physischen Intel-Ebene inaktiv.

## Marschroute für spätere Phasen
- Das Thema WLAN-Stick wird auf der Host-Ebene permanent eingefroren.
- *Zukünftige Option:* Spätere Emulation über eine isolierte Windows-KVM-VM mit direktem USB-Passthrough, um dort einen Hotspot zu betreiben. Aktueller Fokus bleibt die Stabilisierung der Host-Basis.

**Status: PHYSISCH EINGEFROREN / VM-OPTION GEPLANT (GREEN)**
