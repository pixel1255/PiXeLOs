{
  boot.kernelModules = [ "kvm-intel" ];
  boot.blacklistedKernelModules = [ "ndiswrapper" ];
  networking.bridges."br-hotspot".interfaces = [];
}
