{ config, pkgs, lib, ... }:
{
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  zramSwap.enable = true;

  services.xserver.windowManager.sxmo.enable = true;
}
