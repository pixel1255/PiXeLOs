# PiXeL NixOS — Version 0

> Ein reproduzierbarer, lernorientierter NixOS-Host, der Schritt für Schritt
> gebaut, getestet, dokumentiert und erst nach erfolgreicher Prüfung übernommen
> wird.

## Was dieses System ist

PiXeL NixOS ist eine persönliche, reproduzierbare NixOS-Konfiguration für
einen physischen Intel-x86_64-Host.

Das System basiert auf NixOS und Nixpkgs und nutzt deren deklaratives
Konfigurationsmodell. Betriebssystem, Desktop, Netzwerk, Hardwareunterstützung,
Werkzeuge und Dienste werden möglichst nachvollziehbar über Nix beschrieben.

Version 0 bildet den ersten nachweislich gebooteten und getesteten
Clean-Rebuild des Systems.

Zur aktuellen Basis gehören unter anderem:

- NixOS mit Flakes
- systemd-boot / UEFI
- Linux 6.12
- KDE Plasma 6 mit SDDM und Wayland
- Intel-i915-Grafik
- NetworkManager und Firewall
- PipeWire / WirePlumber
- iPhone-USB-Tethering über `ipheth` und `usbmuxd`
- USB-Modeswitch
- experimenteller Arbeitsstand zum FRITZ!WLAN AC 430
- Firefox Beta
- Kate, Dolphin, Konsole und weitere KDE-Werkzeuge
- ein bewusst ausgewählter Satz an CLI-, Diagnose- und Entwicklungswerkzeugen

Die konkrete Wahrheit über den jeweils gebauten Stand liegt in den
Nix-Konfigurationsdateien und im Git-Verlauf.

## Wofür dieses Projekt gedacht ist

Das Projekt dient als persönliche technische Werkbank und Lernplattform.

Ziel ist nicht, möglichst schnell möglichst viele Funktionen einzubauen,
sondern ein System aufzubauen, dessen einzelne Schichten verstanden,
reproduziert, geprüft und bei Bedarf wieder verworfen werden können.

Spätere Ausbaustufen können beispielsweise Virtualisierung, getrennte
Arbeitsstationen, Browser- oder Netzwerk-VMs und weitere Lab-Komponenten
enthalten.

Der physische Host bleibt dabei die nachvollziehbare Grundlage.

## Wie hier gearbeitet wird

Die Arbeitsweise folgt einem einfachen Grundsatz:

**bauen -> prüfen -> testen -> dokumentieren -> erst dann übernehmen**

Änderungen entstehen in kleinen, nachvollziehbaren Schritten.

Dabei werden insbesondere:

- reale Hardwaredaten vor Annahmen bevorzugt,
- UUIDs, Treiber und Geräte tatsächlich geprüft,
- Änderungen zuerst auf einem Arbeitszweig entwickelt,
- Builds und Runtime-Verhalten getestet,
- Fehler nicht durch ungeprüfte Folgeänderungen verdeckt,
- funktionierende Zustände in Git festgehalten,
- wichtige technische Entscheidungen dokumentiert.

`main` steht für einen getesteten stabilen Zustand.

`dev` ist die Werkbank für neue Änderungen.

Ein erfolgreicher Build allein bedeutet noch nicht automatisch, dass eine
Änderung als funktionierend gilt. Entscheidend ist der Test auf dem realen
System.

## Was dieses System ausdrücklich nicht ist

PiXeL NixOS ist:

- keine eigene Linux-Distribution,
- kein Fork und kein Ersatz für NixOS,
- kein offizielles Projekt der NixOS Foundation,
- nicht mit der NixOS Foundation verbunden oder von ihr unterstützt,
- kein fertiges Universal-System für beliebige Hardware,
- keine Sicherheitszertifizierung,
- keine Garantie für Fehlerfreiheit,
- keine Pentesting- oder Angriffsdistro,
- kein automatisch von KI verwaltetes Betriebssystem,
- keine Sammlung ungeprüfter Copy-and-Paste-Konfigurationen.

KI-Systeme unterstützen Recherche, Gegenprüfung, Dokumentation,
Fehlersuche und Entwurfsarbeit.

Die Auswahl, Bewertung, Ausführung und Übernahme von Änderungen bleibt eine
menschliche Entscheidung.

Besonders experimentelle Hardwarepfade werden auch als solche bezeichnet.
Eine erkannte USB-ID oder ein geladenes Kernelmodul wird beispielsweise
nicht automatisch als funktionierender Treiber ausgegeben.

## Open Source und Lizenzen

Die selbst erstellten Konfigurations- und Dokumentationsbestandteile dieses
Repositories werden unter der MIT License veröffentlicht, soweit an einzelnen
Dateien nichts anderes angegeben ist.

NixOS und Nixpkgs sind eigenständige Projekte.

Nixpkgs verwendet für seine eigenen Nix-Ausdrücke, Module und Build-Skripte
die MIT License. Diese Lizenz überträgt sich jedoch nicht automatisch auf die
Software, die über Nixpkgs gebaut oder installiert wird.

Programme, Bibliotheken, Firmware, Treiber, Fonts und sonstige
Drittkomponenten bleiben unter ihren jeweiligen ursprünglichen Lizenzen.

Insbesondere bedeutet die Aufnahme eines Pakets in diese Konfiguration nicht,
dass PiXeL NixOS dessen Code, Markenrechte oder Verteilungsrechte übernimmt.

Unfreie oder nur eingeschränkt weiterverteilbare Komponenten werden durch
dieses Projekt nicht neu lizenziert.

NixOS-Namen, Logos und andere Markenbestandteile gehören ihren jeweiligen
Rechteinhabern. Eine Verwendung soll keine offizielle Zugehörigkeit oder
Unterstützung suggerieren.

## Verantwortung und Haftung

Projektverantwortlicher ist:

**Pixel1255**  
*bürgerlicher Name auf berechtigte Anfrage*

Die Verantwortung für Auswahl, Prüfung, Integration, Betrieb und
Veröffentlichung der Projektbestandteile liegt bei Pixel1255.

KI-Systeme werden als unterstützende Werkzeuge und Co-Creation-Partner
eingesetzt und übernehmen keine eigenständige Verantwortung für Betrieb,
Entscheidungen oder Veröffentlichung.

Gesetzliche Haftungsregelungen bleiben von dieser Projekterklärung
unberührt.

Das Projekt wird ohne Zusicherung bereitgestellt, dass eine bestimmte
Konfiguration auf anderer Hardware oder in einer anderen Umgebung
funktioniert.

Vor einer Übernahme sollten Änderungen gelesen, verstanden und im eigenen
System getestet werden.

## Fragen, Hinweise und Austausch

Fragen, technische Hinweise, Fehlerberichte, Gegenprüfungen und sachliche
Kritik sind ausdrücklich willkommen.

Einfach **Pixel1255 anschreiben**.

Wenn etwas unklar dokumentiert ist, ein Test reproduziert werden soll oder
eine technische Entscheidung hinterfragt wird: fragen ist ausdrücklich
erwünscht.

---

## GxG — Co-Creation

Dieses Projekt ist im **GxG-Arbeitsprozess** in Co-Creation entstanden:

**Pixel1255**  
Projektverantwortung, Entscheidungen, Tests und Integration

**Sol-Werkbank-KI**  
OpenAI / ChatGPT  
Analyse, Gegenprüfung, technische Zusammenarbeit und Dokumentation

**Zwillingsstern-KI**  
Google Gemini  
zusätzliche Perspektiven, Gegenprüfung und gemeinsame Ideenarbeit

Die KI-Systeme sind Werkzeuge und Partner im Entstehungsprozess;
die Verantwortung für das daraus gebaute und veröffentlichte System
liegt bei Pixel1255.

**GxG — gemeinsam denken, getrennt prüfen, reproduzierbar bauen.**

<3
