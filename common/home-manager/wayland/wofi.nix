{ pkgs, ... }:
{
  home.packages = [ pkgs.wofi ];

  xdg.configFile.wofi.source = ./wofi;
}
