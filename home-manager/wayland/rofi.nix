{ config, pkgs, ... }:
{
  programs.rofi.enable = true;
  programs.rofi.package = pkgs.rofi-wayland;

  xdg.configFile.rofi.source = ./rofi;
}
