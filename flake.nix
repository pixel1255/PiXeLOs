# ==============================================================================
# FLAKE.NIX — ZENTRALER EINSTIEGSPUNKT DER NIXOS-FLAKE
# Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)
# ==============================================================================
{
  description = "PiXeL1255 Intel Main — Modularisierte System-Infrastruktur"; # Deklarative Kurzbeschreibung des gesamten Projekts

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Definiert das Quell-Repository für die Paketbasis (Rolling Release Unstable)

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      miniA = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [ ./hosts/mini-a/default.nix ];
      };
    in { # Definiert die Ausgabestrukturen, die aus den Inputs generiert werden
    nixosConfigurations.pixel1255 = nixpkgs.lib.nixosSystem { # Erzeugt die spezifische Systemkonfiguration für den Hostnamen 'pixel1255'
      specialArgs = { inherit miniA; };
      system = "x86_64-linux"; # Fixiert die Zielarchitektur auf klassische 64-Bit Intel/AMD physische Hardware
      modules = [ # Array der primären Konfigurationsmodule, die geladen werden müssen
        ./host/configuration.nix # Verweist auf den Hauptdirigenten, der alle Sub-Module und Kategorien zusammenzieht
      ];
    };
    nixosConfigurations.miniA = miniA;
  };
}
