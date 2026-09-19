# Version 0 Runtime Receipt

Date: 2026-09-19

## Boot

Intel root:

- label: `NIXOS_ROOT`
- UUID: `2812c87f-9d4f-4b4f-a554-579a4ae40d13`

Intel EFI:

- label: `NIXOS_EFI`
- UUID: `28A0-0C37`

Running system:

- host: `pixel1255`
- kernel: `6.12.103`
- NixOS nixpkgs revision: `e5bdc4a`
- system:
  `/nix/store/w53n96z2m2char9rbx508f6a5ib3qjjs-nixos-system-pixel1255-26.11.20260816.e5bdc4a`

SanDisk remains separate and is not the running root filesystem.

## Desktop

- display-manager: active
- SDDM: active
- Plasma: 6.7.4
- Kate: 26.04.3
- Dolphin: available

## Graphics

Intel Haswell integrated graphics:

- PCI ID: `8086:041e`
- driver: `i915`
- i915 module: loaded

## Network

Realtek Ethernet:

- interface: `enp2s0`
- driver: `r8169`
- physical link during audit: down / no carrier

iPhone USB tethering:

- interface: `enp0s26u1u3c4i2`
- driver: `ipheth`
- state during audit: up
- DHCP address during audit: `172.20.10.4/28`
- usbmuxd: active

## FRITZ!WLAN AC 430

USB device detected:

- USB ID: `057c:8602`
- product: FRITZ!WLAN USB Stick AC 430 MU-MIMO

Loaded modules during audit include:

- mt76x0u
- mt76x2u
- mt76x02_usb
- mt76x02_lib
- mt76_usb
- mt76

Version 0 does NOT claim working WLAN support for this device.

No WLAN network interface was demonstrated by the Version-0 runtime audit.

## Audio

- PipeWire user service: active
- WirePlumber user service: active

Plasma version query emitted a Qt Multimedia PipeWire symbol warning.
Desktop operation itself was successful.

## Bluetooth

Configured in NixOS.

Runtime service during Version-0 audit:

- bluetooth: inactive

This remains a follow-up item.

## CLI / tools verified

Available:

- kate
- dolphin
- git
- python3
- curl
- wget
- jq
- tree
- ripgrep
- fd
- fzf
- smartctl
- fastfetch

## Firefox

Firefox Beta is declared in `configuration.nix`.

The Version-0 audit command:

    command -v firefox

did not resolve an executable.

This remains a follow-up item and is intentionally documented rather
than silently changed before the Version-0 snapshot.

## Known configuration warning

The installed configuration still uses:

    programs.bash.enableCompletion

Current nixpkgs reports that it has been renamed to:

    programs.bash.completion.enable

This is a non-fatal follow-up item after Version 0.
