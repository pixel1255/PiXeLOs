{ config, pkgs, ... }:

{
  # Welle 2C/2E konform: Kein boot.initrd.luks Zwang in Stage 1 (verhindert 90s Boot-Timeout & Crash).
  # Entsperrung erfolgt bewusst manuell bei Bedarf; Mount bleibt bis dahin strikt auf noauto.
  fileSystems."/srv/pixel-lab" = {
    device = "/dev/disk/by-uuid/5572669d-7365-4740-baec-91e38fbef8ae";
    fsType = "ext4";
    options = [ "rw" "nosuid" "nodev" "noauto" "nofail" ];
  };
}
