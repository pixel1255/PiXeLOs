{ config, pkgs, ... }:

{
  boot.initrd.luks.devices."pixel-lab-crypt" = {
    device = "/dev/disk/by-id/ata-SanDisk_SSD_PLUS_120GB_183903802232-part1";
    preLVM = true;
    bypassWorkqueue = true;
  };

  fileSystems."/srv/pixel-lab" = {
    device = "/dev/disk/by-uuid/5572669d-7365-4740-baec-91e38fbef8ae";
    fsType = "ext4";
    options = [ "rw" "nosuid" "nodev" "nofail" ];
  };
}
