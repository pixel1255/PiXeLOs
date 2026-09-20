{
  imports = [
    ../../modules/isolation/builder.nix
  ];

  networking.hostName = "pixel-lab-builder";
  system.stateVersion = "26.11";

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 2048;
      cores = 2;
    };
  };
}
