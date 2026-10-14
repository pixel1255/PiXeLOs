# ==============================================================================
# FLAKE.NIX — ZENTRALER EINSTIEGSPUNKT DER NIXOS-FLAKE
# Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)
# ==============================================================================
{
  description = "PiXeL1255 Intel Main — Modularisierte System-Infrastruktur"; # Deklarative Kurzbeschreibung des gesamten Projekts

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # Definiert das Quell-Repository für die Paketbasis (Rolling Release Unstable)

  outputs = { self, nixpkgs }: { # Definiert die Ausgabestrukturen, die aus den Inputs generiert werden
      kali-audit = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./modules/virtualisation/kali-guest.nix ];
      };

    nixosConfigurations.pixel1255 = nixpkgs.lib.nixosSystem { # Erzeugt die spezifische Systemkonfiguration für den Hostnamen 'pixel1255'
      system = "x86_64-linux"; # Fixiert die Zielarchitektur auf klassische 64-Bit Intel/AMD physische Hardware
      modules = [ # Array der primären Konfigurationsmodule, die geladen werden müssen
        ./host/configuration.nix # Verweist auf den Hauptdirigenten, der alle Sub-Module und Kategorien zusammenzieht
      ];
    };
  };
}
