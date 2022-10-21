{ config, pkgs, ... }:
let
  # nix-direnv with flake support
  nix-direnv-with-flakes = pkgs.nix-direnv.override { enableFlakes = true; };
in {
  environment.systemPackages = with pkgs; [
    ffmpeg
    jq 
    git
    wget
    libnotify
    ripgrep
    unzip
    tldr
    pamixer
    brightnessctl
    playerctl

    pandoc
    gnuplot
    graphviz

    gcc
    wob
    grim
    slurp
    imv

    direnv
    nix-direnv-with-flakes
  ];

  programs.sway.enable = true;
  programs.sway.extraPackages = [];

  # Necessary for VSCodium to store passwords
  services.gnome.gnome-keyring.enable = true;


  services.emacs.enable = true;
  services.emacs.package = pkgs.emacs28-gtk;

  # direnv setup

  nix.extraOptions = ''
    keep-derivations = true
    keep-outputs = true
  '';

  environment.pathsToLink = [ "/share/nix-direnv" ];
}
