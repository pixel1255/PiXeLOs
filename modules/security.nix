{ pkgs, ... }: {
  systemd.services.guardian-shell = {
    description = "Lean Guardian AI - System Monitor";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.bash}/bin/bash -c 'while ${pkgs.inotify-tools}/bin/inotifywait -e modify /var/log/lastlog; do sudo -u pixel1255 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus ${pkgs.libnotify}/bin/notify-send \"🛡️ Lean Alert\" \"System-Event in /var/log/lastlog registriert\"; done'";
      Restart = "always";
      RestartSec = "10s";
      Nice = 19;
      CPUSchedulingPolicy = "idle";
      CPUWeight = 1;
      IOWeight = 1;
    };
    path = with pkgs; [ bash inotify-tools libnotify sudo ];
  };
  environment.systemPackages = with pkgs; [ libnotify inotify-tools ];
}
