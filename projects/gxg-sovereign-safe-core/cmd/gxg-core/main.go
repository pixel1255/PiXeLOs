// Copyright 2026 Andreas Weidenbach (@pixel1255)
// Licensed under the Apache License, Version 2.0

package main // Hauptpaket: Hier startet immer das ausführbare Programm

import (
	"fmt"                    // Standard-Werkzeug von Go für Textausgaben im Terminal
	"github.com/pixel1255/PiXeLOs/projects/gxg-sovereign-safe-core/pkg/policy" // Hole unseren eigenen Türsteher-Baustein herein!
)

func main() {
	fmt.Println("==================================================")
	fmt.Println("🛡️  GxG Sovereign Safe-Core (Ardogan-Engine) v0.1")
	fmt.Println("==================================================")

	// ':=' erstellt die Variable 'rules' und füllt sie direkt mit den Werten vom Türsteher
	rules := policy.DefaultSovereignPolicy()

	fmt.Println("[+] Säule 1 (Policy Engine) aktiv geladen:")
	fmt.Printf("    -> Zero-Trust aktiv:  %v\n", rules.ZeroTrustActive) // %v gibt true/false aus
	fmt.Printf("    -> Netzwerk erlaubt:  %v\n", rules.AllowNetwork)    // %v gibt true/false aus
	fmt.Printf("    -> Host-FS erlaubt:   %v\n", rules.AllowHostFS)     // %v gibt true/false aus
	fmt.Printf("    -> Max. RAM-Limit:    %d MB\n", rules.MaxMemoryMB)  // %d gibt eine Dezimalzahl aus
	fmt.Println("==================================================")
}
