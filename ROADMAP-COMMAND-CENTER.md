# ROADMAP-COMMAND-CENTER — Strategischer Leitfaden für Co‑Creation KIs
# Philosophie: Mensch bleibt ROOT | Auditierend, überwachend, niemals angreifend.

## Vision
Der NixOS‑Host wird zu einem hochgesicherten, lokalen Kontrollzentrum (Command Center), das Monitoring, forensische Analyse und deklarative VM‑Kapselung vereint — drei physische Monitore für klare Trennungen der Aufgaben. Kali Linux wird als isolierte Audit‑Kapsel verwendet; der Einsatz erfolgt ausschließlich mit ausdrücklicher Erlaubnis/Autorisierung.

## Monitor‑Aufteilung
- Monitor 1 (Links): Labor‑VM (Hotspot/Appliance VM für geschützte Netzwerk‑Rundläufe).
- Monitor 2 (Mitte): Haupt‑Terminal des Hosts — "Anti‑Gravity Gemini" (lokales Ollama), Log‑Watch, Wireshark/Tshark, gehärteter Firefox Beta.
- Monitor 3 (Rechts): Kali‑Kapsel — isolierte, rein lesende Audit‑/Forensik‑Umgebung.

## Drei‑Säulen‑Prinzip
1. Lokale KI‑Orchestrierung (Anti‑Gravity Gemini)
   - Läuft lokal (Ollama/Phi). Keine Cloud‑Uploads von sensiblen Logs ohne genehmigte Freigabe.
   - Funktion: Beobachten → Anomalien markieren → strukturierte Auswertung und menschliche Empfehlungen liefern.
   - Keine autonomen Aktionen — jede Aktion muss menschlich validiert werden.

2. Kali‑Linux‑Kapsel (rechts)
   - Isoliert per QEMU/KVM + libvirt. Nur interne Kommunikation über definierte Schnittstellen.
   - Nur passive/forensische Tools und Scans mit Genehmigung.
   - Zweck: Visibility, Forensics, Zertifikats‑ und Protokoll‑Analysen.

3. Überwachungs‑Matrix (mitte)
   - Gehärtete Instanzen von Wireshark/Tshark, Zeek, nmap (lesende Flags), CEF/JSON‑Logging.
   - Alerts in Audit‑Queue; menschliches Review verpflichtend.

## Ethik & Regeln (unverhandelbar)
- Erlaubnis: Vor aktiven Scans immer schriftliche Genehmigung/Scope‑Definition einholen.
- Trennung: Keine automatischen Exploit‑Aktionen oder Brute‑Force‑Workflows.
- Human‑in‑the‑Loop: Jede potentielle „Abhilfemaßnahme“ bedarf menschlicher Entscheidung.
- Datenschutz: Sensitive Daten sollten lokal anonymisiert/gelöscht werden, wenn nicht für Audit nötig.
- Dokumentation: Jede Untersuchung protokollieren (who/what/when/why).

## Was in die Kali‑VM kommt (Beispiel)
- Wireshark/Tshark, Zeek, nmap (-sV, -O), OpenVAS (lokal), testssl.sh.
- KEINESFALLS: automatisierte Exploit‑Pipelines, brute‑force‑Tools ohne Genehmigung, Jammer.

## Meilensteine
- [x] Welle 0: Firefox‑CORS/Zertifikatsfehler gefixt
- [x] Welle 1: Git‑Repo repariert / Upload‑Blockade gelöst
- [ ] Welle 2: `kali-guest.nix` erstellen (declarative QEMU/KVM)
- [ ] Welle 3: `local-ai.nix` (Ollama + Watchdog‑Agents, nur lesen)
- [ ] Welle 4: Whitelist‑Wiki (Dokumentation von Normalzuständen & Genehmigungen)
- [ ] Welle 5: KDE‑Fenster/Monitor‑Regeln feinschleifen (Plasma 6)

## Nächste technische Tasks (konkret für Repo)
- Module: modules/virtualisation/kali-guest.nix
- Service: modules/services/local-ai.nix (Ollama‑Wrapper, read‑only connectors)
- Docs: docs/WHITELIST-WIKI.md & docs/OPERATIONAL‑GUIDE.md
- Policies: modules/security/passive-network-policy.nix (nftables + systemd sandboxing)
- Tests: flake.nix → outputs für `nixosConfigurations.kali-audit` (VM build check)

## Abschluss
Kali Linux bleibt klar benannt — als professionelles Audit‑Toolkit und Baustein. Die Stärke dieses Konzepts ist die Kombination aus deklarativer NixOS‑Infrastruktur, lokaler KI‑Beobachtung und strikter menschlicher Kontrolle.
