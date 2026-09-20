# Testdokument – Vorlage

Stand: JJJJ-MM-TT
Welle: Nummer und Name
Status: geplant / in Arbeit / grün / gelb / rot

## 1. Zweck und Grenze

- Was wird mit dieser Schicht erreicht?
- Was gehört ausdrücklich nicht zu dieser Schicht?
- Welche Systeme oder Daten dürfen nicht verändert werden?

## 2. Feste Identitäten

| Objekt | Erwarteter Wert | Quelle |
| --- | --- | --- |
| Beispiel | UUID, Name oder Pfad | gemessen / Flake / Inventur |

Keine schreibende Aktion darf nur von einem flüchtigen Namen wie `/dev/sdX` abhängen.

## 3. Startzustand

- erwartete Mounts:
- erwartete Mapper:
- erwartete Dienste:
- erwarteter Git-Status:
- bekannte Warnungen:

## 4. Was wird getestet?

### Positivtest

- erwartete Funktion:
- messbarer Beweis:

### Negativtest

- bewusst abgelehnter Zustand:
- messbarer Beweis:

### Isolationstest

- verbotene Sichtbarkeit oder Zugriff:
- messbarer Beweis:

## 5. Wie wird getestet?

1. read-only Vorprüfung,
2. genaue Zielanzeige,
3. kleinste notwendige Änderung,
4. Positivtest,
5. Negativ- oder Isolationstest,
6. Rückkehr in den sicheren Endzustand,
7. bereinigter Grünbericht.

Geplantes Prüfkommando:

`nix run .#welle-XX-testname`

Das Kommando darf erst als vorhanden dokumentiert werden, wenn es in der Flake gebaut und grün getestet wurde.

## 6. Wann und wie oft?

| Anlass | Häufigkeit |
| --- | --- |
| vor der ersten Änderung | einmal |
| nach jeder Änderung dieser Schicht | jedes Mal |
| nach relevanter Host- oder Abhängigkeitsänderung | einmal pro Änderung |
| vor Commit | einmal pro Commitkandidat |
| im Betrieb | begründetes Intervall, nicht künstlich |

Destruktive Erzeugungsschritte werden niemals als regelmäßiger Test verwendet.

## 7. Grün-, Gelb- und Rotkriterien

### Grün

-

### Gelb

-

### Rot

-

## 8. Sicherer Endzustand

- Was muss beendet, geschlossen oder ausgehängt sein?
- Welche Daten dürfen zurückbleiben?
- Welche temporären Dateien müssen entfernt sein?

## 9. Logregeln

- erlaubte Felder:
- zu schwärzende Felder:
- Speicherort des Rohlogs:
- Speicherort des Grünberichts:
- Aufbewahrungsdauer:

## 10. Aktueller Laufeintrag

- Datum:
- Anlass:
- Ergebnis:
- Abweichungen:
- Status:
- Commit-Freigabe:
