{ config, pkgs, lib, ... }:

{
  networking.networkmanager.enable = false;
  networking.useDHCP = false;
  services.openssh.enable = false;

  # Automatischer Root-Login an TTY und serieller Konsole für Testbetrieb
  users.users.root.initialPassword = "";
  services.getty.autologinUser = lib.mkForce "root";

  virtualisation.vmVariant = {
    virtualisation = {
      graphics = false;
      sharedDirectories = {};
      writableStore = false;
    };
  };
}
