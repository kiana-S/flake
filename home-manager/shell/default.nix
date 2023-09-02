{ ... }:
{
  imports = [
    ./alacritty.nix
    ./starship.nix
  ];

  programs.fish.enable = true;

  # Hook nix-direnv to shell

  programs.fish.shellInit = ''
    set -xg DIRENV_LOG_FORMAT ""
    direnv hook fish | source
  '';
}
