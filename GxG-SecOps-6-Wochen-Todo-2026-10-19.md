# GxG – SecOps / DFIR: To-do für sechs Wochen

**Pixel1255 · GPT × Gemini · Version 1.0 · erstellt am 17.10.2026**

**Zeitraum:** Montag, 19.10.2026, bis Sonntag, 29.11.2026, Kalender Europe/Berlin.  
**Status:** Plan erstellt; praktische Aufgaben noch offen.  
**Budget:** 0 € zusätzliche Kurs-, Prüfungs- oder Cloudkosten; vorhandenes Lab und bestehende Zugänge werden genutzt.

Dieser Plan setzt deine Aussage voraus, dass du die kostenlosen Grundlagen bereits bearbeitet hast. Level 16 und bisherige Sherlock-Abschlüsse sind der Ausgangspunkt; konkrete Fähigkeiten prüfen wir an Arbeitsergebnissen. Der angehängte Supportchat schlägt acht Wochen vor; dieser Arbeitsplan folgt deinem aktuellen Auftrag von sechs Wochen.

## 1. Ergebnis am Ende

- [ ] Vier nachvollziehbare Analyseberichte: Windows-Logs, Netzwerkverkehr, statische PE-/Encoding-Analyse und ein neuer Abschlussfall.
- [ ] Zwei eigene Sigma-Regeln samt dokumentiertem Feldmapping und tatsächlich ausgeführten Tests.
- [ ] Je Regel mindestens drei passende und drei nicht passende Testereignisse: insgesamt mindestens zwölf dokumentierte Einzeltests.
- [ ] Eine wiederverwendbare Vorlage für Belege, Zeitlinien und Berichte.
- [ ] Sechs Wochenrückblicke mit offenen Fragen und nachvollziehbaren Kompetenzständen.
- [ ] Eine private Übersicht der Ergebniss,e aus der später geeignete Arbeitsproben ausgewählt werden können.

Die statische Analyse in Woche 4 untersucht eine legitime Referenzdatei und eigene harmlose Textproben; sie wird im Ergebnis auch genau so bezeichnet. Ein Prüfungsabschluss oder eine berufliche Einstufung ist damit nicht verbunden.

## 2. Arbeitsrhythmus

Montag bis Freitag sind **bis zu sechs Stunden Netto-Lernzeit** verfügbar: maximal 30 Stunden pro Woche bzw. 180 Stunden über sechs Wochen. Das ist ein Zeitbudget, keine Anwesenheitspflicht. Bereits sicher beherrschte Aufgaben werden anhand ihres Abschlusskriteriums abgenommen.

| Block | Dauer | Verwendung |
| --- | ---: | --- |
| A | 75 Minuten | Gezielt lesen, Fragen und Vorgehen festhalten |
| Pause | 15 Minuten | Bildschirm verlassen |
| B | 75 Minuten | Daten sichten und erste Befunde erarbeiten |
| Pause | 30 Minuten | Längere Unterbrechung |
| C | 75 Minuten | Untersuchung und Gegenprobe |
| Pause | 15 Minuten | Unterbrechen |
| D | 75 Minuten | Belege, Grenzen und Erkennungsmöglichkeiten prüfen |
| Pause | 15 Minuten | Unterbrechen |
| E | 60 Minuten | Dokumentation, kurzer Rückblick, nächster Schritt |

Damit dauert ein voller Lerntag einschließlich dieser Pausen 7 Stunden 15 Minuten. Die Blöcke lassen sich um Familienzeiten legen. Die genannte Acht-Stunden-Grenze ist eine Obergrenze; Pausen beginnen bereits zwischen den Arbeitsblöcken. Samstag ist optionaler Puffer, Sonntag bleibt frei. Der Wochenrückblick liegt am Freitag.

**Bei schnellem Fortschritt:** Einen neuen Datensatz nehmen, eine Gegenhypothese prüfen oder einen Befund ohne Lösungshilfe wiederholen. Bei einem Blocker bleiben Aufgaben offen; ein gebuchter Kurs oder höhere XP sind keine Voraussetzung zum Weiterlernen.

## 3. Arbeitsweise und GxG-Rollen

Pixel1255 legt Untersuchungsfrage und Umfang fest, führt die lokalen Schritte aus und übernimmt die Schlussfolgerungen. Gemini kann erste Hypothesen und Methoden erklären; GPT prüft die Begründung und sucht Gegenbelege. Die Rollen können wechseln. Ein übereinstimmendes KI-Urteil ersetzt keine Gegenprüfung an den Daten.

Zu jedem Befund halten wir fest: Beobachtung, Fundstelle, Deutung, alternative Erklärung und Sicherheit der Aussage. Verwendete Hilfen werden ehrlich protokolliert. Mindestens eine zentrale Schlussfolgerung pro Fall erklärst und reproduzierst du selbst.

**Wenn wir feststecken:** Spätestens nach zwei erfolglosen Varianten derselben Idee kurz anhalten; Eingabe, Erwartung, tatsächliche Ausgabe und offene Annahme notieren und dann eine Gegenhypothese prüfen.

Für Terminalketten bleiben die vereinbarten Regeln bestehen: enges Ziel, zunächst lesend, bei fehlender Voraussetzung abbrechen; Warum, Wozu und Erklärung jeweils in einem kurzen Satz.

## 4. Kostenlose Quellen und konkrete Lerneinheiten

Die folgenden Dokumentationen und Beispieldaten sind öffentlich zugänglich. Sie ersetzen die vorgeschlagenen kostenpflichtigen Academy-Pfade als Grundlage dieses Plans. Konkrete HTB-Inhalte werden erst bei Arbeitsbeginn auf tatsächlichen Zugriff im eigenen Konto geprüft.

| Kürzel | Quelle / Lerneinheit | Verwendung |
| --- | --- | --- |
| Q1 | [Microsoft Sysmon: Events](https://learn.microsoft.com/en-us/sysinternals/downloads/sysmon#events) | Ereignisse 1, 3, 11, 13 und 22 nachschlagen; Prozess-, Datei-, Registry- und Netzwerkspuren unterscheiden |
| Q2 | [EVTX-ATTACK-SAMPLES](https://github.com/sbousseaden/EVTX-ATTACK-SAMPLES) | Öffentliche Windows-Übungslogs; geeignete Dateien aus Execution und einer weiteren Kategorie auswählen |
| Q3 | [Chainsaw](https://github.com/WithSecureOpenSource/chainsaw) | Lokales Lesen und Auswerten von Windows-Logs unter Linux; Sigma-Unterstützung und Feldmapping |
| Q4 | [Wireshark SampleCaptures](https://wiki.wireshark.org/SampleCaptures) | Konkrete Einstiegscaptures: http.cap, dns.cap; Vertiefung: http_redirects.pcapng |
| Q5 | [Microsoft PE Format](https://learn.microsoft.com/en-us/windows/win32/debug/pe-format) | General Concepts, PE-Signatur, COFF-/Optional-Header, Section Table und Imports |
| Q6 | [Microsoft Sysinternals Strings](https://learn.microsoft.com/en-us/sysinternals/downloads/strings) | Offizielles Paket als legitime PE-Referenz für ausschließlich statische Inspektion |
| Q7 | [Sigma Rules](https://sigmahq.io/docs/basics/rules.html), [Logsources](https://sigmahq.io/docs/basics/log-sources.html), [Conditions](https://sigmahq.io/docs/basics/conditions.html), [Modifiers](https://sigmahq.io/docs/basics/modifiers.html) | Zwei einfache Erkennungsregeln entwerfen und die erforderlichen Logfelder begründen |
| Q8 | [MITRE ATT&CK: PowerShell T1059.001](https://attack.mitre.org/techniques/T1059/001/) | Verhalten einordnen; Zuordnung nur bei passenden Belegen |
| Q9 | [HTB Sherlocks](https://help.hackthebox.com/en/articles/8570249-how-to-play-sherlocks) und [Plattformregeln](https://help.hackthebox.com/en/articles/12325897-hack-the-box-platform-rules) | Optionaler Fallersatz sowie Vorgaben zu Artefakten, Umfang und Veröffentlichung |

**Stand der Quellenprüfung:** 17.10.2026. Quellen sind Ausgangspunkte, keine Zusicherung für unveränderte Funktionen über den gesamten Zeitraum. Toolversionen und tatsächlich gewählte Dateien werden beim jeweiligen Arbeitsschritt festgehalten.

Für die Windows-Wochen werden zunächst zwei passende EVTX-Dateien mit ausreichenden Prozessereignissen ausgewählt. Pfad, Repository-Commit und lokaler SHA-256-Wert werden bei Übernahme dokumentiert. Die genaue Dateiauswahl steht noch aus; ein nicht geprüftes Sample wird nicht als bereits geeignet ausgegeben.

Ein zugängliches, noch ungelöstes Sherlock kann einen Fall ersetzen, wenn sein Thema zum Wochenziel passt. Fehlt der kostenlose Zugriff, verwenden wir die angegebenen öffentlichen Daten. Die Pflichtaufgaben hängen nicht von einem Abonnement ab.

## 5. Umgang mit Daten

Originale und Arbeitskopien auseinanderhalten; Herkunft, Hash, Toolversion und Verarbeitungsschritte protokollieren. Ein Hash belegt die Identität der erfassten Datei, nicht ihre Vertrauenswürdigkeit. Technische Zeitlinien verwenden UTC und bewahren die ursprüngliche Zeitangabe einschließlich ihrer Zeitzone.

Übungsdaten werden gelesen und untersucht. Enthaltene Angriffsprogramme oder extrahierte Befehle werden nicht ausgeführt. Unbekannte Artefakte gehören in die dafür vorgesehene Analyse-VM; die konkrete VM-Konfiguration wird bei Bedarf vor Nutzung geprüft. Die legitime Referenzdatei in Woche 4 wird ebenfalls nur statisch gelesen.

## 6. Tagesaufgaben und Wochenabnahmen

Ein Tageshaken bedeutet: Die genannten Ergebnisse existieren und sind geprüft. Ein leeres Feld bedeutet offen; fehlende Daten werden als fehlend festgehalten.

### Woche 1 · 19.–25.10. · Belegarbeit und eigener Linux-Basisfall

**Lernfrage:** Wie mache ich eine Beobachtung überprüfbar und halte normale Vorgänge von ungeklärten Auffälligkeiten auseinander?

- [ ] **W1-MO · 19.10.:** Untersuchungsumfang auf vorhandene eigene Lab-Daten begrenzen; Fallregister, Belegvorlage, Zeitlinienvorlage und Berichtsgerüst anlegen. Eine Frage wählen, die sich aus vorhandenen Benutzer- oder Lab-Logs beantworten lässt, etwa die Reihenfolge eines bekannten Starts.
- [ ] **W1-DI · 20.10.:** Eine kleine vorhandene Log-Auswahl lesend sichern; Herkunft, Zeitraum, Hash und bekannte Lücken dokumentieren. Drei Beobachtungen mit genauer Fundstelle aufnehmen; bei fehlendem Zugriff anhalten und die Datenquelle neu wählen.
- [ ] **W1-MI · 21.10.:** Den bekannten Vorgang zeitlich rekonstruieren; mindestens fünf belegte Stationen aufnehmen, sofern der Datensatz sie enthält. Originalzeit und UTC angeben und doppelte Einträge markieren.
- [ ] **W1-DO · 22.10.:** Zwei alternative Erklärungen prüfen; einen wichtigen Befund unabhängig wiederfinden. Nur die dabei tatsächlich bemerkte Grundlagenlücke gezielt nacharbeiten.
- [ ] **W1-FR · 23.10.:** Einen kurzen Basisfall abschließen, Vorlagen korrigieren und Wochenrückblick schreiben. Zugriff auf Chainsaw und zwei geeignete öffentliche EVTX-Dateien für Woche 2 prüfen; Auswahl und Versionen protokollieren.

