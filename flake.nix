{
  description = "PiXeL1255 Intel Main";

  inputs.nixpkgs.url =
    "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    nixosConfigurations.pixel1255 =
      nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./configuration.nix
        ];
      };
  };
}
