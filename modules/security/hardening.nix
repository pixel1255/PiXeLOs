## ==============================================================================## MODULES/SECURITY/HARDENING.NIX — NFTABLES, KERNEL-SYSCTL & OPENSNITCH WALL## Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)## ==============================================================================
{ pkgs, ... }: # Standard-Funktionskopf mit Zugriff auf pkgs für die OpenSnitch GUI Komponente
{
networking.nftables.enable = true; # Aktiviert das moderne nftables-Backend und ersetzt das veraltete iptables-Framework
networking.firewall = { # Konfigurationsblock der integrierten NixOS-Firewall
enable = true; # Schaltet die System-Firewall fest ein
allowPing = false; # Ignoriert ICMP-Pings komplett (macht den Intel-Host im Netzwerk unsichtbar für Scanner)
allowedTCPPorts = [ ]; # Blockiert standardmäßig JEDEN eingehenden TCP-Port von außen (Strikte Standard-Deny-Policy)
allowedUDPPorts = [ ]; # Blockiert standardmäßig JEDEN eingehenden UDP-Port von außen (Strikte Standard-Deny-Policy)
logRefusedConnections = true; # Schreibt jeden abgewiesenen, unbefugten Verbindungsversuch direkt ins Systemd-Journal-Log
};
boot.kernel.sysctl = { # Kernel-Härtung auf Netzwerkebene (Schutz direkt im Linux-Kernel verankert)
"net.ipv4.conf.all.rp_filter" = 1; # Aktiviert strenges Reverse Path Filtering für alle Schnittstellen (Schutz vor IP-Spoofing)
"net.ipv4.conf.default.rp_filter" = 1; # Aktiviert standardmäßig Reverse Path Filtering für neu hinzukommende Interfaces
"net.ipv4.conf.all.accept_redirects" = 0; # Ignoriert ICMP-Redirect-Pakete (verhindert bösartige Manipulationen der Routingtabelle)
"net.ipv4.conf.default.accept_redirects" = 0; # Schaltet das Akzeptieren von ICMP-Redirects für Standard-Schnittstellen aus
"net.ipv4.conf.all.secure_redirects" = 0; # Ignoriert selbst sichere ICMP-Redirects von bekannten Gateways (maximale Striktheit)
"net.ipv4.conf.default.secure_redirects" = 0; # Deaktiviert sichere ICMP-Redirects standardmäßig für alle neuen Geräte
"net.ipv6.conf.all.accept_redirects" = 0; # Deaktiviert das Akzeptieren von IPv6-Routing-Umleitungen komplett
"net.ipv6.conf.default.accept_redirects" = 0; # Deaktiviert IPv6-Routing-Umleitungen standardmäßig
"net.ipv4.ip_forward" = 0; # Deaktiviert IP-Weiterleitung im Kernel (der Rechner darf niemals heimlich als Router agieren)
"net.ipv4.conf.all.send_redirects" = 0; # Verbietet dem Kernel, eigene ICMP-Redirect-Signale ins Netzwerk zu senden
"net.ipv4.conf.default.send_redirects" = 0; # Verbietet das Senden von ICMP-Redirects standardmäßig auf allen Schnittstellen
"net.ipv4.tcp_syncookies" = 1; # Aktiviert TCP Syn-Cookies (Schützt den Netzwerk-Stack vor DoS/SYN-Flood-Überlastungsangriffen)
};
services.opensnitch = { # Die interaktive Anwendungs-Firewall („Die Wand in der Mitte“)
enable = true; # Aktiviert den OpenSnitch-Hintergrund-Daemon zur Live-Überwachung aller ausgehenden Prozesse
};
environment.systemPackages = [ # Installiert die dazugehörige grafische Benutzeroberfläche
pkgs.opensnitch-ui # Die Qt-basierte OpenSnitch-GUI für interaktive Popups und Erlaubnis-Regeln in KDE Plasma
];
}
