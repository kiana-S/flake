{ config, pkgs, ... }:
let
  emacs29 = pkgs.emacs29.override {
      withPgtk = true;
      withWebP = true;
      withSQLite3 = true;
  };
in {
  environment.systemPackages = with pkgs; [
    ffmpeg
    openssl
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
    texlive.combined.scheme-full
    (aspellWithDicts (ps: with ps; [ en en-computers en-science ]))

    gcc
  ];

  programs.fish.enable = true;
  programs.sway.enable = true;
  programs.sway.extraPackages = [];

  services.emacs.enable = true;
  services.emacs.package = emacs29;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.silent = true;

  nix.extraOptions = ''
    keep-derivations = true
    keep-outputs = true
  '';
}
