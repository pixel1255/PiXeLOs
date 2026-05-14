{ pkgs, lib, ... }: {
  nix.gc = { automatic = true; dates = "weekly"; options = "--delete-older-than 7d"; };
  nix.settings.auto-optimise-store = true;
  
  systemd.services.ram-guardian = {
    description = "Putzdienst bei RAM-Engpass (>80%)";
    wantedBy = [ "multi-user.target" ];
    script = ''
      while true; do
        usage=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100.0}')
        if [ "$usage" -gt 80 ]; then
          sync
          echo 1 > /proc/sys/vm/drop_caches
          sudo -u pixel1255 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus ${pkgs.libnotify}/bin/notify-send "🛡️ RAM-Guardian" "RAM bei $usage% - Pagecache geleert!"
        fi
        sleep 30
      done
    '';
    serviceConfig = {
      User = "root";
    };
    path = with pkgs; [ bash coreutils gawk bc libnotify sudo ];
  };

  environment.shellAliases = {
    putz-ram = "sudo sync; echo 1 | sudo tee /proc/sys/vm/drop_caches";
    putz-nix = "nix-collect-garbage --delete-older-than 7d";
  };
}
