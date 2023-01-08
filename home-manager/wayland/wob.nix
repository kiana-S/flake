{ config, pkgs, ... }:
{
  home.packages = [ pkgs.wob ];

  xdg.configFile = rec {
    "wob/volume.ini".text = "";

    "wob/brightness.ini".text = "wob/volume.ini".text + ''
      border_color = #FFFF00FF
      bar_color = #FFFF00FF
    '';
  }
}
