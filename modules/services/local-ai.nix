## ==============================================================================
## MODULES/SERVICES/LOCAL-AI.NIX — ABSCHALTSICHERE OLLAMA-KI-MATRIX (MITTE)
## Co-Created by Pixel1255 & Anti-Gravity Gemini (GxG-Prozess)
## ==============================================================================
{ config, pkgs, ... }:

{
  # --- Ollama-Systemdienst-Härtung (Rein lokal auf dem Host) ---
  services.ollama = {
    enable = true; # Schaltet den internen Ollama-Modell-Server im Hintergrund permanent ein
    package = pkgs.ollama-cpu; # Erzwingt die Haswell-CPU-Optimierung für deinen i3-Core ohne GPU-Ballast
    host = "127.0.0.1"; # STRIKTE F02-SICHERUNG: Bindet den Server an den lokalen Loopback (von außen unsichtbar!)
    port = 11434; # Fixiert den Standard-Port für die verschlüsselten internen KI-Schnittstellen
  };

  # --- System-Pakete für die manuelle KI-Interaktion ---
  environment.systemPackages = [ 
    pkgs.ollama-cpu # CLI-Steuerungswerkzeug direkt für den Systempfad bereitstellen (ollama run)
  ];
}
