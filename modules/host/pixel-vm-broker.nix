{
  boot.kernelModules = [ "vhost_vsock" ];
  environment.etc."pixel-lab/broker-actions.conf".text = "status\nstart-hotspot\nstart-builder\nstop-builder\nexport-review\n";
}
