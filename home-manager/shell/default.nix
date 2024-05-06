{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./starship.nix
  ];

  # Fish shell

  programs.fish.enable = true;
  # Disable greeting
  programs.fish.interactiveShellInit =
    "set -g fish_greeting";

  # Eza - ls replacement

  programs.eza = {
    enable = true;
    enableAliases = true;
  };
  programs.fish.shellAliases = {
    l = "ls -al";
  };

  # rlwrap config

  programs.fish.shellInit = ''
    set -xg RLWRAP_HOME $XDG_DATA_HOME/rlwrap
  '';

  home.packages = [ pkgs.rlwrap ];
}
