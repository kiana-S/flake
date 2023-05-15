{ config, pkgs, nixpkgs, ... }:
let
  # nix-direnv with flake support
  nix-direnv-with-flakes = pkgs.nix-direnv.override { enableFlakes = true; };

  emacs29 = pkgs.callPackage (import "${nixpkgs}/pkgs/applications/editors/emacs/generic.nix" {
    version = "29.0.90";
    sha256 = "sha256-5aR+9EZF9Md2nb4n3xktFR5j8cZto7mZaYUXZpQbvNI=";
  }) {
      withPgtk = true;
      withWebP = true;
      withSQLite3 = true;

      # Copied from nixpkgs
      libXaw = pkgs.xorg.libXaw;
      gconf = null;
      alsa-lib = null;
      acl = null;
      gpm = null;
      inherit (pkgs.darwin.apple_sdk.frameworks)
        AppKit Carbon Cocoa IOKit OSAKit Quartz QuartzCore WebKit
        ImageCaptureCore GSS ImageIO;
      inherit (pkgs.darwin) sigtool;
    };
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
    (aspellWithDicts (ps: with ps; [ en en-computers en-science ]))

    gcc

    direnv
    nix-direnv-with-flakes
  ];

  programs.fish.enable = true;
  programs.sway.enable = true;
  programs.sway.extraPackages = [];

  # Necessary for VSCodium to store passwords
  services.gnome.gnome-keyring.enable = true;


  services.emacs.enable = true;
  services.emacs.package = emacs29;

  # direnv setup

  nix.extraOptions = ''
    keep-derivations = true
    keep-outputs = true
  '';

  environment.pathsToLink = [ "/share/nix-direnv" ];
}
