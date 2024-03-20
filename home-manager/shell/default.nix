{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./starship.nix
  ];

  programs.fish.enable = true;
  programs.fish.shellAliases = {
    l = "ls -al";
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
  };

  # rlwrap config

  programs.fish.shellInit = ''
    set -xg RLWRAP_HOME $XDG_DATA_HOME/rlwrap
  '';

  home.packages = [ pkgs.rlwrap ];
}
