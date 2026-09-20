{
  networking.networkmanager.enable = false;
  networking.useDHCP = false;
  services.openssh.enable = false;

  virtualisation.vmVariant = {
    virtualisation = {
      qemu.options = [
        "-nographic"
        "-serial stdio"
      ];
      sharedDirectories = {};
      writableStore = false;
    };
  };
}
