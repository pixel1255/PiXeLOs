{ config, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cpu;
  };
  environment.systemPackages = [ pkgs.ollama-cpu ];
}
