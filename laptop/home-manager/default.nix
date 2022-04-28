{ ... }:
{
  imports = [
    ../../common/home-manager
    ./waybar.nix
  ];

  programs.git.extraConfig.user.signingkey = "6CB106C25E86A9F7";
}
