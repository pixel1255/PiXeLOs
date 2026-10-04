## ==============================================================================
## MODULES/SYSTEM/WIKI-ALIASES.NIX — INTELLIGENTE ERKLÄR-ALIASE & WIKI-TERMINAL
## Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)
## ==============================================================================
{ config, pkgs, ... }:

{
  environment.shellAliases = {
    # Das ultimative Wiki-Terminal: Erklärt jede Code-Art und Zeile live über Phi-3.5!
    wiki = "${pkgs.ollama-cpu}/bin/ollama run phi3.5 'Du bist der abhörsichere PixelOS-Lab-Wächter. Erkläre mir den folgenden Befehl und jede seiner Zeilen/Optionen haargenau, mikro-chirurgisch, auf Deutsch und gib wertvolle Pentest-Tipps dazu: '";
    
    # Schnellwächter-Sonden für deine 3 Minis
    status-lab = "echo '=== STATUS DER KAPSEL-TRESRE ===' && lsblk /dev/sdb && echo '=== STATUS DER systemd-DIENSTE ===' && systemctl status 'kvm-mini-*' --no-pager";
    
    # Firewall-Auditor Abfrage für OpenSnitch
    logs-firewall = "sudo tail -f /var/log/opensnitchd.log | jq .";
  };
}
