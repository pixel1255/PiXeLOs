{ config, pkgs, lib, ... }:

{
  # Striktes Textkonsolen-Setup ohne X11/Wayland
  services.xserver.enable = false;

  # Login-Sicherheit: Lokale TTY-Anmeldung ohne Netzwerk und ohne Host-Passwörter
  users.users.root.initialPassword = "void";
  services.getty.autologinUser = lib.mkForce "root";

  # Deaktivierung aller nicht verhandelbaren Hardware-Einfallstore
  virtualisation.vmVariant = {
    virtualisation = {
      qemu.options = [
        "-nographic"
        "-monitor none"
        "-serial stdio"
      ];
      # Absolut keine Freigaben des Host-Dateisystems oder Nix-Stores
      sharedDirectories = lib.mkForce {};
      writableStore = false;
    };
  };

  # Zusätzliche Software-Absperrungen
  services.openssh.enable = false;
  networking.networkmanager.enable = false;
  networking.useDHCP = false;
}
