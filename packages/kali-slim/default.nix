# Co-Created by Pixel1255, Anti-Gravity Gemini & ChatGPT (GxG-Prozess)
{ lib, writeShellApplication, qemu_kvm, coreutils, util-linux, jq }:
let
  settings = import ./settings.nix;
in
writeShellApplication {
  name = "kali-slim";
  inheritPath = false;
  runtimeInputs = [ qemu_kvm coreutils util-linux jq ];
  text = ''
    readonly VM_RAM_MIB=${toString settings.ramMiB}
    readonly VM_CPUS=${toString settings.cpus}
    readonly VM_DISK_GIB=${toString settings.diskGiB}
    readonly ISO_SHA256=${lib.escapeShellArg settings.installer.sha256}
  '' + builtins.readFile ./launcher.sh;
}
