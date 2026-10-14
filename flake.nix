# ==============================================================================
# FLAKE.NIX — ZENTRALER EINSTIEGSPUNKT DER NIXOS-FLAKE (MIT MASTER-KEY)
# Co-Created by Pixel1255 & Anti-Gravity Gemini (GxG-Prozess)
# ==============================================================================
{
  description = "PiXeL1255 Intel Main — Modularisierte System-Infrastruktur"; 

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; 

  outputs = { self, nixpkgs }: { 
    
    nixosConfigurations.kali-audit = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./modules/virtualisation/kali-guest.nix 
        # DAS MITGELIEFERTE ENTWICKLER-GATTER: Erzwingt das Passwort "p" für alle VM-Instanzen!
        ({ pkgs, ... }: {
          users.users.audit-user.password = "p";
          users.users.root.password = "p";
        })
      ];
    };

    nixosConfigurations.pixel1255 = nixpkgs.lib.nixosSystem { 
      system = "x86_64-linux"; 
      modules = [ ./host/configuration.nix ];
    };
  };
}
