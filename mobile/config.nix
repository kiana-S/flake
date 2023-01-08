{ config, pkgs, lib, ... }:
{
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.package = pkgs.pulseAudioFull;
  zramSwap.enable = true;

  services.xserver.windowManager.sxmo.enable = true;
}
