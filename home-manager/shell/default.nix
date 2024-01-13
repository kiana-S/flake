{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./starship.nix
  ];

  programs.fish.enable = true;

  # rlwrap config

  programs.fish.shellInit = ''
    set -xg RLWRAP_HOME $XDG_DATA_HOME/rlwrap
  '';

  home.packages = [ pkgs.rlwrap ];
}
