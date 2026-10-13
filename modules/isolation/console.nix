{ config, pkgs, lib, ... }:

{
  services.xserver.enable = false;
  users.users.root.initialPassword = "";
  services.getty.autologinUser = "root";

  environment.systemPackages = with pkgs; [ jq curl pciutils usbutils htop ];

  # Robuste Shell-Init-Begrüßung ohne Escaping-Schlaufen
  programs.bash.interactiveShellInit = ''
    echo "======================================================================"
    echo "       🟢 PIXEL-LAB CONSOLE-VM — INTEGRITY DASHBOARD ACTIVE 🟢"
    echo "======================================================================"
    echo " Verfügbare Schnellbefehle für den isolierten Schutzbetrieb:"
    echo " --------------------------------------------------------------------"
    echo "  lab-status   -> Zeigt RAM-Auslastung, Belegung & Kernel-Version"
    echo "  lab-net      -> Prüft die Netzwerktrennung (Soll: lo-only, eth0 DOWN)"
    echo "  lab-events   -> Zeigt die Whitelist der erlaubten Broker-Aktionen"
    echo "  lab-off      -> Fährt die VM sicher herunter und schließt QEMU"
    echo "  ll           -> Erweiterte, farbige Verzeichnisübersicht (ls -la)"
    echo "======================================================================"
    echo ""
  '';

  environment.shellAliases = {
    "lab-status"  = "echo === LAB STATUS === && free -h && echo && df -h && echo && uname -a";
    "lab-net"     = "ip -br a && ip route";
    "lab-events"  = "cat /etc/pixel-lab/broker-actions.conf 2>/dev/null || echo Keine Broker-Config";
    "lab-off"     = "poweroff";
    "ll"          = "ls -la --color=auto";
  };

  virtualisation.vmVariant = {
    virtualisation = {
      graphics = false;
      sharedDirectories = {};
      writableStore = false;
    };
  };

  services.openssh.enable = false;
  networking.networkmanager.enable = false;
  networking.useDHCP = false;
}
