## ==============================================================================## MODULES/HARDWARE/GRAPHICS.NIX — INTEL GRAFIKTREIBER & VIDEOBESCHLEUNIGUNG## Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)## ==============================================================================
{ pkgs, ... }: # Standard-Funktionskopf mit Zugriff auf pkgs für Treiber-Bibliotheken
{
hardware.graphics = { # Konfigurationsblock des modernen NixOS-Grafik-Frameworks (ehemals hardware.opengl)
enable = true; # Aktiviert die Hardware-Grafikbeschleunigung (Mesa/OpenGL/Vulkan)
extraPackages = with pkgs; [ # Installiert zusätzliche hardware-spezifische Übersetzungsschichten für Intel-Haswell
intel-vaapi-driver # Der offizielle Video Acceleration API (VA-API) Treiber für Intel HD Graphics
libva-vdpau-driver # Übersetzungsschicht von VA-API auf VDPAU (wichtig für ältere Player)
libvdpau-va-gl # VDPAU-Treiber mit OpenGL-Backend zur flüssigen Videodarstellung auf der GPU
];
};
services.xserver.videoDrivers = [ "modesetting" ]; # Zwingt das Grafiksystem, den modernen Kernel-Modesetting-Treiber (i915) zu nutzen
}
