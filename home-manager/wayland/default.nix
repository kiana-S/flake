{ pkgs, ... }:
{
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "gtk" ];
  };

  imports = [
    ./hyprland.nix
    ./wltools.nix
    ./waybar.nix
  ];
}
