# Co-Created by Pixel1255, Anti-Gravity Gemini & ChatGPT (GxG-Prozess)
# Constants and runtime dependencies are supplied by default.nix.
set -euo pipefail
umask 077

fail() { printf 'kali-slim: %s\n' "$*" >&2; exit 1; }
help_text() {
  cat <<'HELP'
kali-slim help            Hilfe; keine VM-Aenderungen
kali-slim check           KVM-Zugriff und vorhandene Platte pruefen
kali-slim status          Platteninformationen lesen
kali-slim init            Neue, separate 30-GiB-Platte anlegen
kali-slim install ISO     Geprueften NetInstaller mit NAT starten
kali-slim boot            Installierte VM ohne Netzwerk starten
kali-slim boot-online     Installierte VM mit NAT starten

Platte: $HOME/kali-audit-lab/kali-slim/disk.qcow2
RAM: 4096 MiB; CPUs: 2. Kein sudo verwenden.
NAT erlaubt Verbindungen ins Netz und zum Host; keine Portweiterleitungen.
Keine Host-Verzeichnisse, Host-Platten oder USB-Geraete werden eingebunden.
HELP
}

action="${1:-help}"
if [[ "$action" == help || "$action" == --help || "$action" == -h ]]; then
  help_text
  exit 0
fi
case "$action" in
  check|status|init|boot|boot-online) [[ $# -eq 1 ]] || fail 'Unerwartete Argumente.' ;;
  install) [[ $# -eq 2 ]] || fail 'Aufruf: kali-slim install /absoluter/pfad/zum/Installer.iso' ;;
  *) fail "Unbekannter Befehl: $action" ;;
esac
[[ $EUID -ne 0 ]] || fail 'Als normaler Benutzer starten, ohne sudo.'
[[ "${HOME:-}" == /* ]] || fail 'HOME muss ein absoluter Pfad sein.'
vm_dir="$HOME/kali-audit-lab/kali-slim"
disk="$vm_dir/disk.qcow2"

require_kvm() {
  [[ -r /dev/kvm && -w /dev/kvm ]] || fail 'Kein Lese-/Schreibzugriff auf /dev/kvm; Rechte zuerst pruefen.'
}
lock_vm() {
  [[ -d "$vm_dir" && ! -L "$vm_dir" && -O "$vm_dir" ]] || fail 'VM-Ordner fehlt oder ist kein eigener, direkter Ordner.'
  [[ ! -L "$vm_dir/.lock" ]] || fail 'Lockdatei darf kein Symlink sein.'
  exec 9>"$vm_dir/.lock"
  flock --nonblock 9 || fail 'Diese Kali-VM wird bereits verwendet.'
}
require_disk() {
  [[ -f "$disk" && ! -L "$disk" ]] || fail 'Separate VM-Platte fehlt; zuerst init ausfuehren.'
  qemu-img info --output=json "$disk" |
    jq -e --argjson minimum "$((VM_DISK_GIB * 1024 * 1024 * 1024))" \
      '.format == "qcow2" and .["virtual-size"] >= $minimum and .["backing-filename"] == null' >/dev/null ||
    fail 'Platte muss eigenstaendiges QCOW2 mit mindestens 30 GiB sein.'
}

case "$action" in
  status)
    if [[ ! -e "$disk" && ! -L "$disk" ]]; then
      printf 'Noch keine neue Kali-Platte: %s\n' "$disk"
    else
      require_disk
      qemu-img info "$disk"
    fi
    exit 0
    ;;
  check)
    require_kvm
    printf 'KVM-Zugriff vorhanden. RAM: %s MiB; CPUs: %s; neue Platte: %s GiB\n' \
      "$VM_RAM_MIB" "$VM_CPUS" "$VM_DISK_GIB"
    if [[ -e "$disk" || -L "$disk" ]]; then require_disk; fi
    exit 0
    ;;
  init)
    [[ ! -L "$vm_dir" ]] || fail 'VM-Ordner darf kein Symlink sein.'
    mkdir -p -- "$vm_dir"
    lock_vm
    [[ ! -e "$disk" && ! -L "$disk" ]] || fail 'Platte existiert bereits; nichts ueberschrieben.'
    qemu-img create -f qcow2 "$disk" "${VM_DISK_GIB}G"
    exit 0
    ;;
esac

require_kvm
lock_vm
require_disk
extra_args=()
if [[ "$action" == install ]]; then
  iso=$(realpath -e -- "$2")
  [[ -f "$iso" ]] || fail 'Installer muss eine regulaere Datei sein.'
  actual_hash=$(sha256sum < "$iso")
  actual_hash=${actual_hash%% *}
  [[ "$actual_hash" == "$ISO_SHA256" ]] || fail 'Installer-Pruefsumme falsch; Start abgebrochen.'
  iso_qemu=${iso//,/,,}
  extra_args=(-drive "file=$iso_qemu,media=cdrom,readonly=on" -boot order=d,menu=on -no-reboot)
fi

network_args=(-nic none)
if [[ "$action" == install || "$action" == boot-online ]]; then
  network_args=(-nic user,model=virtio-net-pci)
fi
disk_qemu=${disk//,/,,}
printf 'Starte Kali mit %s MiB RAM, %s CPUs; Modus: %s\n' "$VM_RAM_MIB" "$VM_CPUS" "$action"
exec qemu-system-x86_64 \
  -name pixel-kali-slim \
  -accel kvm -cpu host -smp "$VM_CPUS" -m "$VM_RAM_MIB" \
  -drive "file=$disk_qemu,format=qcow2,if=virtio" \
  -vga virtio -display gtk,gl=off \
  -device qemu-xhci -device usb-tablet \
  -monitor none -serial none \
  "${network_args[@]}" "${extra_args[@]}"
