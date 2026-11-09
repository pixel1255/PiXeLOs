// Copyright 2026 Andreas Weidenbach (@pixel1255)
// Licensed under the Apache License, Version 2.0

package policy // Namensschild: Alles hier drin gehört zum Baustein 'policy'

// Rules ist unser Sicherheits-Formular (Großes 'R' -> öffentlich für main.go sichtbar!)
type Rules struct {
	ZeroTrustActive bool   // Schalter: Ist Zero-Trust scharfgeschaltet? (true = An / false = Aus)
	AllowNetwork    bool   // Schalter: Darf die Sandbox ins Internet funken? (true / false)
	AllowHostFS     bool   // Schalter: Darf sie auf die PiXeLOs-Festplatte zugreifen? (true / false)
	MaxMemoryMB     uint64 // Positive Ganzzahl: Wie viel RAM (in MB) bekommt sie maximal?
}

// DefaultSovereignPolicy gibt unsere eiserne "Safety First"-Grundregel zurück.
// Großes 'D' am Anfang -> Funktion darf von außen (z.B. aus main.go) aufgerufen werden!
func DefaultSovereignPolicy() Rules {
	return Rules{
		ZeroTrustActive: true,  // Immer AN! Keine Kompromisse.
		AllowNetwork:    false, // AUS: Strikte Funkstille nach außen!
		AllowHostFS:     false, // AUS: Finger weg vom PiXeLOs-Host-System!
		MaxMemoryMB:     64,    // Nur 64 MB enges Speicherkorsett für den Start.
	}
}
