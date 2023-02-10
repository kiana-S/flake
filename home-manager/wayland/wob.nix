{ config, pkgs, ... }:
{
  home.packages = [ pkgs.wob ];

  xdg.configFile = {
    "wob/volume.ini".text = "";

    "wob/brightness.ini".text = config.xdg.configFile."wob/volume.ini".text + ''
      border_color = FFFF00FF
      bar_color = FFFF00FF
    '';
  };
}
