{ config, pkgs, emacs-overlay, ... }:
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
    pandoc
    pamixer
    brightnessctl
    playerctl
    screenfetch

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


  nixpkgs.overlays = [ emacs-overlay.overlay ];
  services.emacs.enable = true;
  services.emacs.package = pkgs.emacsUnstable;

  # direnv setup

  nix.extraOptions = ''
    keep-derivations = true
    keep-outputs = true
  '';

  environment.pathsToLink = [ "/share/nix-direnv" ];
}
