# ==============================================================================
# MODULES/SYSTEM/WIKI-ALIASES.NIX — SCHARFE STEUERUNGS-SONDEN FÜR DIE RECHTE KAPSEL
# Co-Created by Pixel1255 & Anti-Gravity Gemini (GxG-Prozess)
# ==============================================================================
{ config, pkgs, ... }:

{
  # --- Statische Steuerungs-Aliase ---
  environment.shellAliases = {
    status-lab = "echo '=== KAPSEL-TRESOR ===' && lsblk /dev/sdb && echo '=== ACTIVE WORKSPACE GUESTS ===' && sudo virsh list --all";
    logs-firewall = "sudo tail -f /var/log/opensnitchd.log | jq .";
    
    # --- Direkt-Starter Host (Monitor 2 - Mitte) ---
    lab     = "cd ~/pixel-vm-native-build-104-v4VqdFWB && nohup ./pixel-vm start >/dev/null 2>&1 & disown";
    agy     = "nohup env LD_LIBRARY_PATH=/run/current-system/sw/lib opensnitch-ui >/dev/null 2>&1 & disown";
    firefox = "nohup env LD_LIBRARY_PATH=/run/current-system/sw/lib firefox >/dev/null 2>&1 & disown";
    dolphin = "nohup env LD_LIBRARY_PATH=/run/current-system/sw/lib dolphin >/dev/null 2>&1 & disown";
    kate    = "nohup env LD_LIBRARY_PATH=/run/current-system/sw/lib kate >/dev/null 2>&1 & disown";
    home    = "cd ~ && eza --icons --group-directories-first";
    desktop = "cd ~/Schreibtisch 2>/dev/null || cd ~/Desktop && eza --icons --group-directories-first";

    # --- DIE NEUEN STRATEGISCHEN KALI-KAPSEL BEFEHLE (Monitor 3 - Rechts) ---
    kali-start   = "sudo virsh start pixel-lab-kali-audit && virt-viewer -c qemu:///system pixel-lab-kali-audit &";
    kali-stop    = "sudo virsh shutdown pixel-lab-kali-audit";
    kali-status  = "sudo virsh dominfo pixel-lab-kali-audit";
  };

  # --- Intelligente interaktive Funktionen (Kapselt Eingaben sicher als Text) ---
  programs.bash.interactiveShellInit = ''
    wiki() {
      if [ -z "$*" ]; then
        echo -e "\e[1;31m[WÄCHTER]: Kein Befehl übergeben! Nutzung: wiki <befehl>\e[0m"
        return 1
      fi
      # Reicht alle Argumente ($*) als sauberen, geschützten Text-String an Ollama weiter!
      ${pkgs.ollama-cpu}/bin/ollama run phi3.5 "Du bist der abhörsichere PixelOS-Lab-Wächter. Erkläre mir den folgenden Befehl haargenau, mikro-chirurgisch, auf Deutsch und gib wertvolle Pentest-Tipps dazu: $*"
    }
  '';
}
