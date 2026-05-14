{ pkgs, ... }: { # Die Funktion greift auf das NixOS-Paket-Repository zu.

  i18n.defaultLocale = "de_DE.UTF-8"; # Setzt die Systemsprache auf Deutsch mit UTF-8 Kodierung für korrekte Sonderzeichen.
  console.keyMap = "de"; # Konfiguriert das deutsche Tastaturlayout für die virtuelle Konsole (TTY).
  services.xserver.xkb.layout = "de"; # Legt das deutsche Tastaturlayout für die grafische Oberfläche (X11/Plasma) fest.

  # Erzwinge Tastatur-Treiber direkt beim Booten
  boot.initrd.availableKernelModules = [ "atkbd" "i8042" "usbhid" "hid_generic" ]; # Lädt essenzielle Treiber für PS/2- und USB-Tastaturen direkt in der frühen Bootphase (Initrd), damit du bei Problemen sofort eingreifen kannst.

  services.libinput.enable = true; # Aktiviert das moderne Libinput-Framework zur präzisen Steuerung von Touchpads und Mäusen.

  services.usbmuxd.enable = true; # Aktiviert den Dienst für die USB-Kommunikation mit Apple-Geräten, was die technische Basis für dein iPhone-Tethering bildet.
}

/* * 📜 ARCHITEKTEN-NOTIZ FÜR DIE COMMUNITY:
 * ----------------------------------------
 * Die hardware.nix ist die Schnittstelle für die menschliche Interaktion.
 * Sie sorgt dafür, dass Eingaben präzise und im richtigen Layout ankommen.
 *
 * ⌨️ EINGABE-GARANTIE:
 * Durch das Vorladen der Kernel-Module (atkbd, usbhid) ist sichergestellt,
 * dass die Tastatur bereits funktioniert, bevor das eigentliche System
 * geladen ist – entscheidend für die Fehlerbehebung.
 *
 * 🌍 LOKALISIERUNG:
 * Die konsistente Einstellung der Sprache über Konsole und Desktop hinweg
 * schafft eine nahtlose Arbeitsumgebung für deutschsprachige Architekten.
 *
 * 📱 KONNEKTIVITÄT:
 * Mit der Integration von usbmuxd ist PiXeLOs darauf vorbereitet, mobile
 * Endgeräte als Internetquelle zu nutzen, falls das primäre Netz ausfällt.
 */
