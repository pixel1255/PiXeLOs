## ==============================================================================## MODULES/DESKTOP/AUDIO.NIX — PIPEWIRE SOUND INFRAS & LOW-LATENCY PROFIL## Co-Created by Pixel1255 & Zwillingsstern-KI (GxG-Prozess)## ==============================================================================
{ ... }: # Leerer Funktionskopf, da hier Audio-Eigenschaften deklarativ gesteuert werden
{
security.rtkit.enable = true; # Aktiviert RealtimeKit (erlaubt systemd, dem Audioserver Echtzeit-Priorität zu geben; verhindert Sound-Ruckler)
services.pipewire = { # Konfigurationsblock für die moderne Linux-Audio- und Video-Infrastruktur
enable = true; # Aktiviert PipeWire als zentralen Soundserver und ersetzt Altlasten wie PulseAudio
alsa.enable = true; # Aktiviert die native ALSA-Architekturkompatibilität
alsa.support32Bit = true; # Aktiviert 32-Bit ALSA-Unterstützung (wichtig für ältere Linux-Spiele oder Emulatoren)
pulse.enable = true; # Aktiviert die PulseAudio-Emulationsschicht (damit Standard-Apps wie Browser Sound ausgeben können)
jack.enable = true; # Aktiviert die professionelle JACK-Audioschnittstelle für Musikproduktion und Routing
extraConfig.pipewire."92-low-latency" = { # Erzeugt eine benutzerdefinierte Low-Latency-Konfiguration für extrem schnelle Audioverarbeitung
"context.properties" = { # Setzt globale Eigenschaften für den Audiodaten-Kontext
"default.clock.rate" = 48000; # Fixiert die Standard-Audio-Abtastrate auf professionelle 48 kHz
"default.clock.quantum" = 512; # Setzt die Standard-Puffergröße auf 512 Samples (guter Kompromiss aus Latenz und CPU-Last)
"default.clock.min-quantum" = 32; # Erlaubt Anwendungen, den Puffer bei Bedarf auf bis zu ultrageringe 32 Samples zu senken
"default.clock.max-quantum" = 1024; # Begrenzt den maximalen Puffer auf 1024 Samples, um spürbare Audioverzögerungen zu verhindern
};
};
};
}
