{ config, pkgs, lib, ... }:

{
  boot.kernelModules = [
    "kvm-intel"
    "ipheth"
    "mt76x0u"
    "mt76x2u"
    "mt76x02-usb"
    "mt76x02-lib"
    "mt76-usb"
    "mt76"
  ];

  hardware.enableRedistributableFirmware = true;

  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.usb-modeswitch.enable = true;

  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
}
