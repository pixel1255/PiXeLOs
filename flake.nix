# ==============================================================================
# FLAKE.NIX — ZENTRALER EINSTIEGSPUNKT DER NIXOS-FLAKE
# Co-Created by Pixel1255 & Anti-Gravity Gemini (GxG-Prozess)
# ==============================================================================
{
  description = "PiXeL1255 Intel Main — Modularisierte System-Infrastruktur"; 

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; 

  outputs = { self, nixpkgs }: { 
    
    # --- DEINE NEUE KAPSEL-KONFIGURATION [WELLE 2] ---
    nixosConfigurations.kali-audit = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./modules/virtualisation/kali-guest.nix ];
    };

    # --- DEIN COCKPIT-HOST (PIXEL1255) ---
    nixosConfigurations.pixel1255 = nixpkgs.lib.nixosSystem { 
      system = "x86_64-linux"; 
      modules = [ ./host/configuration.nix ];
    };
  };
}
