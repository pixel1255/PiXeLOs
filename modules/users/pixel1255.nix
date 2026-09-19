{ pkgs, ... }:

{
  users.users.pixel1255 = {
    isNormalUser = true;
    description = "PiXeL1255";
    home = "/home/pixel1255";
    createHome = true;
    shell = pkgs.bashInteractive;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "dialout"
      "kvm"
    ];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  programs.bash.completion.enable = true;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
  };
}
