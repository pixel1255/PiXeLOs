# ==============================================================================
# ROADMAP-COMMAND-CENTER.MD — STRATEGISCHER LEITFADEN FÜR CO-CREATION KIs
# 🪐 [GxG-SIGNATURE: 0x2A-PRO-ZWILLINGSSTERN-PIXEL1255-MULTIPROTOCOL-AUDIT]
# Philosophie: Mensch bleibt ROOT | Rein auditierend, überwachend, niemals angreifend.
# ==============================================================================

## 👁️ 1. Die Vision (Das Zielbild)
Der NixOS-Host wird zu einem hochgesicherten, rein überwachenden Kontrollzentrum (Command Center) ausgebaut. Das Desktop-Layout erstreckt sich über drei physische Monitore:

*   **Monitor 1 (Links):** Die Labor-VM (Hotspot-Appliance-VM für geschützte Netzwerk-Rundläufe).
*   **Monitor 2 (Mitte):** Das Haupt-Terminal des NixOS-Hosts. Hier läuft "Anti-Gravity Gemini" als zentrales KI-Auge über Ollama/Phi, überwacht System-Events in Echtzeit und bietet Schnellzugriffe auf Wireshark, nmap und einen gehärteten Firefox Beta.
*   **Monitor 3 (Rechts):** Die "Kali Linux"-Kapsel für dedizierte, rein lesende Sicherheits-Audits und Protokoll-Analysen.

---

## 🧭 2. Das Drei-Säulen-Prinzip (Wofür & Warum)

1.  **Säule 1: Lokale KI-Orchestrierung ("Anti-Gravity Gemini")**
    *   *Warum:* Keine externe Cloud-KI darf deine internen System-Logs oder Audit-Ergebnisse sehen.
    *   *Wie:* Ein lokales Ollama-Modell überwacht im Hintergrund Logs (wie OpenSnitch), während ein intelligentes Whitelist-Wiki definiert, was "normaler Verkehr" ist. Die KI schlägt nur an, wenn Anomalien auftreten, und spuckt fertige Echtzeit-Auswertungen aus.
2.  **Säule 2: Die Kali-Linux-Kapsel (Rechts)**
    *   *Warum:* Das Hauptsystem (NixOS) bleibt sauber und unberührt von Hunderten von Pentesting-Tools. Kali wird strikt isoliert als VM betrieben.
    *   *Wie:* Deklarative Einbindung über libvirtd/QEMU mit nahtloser Monitor-Zuweisung und SPICE-Protokoll (Zwischenablage/native Auflösung).
3.  **Säule 3: Die Überwachungs-Matrix (Mitte)**
    *   *Warum:* Transparenz über das gesamte Netzwerk (z. B. dein iPhone-Tethering-Gateway).
    *   *Wie:* Gehärtete Instanzen von Wireshark, nmap und Firefox Beta – konfiguriert für passives Mitlesen.

---

## 🛠️ 3. Was kommt in die Kali-VM (Und was nicht!)

### ✅ Was REINKOMMT (Das Audit-Besteck):
*   **Netzwerkanalyse:** Wireshark, Tshark (für CLI-Captures), Zeek (ehemals Bro) zur Protokoll-Erkennung.
*   **Passives Recon:** nmap (nur mit lesenden Flags wie `-sV -O`), Masscan (für schnelle Inventuren).
*   **Schwachstellen-Scanner:** OpenVAS / Greenbone (lokal zur Überprüfung deiner eigenen VM-Appliances).
*   **Zertifikats- & Krypto-Prüfung:** Testssl.sh (um zu schauen, warum Zertifikate in VMs brechen).

### ❌ Was STRIKT DRAUSSEN BLEIBT (Kein Angriffs-Müll):
*   **Keine automatisierten Exploitation-Frameworks:** (z. B. Metasploit, Armitage) – wir greifen nichts an.
*   **Keine Brute-Force- oder Password-Cracker:** (z. B. John the Ripper, Hydra, Hashcat).
*   **Keine Wi-Fi-Jammer / Deauther:** (z. B. Aircrack-ng-Suiten zur aktiven Funk-Störung).

---

## 🏁 4. Meilenstein-Fahrplan (Schritt-für-Schritt)

*   [x] **Welle 0:** Firefox-CORS-Zertifikatsfehler auf YouTube fixen (Natives NixOS-Modul integriert).
*   [x] **Welle 1:** Lokales Git-Repository reparieren und 5-Monate-Upload-Blockade auf GitHub lösen.
*   [ ] **Welle 2:** Erstellung des deklarativen NixOS-Moduls `kali-guest.nix` (Vorbereitung der QEMU/KVM-Struktur).
*   [ ] **Welle 3:** Einrichten der "Anti-Gravity Gemini"-Infrastruktur in `local-ai.nix` (Ollama-Anbindung & Echtzeit-Wach-Skript).
*   [ ] **Welle 4:** Erstellung des lokalen Whitelist-Wikis (Die Wissensdatenbank für die KI).
*   [ ] **Welle 5:** Feinschliff des Monitor-Drei-Gespanns (KDE Plasma 6 Fenster-Regeln für Monitor 1, 2 und 3 festzurren).
