# Co-Created by Pixel1255, Anti-Gravity Gemini & ChatGPT (GxG-Prozess)
{ self, nixpkgs }:
let
  system = "x86_64-linux";
  pkgs = import nixpkgs { inherit system; };
  kaliSlim = pkgs.callPackage ./default.nix { };
  settings = import ./settings.nix;
in
{
  packages.${system} = {
    kali-slim = kaliSlim;
    kali-installer = pkgs.fetchurl settings.installer;
  };

  apps.${system}.kali-slim = {
    type = "app";
    program = "${kaliSlim}/bin/kali-slim";
  };

  # Nur den Starter und seine Schutzbedingungen testen. Kein VM-Start.
  checks.${system} = {
    kali-slim = kaliSlim;
    kali-slim-behaviour = pkgs.runCommand "kali-slim-behaviour" {
      nativeBuildInputs = [ pkgs.python3 pkgs.bash pkgs.jq pkgs.util-linux pkgs.coreutils ];
    } ''
      python3 ${./test_launcher.py} ${./launcher.sh}
      touch "$out"
    '';
  };
}
