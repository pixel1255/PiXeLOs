{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.kate
    kdePackages.spectacle
    kdePackages.ark
    kdePackages.gwenview
    kdePackages.okular
    kdePackages.partitionmanager
    kdePackages.kcalc
    kdePackages.plasma-systemmonitor
    kdePackages.kio-extras

    obsidian
    easyeffects

    libimobiledevice
    ifuse

    usbutils
    usb-modeswitch

    alsa-utils

    nano
    vim

    curl
    wget

    jq
    tree

    ripgrep
    fd
    fzf

    unzip
    zip
    p7zip

    file
    lsof
    strace

    htop
    btop
    fastfetch

    pciutils
    lm_sensors
    smartmontools

    rsync
    hexyl
    exiftool
    binutils
    less

    git
    python3
  ];
}
