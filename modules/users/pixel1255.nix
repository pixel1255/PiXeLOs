## ==============================================================================
## MODULES/USERS/PIXEL1255.NIX — HOST USER-IDENTITÄT & UNZERSTÖRBARE COCKPIT-NAV
## Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)
## ==============================================================================
{ config, pkgs, ... }:

{
  # --- Haupt-Benutzerkonto Konfiguration ---
  users.users.pixel1255 = {
    isNormalUser = true;
    description = "PiXeL1255 OS Architect";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "kvm" "libvirtd" ];
    homeMode = "0700";
    packages = with pkgs; [ eza ];
  };

  # --- Terminal-Branding & Interaktive Funktionen ---
  programs.bash.interactiveShellInit = ''
    info-os() { # Funktion für Logo und System-Status
      echo -e "\e[1;33m" # Gelbe Farbe für das Branding
      cat << "LOGO"
 ██████╗  ██████╗  ██████╗ ██╗██╗  ██╗███████╗██╗          ██╗██████╗ ███████╗███████╗
 ██╔═══██╗██╔═══██╗██╔══██╗██║╚██╗██╔╝██╔════╝██║         ███║╚════██╗██╔════╝██╔════╝
 ██║   ██║██║   ██║██████╔╝██║ ╚███╔╝ █████╗  ██║         ╚██║ █████╔╝███████╗███████╗
 ██║   ██║██║   ██║██╔═══╝ ██║ ██╔██╗ ██╔══╝  ██║          ██║██╔═══╝ ╚════██╗╚════██╗
 ╚██████╔╝╚██████╔╝██║     ██║██╔╝ ██╗███████╗███████╗     ██║███████╗███████╗███████╗
  ╚═════╝  ╚═════╝ ╚═╝     ╚═╝╚═╝  ╚═╝╚══════╝╚══════╝     ╚═╝╚══════╝╚══════╝╚══════╝

                 >>>  C R E A T E D   B Y   G X G  <<<
LOGO
      echo -e "\e[0m" # Farbe zurücksetzen
      echo -e "\e[1;33mVerfügbare Befehle & Aliase:\e[0m"
      echo -e " \e[1;32mupdate\e[0m     : System-Update & Rebuild (Gold-Modus)"
      echo -e " \e[1;32mcleanup\e[0m    : Müll löschen, Store optimieren & RAM leeren"
      echo -e " \e[1;32mlab\e[0m        : Direkt-Start der fertigen Hotspot-Appliance-VM"
      echo -e " \e[1;32magy\e[0m        : Anti-Gravity — OpenSnitch Firewall GUI aufrufen"
      echo -e " \e[1;32mls / ll\e[0m    : Modernes Listing (eza) mit Icons"
      echo -e " \e[1;32mtree\e[0m       : Verzeichnisstruktur als Baum anzeigen"
      echo -e "\n\e[1;35mDirekt-Starter Apps & Pfade:\e[0m"
      echo -e " firefox | dolphin | kate | home | desktop"
      echo -e "\n\e[1;34mSystem:\e[0m PiXeL1255CreatedOs - Pure Architect Edition"
    }
    info-os # Logo beim Start anzeigen
    
    if command -v zoxide >/dev/null 2>&1; then
      eval "$(zoxide init bash)"
    fi
  '';

  # --- Aliase für Effizienz (Mit unzerstörbarer nohup-Entkopplung) ---
  programs.bash.shellAliases = {
    update = "sudo nixos-rebuild switch --flake /etc/nixos/#pixel1255";
    cleanup = "sudo sync; echo 3 | sudo tee /proc/sys/vm/drop_caches && nix-collect-garbage --delete-older-than 7d";
    lab = "cd ~/pixel-vm-native-build-104-v4VqdFWB && nohup ./pixel-vm start >/dev/null 2>&1 & disown";
    
    ll = "eza -l --icons --group-directories-first";
    ls = "eza --icons --group-directories-first";

    # --- AGY & APPS: Radikal vom Terminal-Prozess losgelöst ---
    agy     = "nohup opensnitch-ui >/dev/null 2>&1 & disown";
    firefox = "nohup firefox >/dev/null 2>&1 & disown"; # Gefixt: Greift nun auf den regulären Host-Firefox
    dolphin = "nohup dolphin >/dev/null 2>&1 & disown";
    kate    = "nohup kate >/dev/null 2>&1 & disown";

    # --- Blitzschnelle Verzeichnis-Sprünge ---
    home    = "cd ~ && eza --icons --group-directories-first";
    desktop = "cd ~/Schreibtisch 2>/dev/null || cd ~/Desktop && eza --icons --group-directories-first";
  };
}
