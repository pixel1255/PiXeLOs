{ pkgs, ... }:

{
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
      consoleMode = "max";
    };
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "50%";
  };

  boot.kernelPackages = pkgs.linuxPackages_6_12;
}
