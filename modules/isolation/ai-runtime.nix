{ config, pkgs, lib, ... }:

{
  # Profile für die drei KI-Rollen innerhalb der Console-VM
  # Speicherlimits sichern den Host (Core i3-4130 / 15 GiB RAM) vor Swapping

  # Watcher: Klein, schnell, verarbeitet VSOCK-Queue (max. 1.5 GiB)
  # Coder: Textbasiert für NixOS/Bash Syntaxhilfe (max. 2.5 GiB)
  # Analyst: Großes Modell, nur auf explizite Anforderung (max. 6 GiB)

  environment.etc."pixel-lab/ai-profiles.conf".text = ''
    role:watcher,ram_limit_mb:1536,priority:low,socket:vsock
    role:coder,ram_limit_mb:2560,priority:normal,socket:internal
    role:analyst,ram_limit_mb:6144,priority:high,socket:internal,state:dormant
  '';
}
