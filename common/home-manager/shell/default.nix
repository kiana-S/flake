{ ... }:
{
  imports = [
    ./alacritty.nix
    ./starship.nix
  ];

  programs.fish.enable = true;

  # Hook nix-direnv to shell

  programs.fish.shellInit = "direnv hook fish | source";
}
