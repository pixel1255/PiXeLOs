## ==============================================================================
## MODULES/SERVICES/LOCAL-AI.NIX — DEKLARATIVE OLLAMA- & MODEL-KONFIGURATION
## Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)
## ==============================================================================
{ config, pkgs, ... }:

{
  # Aktiviert den systemweiten Ollama-Daemon auf dem Host
  services.ollama = {
    enable = true;
    acceleration = null; # Erzwingt den reinen, ressourcenschonenden CPU-Betrieb für die i3-Zentrale
  };

  # Deklariert die flüchtigen, systemweiten KI-Modelle im Nix-Store
  environment.systemPackages = [
    pkgs.ollama
  ];

  # systemd-Service, der nach dem Start von Ollama die benötigten Mini-SLMs
  # vollautomatisch in den lokalen Cache zieht
  systemd.services."ollama-model-loader" = {
    description = "Zieht die lokalen Mini-SLMs autonom in das PixelOS Lab";
    after = [ "ollama.service" ];
    wantedBy = [ "multi-user.target" ];
    script = ''
      echo "Lade Info-Tafel-Gehirn (Host)..."
      ${pkgs.ollama}/bin/ollama pull phi3.5:mini
      echo "Lade Kapsel-Gehirne (Mini-A & Mini-B)..."
      ${pkgs.ollama}/bin/ollama pull llama3.2:1b
    '';
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };
}
