## ==============================================================================## MODULES/NETWORK/NETWORK.NIX — NETWORKMANAGER, AVAHI-MDNS & CUPS PRINTING## Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)## ==============================================================================
{ ... }: # Leerer Funktionskopf, da hier Netzwerkdienste deklarativ gestartet werden
{
networking.hostName = "pixel1255"; # Definiert den globalen Netzwerknamen (Hostname) des physischen Intel-Rechners
networking.networkmanager.enable = true; # Aktiviert NetworkManager zur flexiblen Verwaltung von Ethernet- und iPhone-Verbindungen
services.avahi = { # Aktiviert den Avahi-Daemon für Zero-Configuration-Networking (Zeroconf / Apple Bonjour)
enable = true; # Schaltet Avahi permanent ein
nssmdns4 = true; # Aktiviert die Namensauflösung für .local-Adressen im lokalen Netzwerk über IPv4
openFirewall = true; # Öffnet automatisch die benötigten UDP-Ports in der Firewall für mDNS-Anfragen
publish = { # Definiert, welche Informationen der Host aktiv im Netzwerk ankündigen darf
enable = false; # HÄRTUNG NETWORK: Deaktiviert proaktive Ankündigungen
addresses = false; # Veröffentlicht die lokalen IP-Adressen des Intel-Hosts
workstation = false; # Kündigt den Rechner im lokalen Netz als vollwertige Workstation an
};
};
services.printing.enable = true; # Aktiviert das Common Unix Printing System (CUPS) zur Verwaltung und Nutzung von Druckern
}
