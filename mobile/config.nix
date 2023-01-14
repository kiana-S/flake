{ config, pkgs, lib, username, ... }:
{
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  zramSwap.enable = true;

  # SWMO

  services.xserver = {
    enable = true;
    desktopManager.sxmo.enable = true;

    displayManager = {
      tinydm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = username;
      defaultSession = "swmo";
    }
  };
}
