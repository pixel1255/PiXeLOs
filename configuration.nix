{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # ============================================================
  # HOST
  # ============================================================

  networking.hostName = "pixel1255";

  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = "de_DE.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  console.keyMap = "de-latin1";

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  # ============================================================
  # BOOT
  # ============================================================

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

  # ============================================================
  # USB / IPHONE / AC430 / KVM
  # ============================================================

  boot.kernelModules = [
    "kvm-intel"

    "ipheth"

    "mt76x0u"
    "mt76x2u"
    "mt76x02-usb"
    "mt76x02-lib"
    "mt76-usb"
    "mt76"
  ];

  hardware.enableRedistributableFirmware = true;

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault
      config.hardware.enableRedistributableFirmware;

  hardware.usb-modeswitch.enable = true;

  # ============================================================
  # INTEL GRAPHICS
  # ============================================================

  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  # ============================================================
  # BLUETOOTH
  # ============================================================

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # ============================================================
  # NETWORK
  # ============================================================

  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;

    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  services.printing.enable = true;

  # ============================================================
  # KDE PLASMA
  # ============================================================

  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  # ============================================================
  # AUDIO
  # ============================================================

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;
    jack.enable = true;

    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 512;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 1024;
      };
    };
  };

  # ============================================================
  # USER
  # ============================================================

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

  programs.bash.enableCompletion = true;

  # ============================================================
  # FIREFOX
  # ============================================================

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
  };

  # ============================================================
  # PAKETE
  # ============================================================

  nixpkgs.config.allowUnfree = true;

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

  # ============================================================
  # ZRAM
  # ============================================================

  zramSwap.enable = true;

  # ============================================================
  # ALTE ABLAGE
  # ============================================================

  fileSystems."/mnt/Ablage" = {
    device =
      "/dev/disk/by-uuid/9ceeac28-81cc-461e-928a-a4064ff0f8c8";

    fsType = "ext4";

    options = [
      "nofail"
      "x-systemd.device-timeout=5s"
    ];
  };

  # ============================================================
  # NIX
  # ============================================================

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;

      trusted-users = [
        "root"
        "pixel1255"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  system.stateVersion = "24.11";
}
