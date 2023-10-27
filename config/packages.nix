{ config, pkgs, nixpkgs, ... }:
let
  # nix-direnv with flake support
  nix-direnv-with-flakes = pkgs.nix-direnv.override { enableFlakes = true; };

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
