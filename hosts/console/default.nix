{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/isolation/console.nix
  ];

  networking.hostName = "pixel-lab-console";
  system.stateVersion = "26.11";

  # Konservatives Ressourcenprofil für den i3-4130
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 1024; # 1 GiB RAM
      cores = 1;         # 1 Kern
    };
  };
}
