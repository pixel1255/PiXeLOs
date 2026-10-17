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
- [ ] Eine private Übersicht der Ergebnisse, aus der später geeignete Arbeitsproben ausgewählt werden können.

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

HTB-Lösungen für aktive Inhalte bleiben privat. HTB verbietet außerdem die Nutzung seiner Inhalte für KI-Training, Modelltests und daraus abgeleitete Datensätze oder Wissensbasen. Eigene Testereignisse dieses Plans entstehen unabhängig aus allgemeinen dokumentierten Verhaltensmerkmalen. Für eine spätere Veröffentlichung prüfen wir Rechte und Plattformregeln am konkreten Material; bis dahin bleibt das Ergebnispaket privat.

## 6. Tagesaufgaben und Wochenabnahmen

Ein Tageshaken bedeutet: Die genannten Ergebnisse existieren und sind geprüft. Ein leeres Feld bedeutet offen; fehlende Daten werden als fehlend festgehalten.

### Woche 1 · 19.–25.10. · Belegarbeit und eigener Linux-Basisfall

**Lernfrage:** Wie mache ich eine Beobachtung überprüfbar und halte normale Vorgänge von ungeklärten Auffälligkeiten auseinander?

- [ ] **W1-MO · 19.10.:** Untersuchungsumfang auf vorhandene eigene Lab-Daten begrenzen; Fallregister, Belegvorlage, Zeitlinienvorlage und Berichtsgerüst anlegen. Eine Frage wählen, die sich aus vorhandenen Benutzer- oder Lab-Logs beantworten lässt, etwa die Reihenfolge eines bekannten Starts.
- [ ] **W1-DI · 20.10.:** Eine kleine vorhandene Log-Auswahl lesend sichern; Herkunft, Zeitraum, Hash und bekannte Lücken dokumentieren. Drei Beobachtungen mit genauer Fundstelle aufnehmen; bei fehlendem Zugriff anhalten und die Datenquelle neu wählen.
- [ ] **W1-MI · 21.10.:** Den bekannten Vorgang zeitlich rekonstruieren; mindestens fünf belegte Stationen aufnehmen, sofern der Datensatz sie enthält. Originalzeit und UTC angeben und doppelte Einträge markieren.
- [ ] **W1-DO · 22.10.:** Zwei alternative Erklärungen prüfen; einen wichtigen Befund unabhängig wiederfinden. Nur die dabei tatsächlich bemerkte Grundlagenlücke gezielt nacharbeiten.
- [ ] **W1-FR · 23.10.:** Einen kurzen Basisfall abschließen, Vorlagen korrigieren und Wochenrückblick schreiben. Zugriff auf Chainsaw und zwei geeignete öffentliche EVTX-Dateien für Woche 2 prüfen; Auswahl und Versionen protokollieren.

**Abnahme W1:** Eine fremde Person kann einen Befund mit der Vorlage wiederfinden; fehlende Daten sind sichtbar; die Quelle für Woche 2 steht fest. Kleine Datenmengen werden nicht durch erfundene Ereignisse aufgefüllt.

**Ergebnisse:** Belegvorlage, Zeitlinienvorlage, Berichtsgerüst, Basisfall und Wochenrückblick 1.

### Woche 2 · 26.10.–01.11. · Windows-Logs und Prozessketten

**Lerneinheiten:** Q1 Events, Q2 Übungslogs, Q3 Lesen/Export. Eine Sysmon-Event-ID wird stets zusammen mit Provider und Kanal betrachtet.

- [ ] **W2-MO · 26.10.:** An den gewählten EVTX-Dateien Provider, Kanal, Event-IDs, Zeitraum und Ereignisanzahl erfassen; Q1 gezielt für tatsächlich vorhandene Ereignistypen lesen.
- [ ] **W2-DI · 27.10.:** Relevante Ereignisse exportieren; fünf Datensätze gegen ihre Originalfelder prüfen. Feldnamen und Schema beachten, statt Spaltenpositionen ungeprüft zu übernehmen.
- [ ] **W2-MI · 28.10.:** Eine Prozessfolge aus Zeit, Prozesskennung bzw. GUID, Parent-Bezug und Befehlszeile herleiten, soweit vorhanden. Zusammenhang zwischen getrennten Testdateien nur bei belegbarer Verbindung behaupten.
- [ ] **W2-DO · 29.10.:** Verdächtige Merkmale, harmlose Erklärungen und fehlende Telemetrie gegenüberstellen. Eine passende ATT&CK-Zuordnung mit Quelle begründen oder ausdrücklich offenlassen.
- [ ] **W2-FR · 30.10.:** **Bericht 1** abschließen: Fragestellung, Daten, Zeitlinie, Befunde, Grenzen und nächste Prüfmaßnahmen. Eine Kernaussage selbst reproduzieren und Wochenrückblick 2 festhalten.

**Abnahme W2:** Drei Hauptaussagen haben genaue Event-Fundstellen; mindestens eine Gegenhypothese wurde geprüft; der Bericht stellt Übungslogs nicht als vollständigen realen Vorfall dar.

**Ergebnisse:** Windows-Loganalyse, Prozesskette, Bericht 1, Gegenhypothese und Wochenrückblick 2.

### Woche 3 · 02.–08.11. · Netzwerkspuren und belastbare Aussagen

**Lerneinheiten:** Q4, Dateien http.cap, dns.cap und danach http_redirects.pcapng. Diese Beispiele sind Protokollübungen; ein Angriff wird ihnen nicht unterstellt.

- [ ] **W3-MO · 02.11.:** Captures aus Q4 auswählen, Quelle und Hashes notieren; Zeitraum, Endpunkte und vorhandene Protokolle erfassen. Eine konkrete Frage pro Capture festlegen.
- [ ] **W3-DI · 03.11.:** HTTP-Anfrage und Antwort in http.cap anhand der Paketnummern verbinden; die Auswahl mit einem zweiten Filter oder einer manuellen Sichtprüfung nachvollziehen.
- [ ] **W3-MI · 04.11.:** DNS-Fragen und Antworten in dns.cap zuordnen; Antwortcode, Typ und beobachtete Namen dokumentieren. Eine Namensauflösung allein nicht als Beleg eines späteren Verbindungsaufbaus behandeln.
- [ ] **W3-DO · 05.11.:** In http_redirects.pcapng eine Weiterleitungskette nachvollziehen und zwei Filter als reproduzierbare Untersuchungsrezepte dokumentieren. Sichtbarkeit und Grenzen bei verschlüsseltem Verkehr erklären.
- [ ] **W3-FR · 06.11.:** **Bericht 2** mit Paket-Fundstellen, Zeitlinie und Grenzen erstellen; mindestens zwei Behauptungen ausdrücklich wegen fehlender Belege verwerfen. Wochenrückblick 3 abschließen.

**Abnahme W3:** Filter und Ergebnisse sind wiederholbar; Paketnummern stützen die Aussagen; auffällig, ungeklärt und nachgewiesen werden sauber unterschieden.

**Ergebnisse:** Netzwerk-Zeitlinie, HTTP/DNS-Nachweise, Bericht 2 und Wochenrückblick 3.

### Woche 4 · 09.–15.11. · Statische PE-Analyse und Encoding

**Lerneinheiten:** Q5 und Q6; dazu eigene harmlose Textproben. Die bereits gelöschte Kawmikaze-Datei ist keine Voraussetzung.

- [ ] **W4-MO · 09.11.:** Eine PE-Datei aus dem offiziellen Strings-Paket als legitime Referenz auswählen; Herkunft, Dateiname, Hash und Analyseumfang erfassen. Q5 General Concepts und die relevanten Headerabschnitte lesen.
- [ ] **W4-DI · 10.11.:** Dateityp, Architektur, Sections und Imports statisch erfassen; an einem tatsächlich vorhandenen Datenbereich VA, RVA und Datei-Offset unterscheiden und die Grenzen der Umrechnung prüfen.
- [ ] **W4-MI · 11.11.:** Einen selbst gewählten harmlosen Text getrennt als UTF-16LE/Base64 sowie als wiederholtes XOR-Beispiel untersuchen. Für jeden Schritt Eingabe, Länge, Ausgabe und Prüfkriterium festhalten; keinerlei dekodierten Text ausführen.
- [ ] **W4-DO · 12.11.:** Ungültiges Base64, abgeschnittene Eingaben und falsche Blockgrenzen bewusst als Datenfehler prüfen. Der Dekodierer muss bei verletzten Voraussetzungen mit verständlichem Fehler abbrechen.
- [ ] **W4-FR · 13.11.:** **Bericht 3** als statische Analyse einer legitimen Referenz und eigener Lernproben abschließen. Beobachtete Strukturen von nur vermuteter Laufzeitfunktion unterscheiden; Wochenrückblick 4 schreiben.

**Abnahme W4:** Die Offset-Erklärung stimmt mit der Section-Tabelle überein; mindestens eine eigene Probe ist reversibel dekodiert; Fehlerfälle brechen kontrolliert ab; der Bericht macht keine Malware- oder Laufzeitbehauptung ohne Beleg.

**Ergebnisse:** Statische PE-Analyse, Encoding-Testprotokoll, Bericht 3 und Wochenrückblick 4.

### Woche 5 · 16.–22.11. · Zwei Erkennungsregeln mit Gegenproben

**Lerneinheiten:** Q7 Rules, Logsources, Conditions und Modifiers; Q3 für die lokale Auswertung. Zuerst einfache unterstützte Bedingungen, anschließend echte Laufprüfung.

- [ ] **W5-MO · 16.11.:** Zwei genaue Erkennungsziele beschreiben: R01 Prozessstart mit codierter PowerShell-Befehlszeile und R02 verdächtiger ausführbarer Pfad in einem Registry-Autostartwert. Benötigte Felder, harmlose Fälle und Grenzen festhalten; die Ziele sind Untersuchungsanlässe, keine automatischen Malware-Urteile.
- [ ] **W5-DI · 17.11.:** Beide Regeln als Sigma-Entwürfe formulieren; logsource, Bedingungen, Schweregrad, Fehlalarmhinweise und Feldmapping begründen. Fehlende Felder oder nicht unterstützte Syntax als Blocker markieren.
- [ ] **W5-MI · 18.11.:** Je Regel drei passende und drei nicht passende Ereignisse unabhängig als harmlose Testdaten erstellen; erwartete Treffer vor dem Lauf festlegen. Format und Mapping mit einem einzelnen Testereignis prüfen.
- [ ] **W5-DO · 19.11.:** Die Regeln mit Chainsaw und passendem Mapping tatsächlich gegen die zwölf Testereignisse laufen lassen. Toolversion, Befehl, Eingangsdaten, Soll, Ist und Ausgaben speichern; zusätzlich einen Test mit fehlendem Pflichtfeld dokumentieren.
- [ ] **W5-FR · 20.11.:** Abweichungen untersuchen, Regeln korrigieren und betroffene Tests erneut ausführen. Erkennungsnotiz mit Voraussetzungen, Fehlalarmquellen und Reaktionsvorschlag erstellen; Wochenrückblick 5 abschließen.

**Abnahme W5:** Zwölf Soll-/Ist-Prüfungen sind nachvollziehbar bestanden; der zusätzliche Fehlfeldtest hat ein dokumentiertes Verhalten. Parser-/Mappingfehler dürfen nicht als erfolgreiche Negativtests gelten. Syntaxprüfung allein reicht nicht. Solange ein nötiger Lauf fehlt, bleibt die Regel ein Entwurf.

**Ergebnisse:** R01.yml, R02.yml, Regeltests.csv, Erkennungsnotiz und Wochenrückblick 5.

### Woche 6 · 23.–29.11. · Neuer Abschlussfall und private Arbeitsproben

**Fallwahl:** Ein noch unbearbeitetes, zugängliches Sherlock mit passendem Log- oder Netzwerkfokus; alternativ ein bisher nicht ausgewähltes EVTX-Beispiel aus Q2. Dateiauswahl und Untersuchungsfrage werden am Montag festgehalten.

- [ ] **W6-MO · 23.11.:** Fall auswählen, Umfang und Datenherkunft festhalten und vor Lösungshilfen eine eigene Erstbewertung schreiben. Drei konkrete Untersuchungsfragen und einen Arbeitsplan festlegen.
- [ ] **W6-DI · 24.11.:** Belege sichten, relevante Ereignisse bzw. Pakete bestimmen und erste Hypothesen prüfen. Werkzeuge und Verarbeitungsschritte vollständig protokollieren.
- [ ] **W6-MI · 25.11.:** Zeitlinie und Gegenhypothese erarbeiten; einen zentralen Befund unabhängig wiederholen. Mindestens zwei Ungewissheiten mit der jeweils benötigten zusätzlichen Datenquelle benennen.
- [ ] **W6-DO · 26.11.:** **Bericht 4** einschließlich kurzer Management-Zusammenfassung und technischer Fundstellen abschließen. Erkennungsidee und angemessene nächste IR-Maßnahmen aus den tatsächlichen Befunden ableiten.
- [ ] **W6-FR · 27.11.:** Vier Berichte und die zwei getesteten Regeln anhand der Abnahmekriterien prüfen; private Ergebnisübersicht und Kompetenzmatrix ausfüllen. Zehn Minuten lang Ablauf, Belege und Grenzen eines Falls selbst erklären; Wochenrückblick 6 und nächste drei Lernziele festhalten.

**Abnahme W6:** Alle sechs Wochenabnahmen sind mit Belegen dokumentiert; vier Berichte und zwei getestete Regeln liegen vor; verbleibende Lücken sind offen benannt. Bei einem unfertigen Fall wird der Abschlussstatus entsprechend geführt.

**Ergebnisse:** Bericht 4, private Ergebnisübersicht, Kompetenzmatrix, Wochenrückblick 6 und nächste Lernziele.

## 7. Gemeinsame Vorlagen

### Belegliste

| Beleg-ID | Quelldatei / SHA-256 | Fundstelle | Beobachtung | Deutung / Alternative | Sicherheit |
| --- | --- | --- | --- | --- | --- |
| E001 | noch einzutragen | Event-/Record-ID, Paketnummer oder Datei-Offset | noch einzutragen | noch einzutragen | belegt / plausibel / offen |

### Zeitlinie

| Originalzeit und Zone | UTC | Beleg-ID | Ereignis | Lücke oder Gegenhypothese |
| --- | --- | --- | --- | --- |
| noch einzutragen | noch einzutragen | E001 | noch einzutragen | noch einzutragen |

### Berichtsgliederung

1. Auftrag und Untersuchungsumfang.
2. Datenherkunft, Integrität und eingesetzte Versionen.
3. Kurzfassung für eine fachfremde Person.
4. Befunde und Zeitlinie mit Fundstellen.
5. Geprüfte Gegenhypothesen und verbleibende Unsicherheit.
6. Erkennungsmöglichkeiten und nächste IR-Maßnahmen.
7. Eigener Anteil, verwendete Hilfen und reproduzierbare Schritte.

### Testprotokoll

| Regel | Test-ID | Erwarteter Treffer | Tatsächliches Ergebnis | Laufnachweis | Status |
| --- | --- | --- | --- | --- | --- |
| R01 oder R02 | noch einzutragen | ja / nein | offen | Toolversion, Befehl, Ausgabedatei | offen |

### Wöchentlicher Rückblick

- Ergebnis und Verweis auf die zugehörigen Dateien.
- Was Pixel1255 selbst erklären und wiederholen konnte.
- Welche Hilfen nötig waren und was dabei gelernt wurde.
- Ein Fehler oder widerlegte Annahme.
- Größter offener Punkt, nächste Handlung und tatsächlicher Zeitaufwand.

## 8. Fortschritt und nächste Fortsetzung

| Woche | Zeitraum | Status | Nachweis |
| --- | --- | --- | --- |
| W1 | 19.–25.10. | offen | noch keiner |
| W2 | 26.10.–01.11. | offen | noch keiner |
| W3 | 02.–08.11. | offen | noch keiner |
| W4 | 09.–15.11. | offen | noch keiner |
| W5 | 16.–22.11. | offen | noch keiner |
| W6 | 23.–29.11. | offen | noch keiner |

**Aktuell:** 0 von 30 Tagesaufgaben erledigt; 0 von 6 Wochen abgenommen.

Updates hier im Chat können zum Beispiel lauten: **W1-MO – Ergebnis: … – Nachweis: … – Blocker: … – nächster Schritt: …**. Wir setzen Haken anhand der gezeigten Ergebnisse. Eine solche Meldung löst keine automatische Veröffentlichung oder Hintergrundüberwachung aus.

Für spätere Arbeitsdateien sind als Namen vorgesehen: Belegvorlage.md, Zeitlinie.csv, Bericht-01-Windows.md, Bericht-02-Netzwerk.md, Bericht-03-Statisch.md, Bericht-04-Abschluss.md, R01.yml, R02.yml und Regeltests.csv. Diese Ergebnisse werden erst in den jeweiligen Lernwochen erstellt; vorhanden ist zunächst diese Checkliste.

**Kompetenzmatrix zum Abschluss:**

| Fähigkeit | Noch offen | Mit Anleitung | Selbst wiederholt | Nachweis |
| --- | --- | --- | --- | --- |
| Belege erfassen und Grenzen benennen | offen | offen | offen | einzutragen |
| Windows-Prozessspuren erklären | offen | offen | offen | einzutragen |
| Netzwerkvorgänge rekonstruieren | offen | offen | offen | einzutragen |
| PE-/Encoding-Strukturen statisch untersuchen | offen | offen | offen | einzutragen |
| Regeln mit passenden und unpassenden Daten testen | offen | offen | offen | einzutragen |
| Ergebnisse verständlich berichten | offen | offen | offen | einzutragen |

## 9. Verfügbare Arbeitsdateien und Links

- To-do / Hauptplan: `GxG-SecOps-6-Wochen-Todo-2026-10-19.md`
- Belegvorlage: `Belegvorlage.md`
- Zeitlinie: `Zeitlinie.csv`
- Bericht 01 – Windows: `Bericht-01-Windows.md`
- Bericht 02 – Netzwerk: `Bericht-02-Netzwerk.md`
- Bericht 03 – Statisch: `Bericht-03-Statisch.md`
- Bericht 04 – Abschluss: `Bericht-04-Abschluss.md`
- Sigma R01: `R01.yml`
- Sigma R02: `R02.yml`
- Regeltests: `Regeltests.csv`

## 10. Abnahme-Prozess (Endgültige Abnahme durch Copilot)

Diese Vereinbarung dokumentiert die finale Regel zur Abnahme von Aufgaben, Wochenpunkten und Ergebnissen in diesem Lernplan. Sie dient der Nachvollziehbarkeit und verhindert versehentliche Abschlussmarkierungen.

### Grundsatz

- Nur die hier als Abnehmende bezeichnete Assistenz („Copilot“, also die Automatisierung in diesem Chat) setzt Checkboxen in diesem Plan auf abgeschlossen, wenn die Anforderungen erfüllt sind.
- Eine Checkbox wird nur dann auf „bestanden“ gesetzt, wenn der Nachweis im Branch vorhanden ist und die Abnahme ausdrücklich bestätigt wurde.
- Eine Aufgabe gilt nur dann als erledigt, wenn die Ergebnisse im Zielbranch nachvollziehbar dokumentiert sind.

### Vereinbarter Ablauf

1. Arbeit und Nachweise: Pixel1255 arbeitet im vereinbarten Branch und legt dort die Aufgabe, Belege, Berichte oder Testdateien ab.
2. Nachweis im Chat: Ein Nachweis wird im Format `W1-MO – Ergebnis: ... – Nachweis: <Link>` übermittelt.
3. Erstprüfung durch Copilot: Copilot prüft die Existenz, Qualität und Vollständigkeit der Nachweise und meldet offene Punkte.
4. Entscheidung: Pixel1255 antwortet mit genau einem Satz: `ok, abnehmen` oder nennt Korrekturen.
5. Finaler Commit durch Copilot: Nach dem ausdrücklichen `ok, abnehmen` wird im Zielbranch die Checkbox gesetzt, der Nachweis ergänzt und ein Commit mit aussagekräftiger Message erstellt.
6. Bestätigung: Copilot meldet kurz die Abnahme mit Commit-Link und Ergebnis.

### Regeln und Grenzen

- Ich werde niemals eigenmächtig eine Checkbox abschließen, ohne deine ausdrückliche Bestätigung.
- Änderungen erfolgen nur im vereinbarten Zielbranch, sofern kein anderer Branch benannt wurde.
- Offene, unvollständige oder nicht nachvollziehbare Nachweise werden nicht als bestanden markiert.
- Wenn du die Abnahme selbst durchführen willst, schreibe `ich übernehme Abnahme`.

### Warum das so bleibt

Diese klare Abnahmeprozedur verhindert versehentliche Abschlussmarkierungen, schützt vor fehlenden Nachweisen und schafft einen nachvollziehbaren Audit-Trail mit Branch-Links und Commit-Historie.

-----

**Leitsatz:** Evidence first. Safety first. Keine Annahme ohne Kennzeichnung. Keine Abnahme ohne Nachweis.
