# ==============================================================================
# MODULES/SYSTEM/WIKI-ALIASES.NIX — INTELLIGENTE ERKLÄR-ALIASE & WIKI-TERMINAL
# Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)
# ==============================================================================
{ config, pkgs, ... }:

{
  environment.shellAliases = {
    wiki = "${pkgs.ollama-cpu}/bin/ollama run phi3.5 'Du bist der abhörsichere PixelOS-Lab-Wächter. Erkläre mir den folgenden Befehl und jede seiner Zeilen/Optionen haargenau, mikro-chirurgisch, auf Deutsch und gib wertvolle Pentest-Tipps dazu: '";
    status-lab = "echo '=== STATUS DER KAPSEL-TRESRE ===' && lsblk /dev/sdb && echo '=== STATUS DER systemd-DIENSTE ===' && systemctl status 'kvm-mini-*' --no-pager";
    logs-firewall = "sudo tail -f /var/log/opensnitchd.log | jq .";
    
    # Der ultimative Direkt-Start für deine fertige Appliance
    lab = "cd ~/pixel-vm-native-build-104-v4VqdFWB && ./pixel-vm start";

    # Die libvirt/virsh Steuerungs-Sonden
    hotspot-start   = "sudo virsh start pixel-lab-hotspot && virt-viewer -c qemu:///system pixel-lab-hotspot &";
    hotspot-stop    = "sudo virsh shutdown pixel-lab-hotspot";
    hotspot-console = "sudo virsh console pixel-lab-hotspot";
    hotspot-status  = "sudo virsh dominfo pixel-lab-hotspot";
  };
}
