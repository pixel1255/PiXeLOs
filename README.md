# PiXeL NixOS

Clean NixOS rebuild for the physical Intel host.

This repository starts with a completely new Git history.

## Version 0

`v0.0.0` is the first booted clean baseline.

Hardware:

- Intel SSDSA2M160G2LE
- Intel Core i3-4130
- Intel Haswell integrated graphics
- Realtek RTL8111/8168 Ethernet
- 16 GiB RAM

System baseline:

- NixOS
- Linux 6.12
- systemd-boot / UEFI
- KDE Plasma 6
- SDDM / Wayland
- NetworkManager
- PipeWire
- iPhone USB tethering
- USB modeswitch
- FRITZ!WLAN AC 430 retained as experimental hardware path
- Firefox Beta declaration
- original SanDisk package/tool set

## Git model

- `main` = booted / tested stable state
- `dev`  = next changes and experiments

Nothing goes into `main` merely because it evaluates.
It should first be tested on the real host.

## Rebuild

From this repository:

    sudo nixos-rebuild test --flake .#pixel1255

After successful runtime testing:

    sudo nixos-rebuild switch --flake .#pixel1255

## Versioning

Initial baseline:

    v0.0.0

Future changes build from this point.
