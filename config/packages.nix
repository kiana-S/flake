{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    ffmpeg
    openssl
    jaq
    socat
    git
    wget
    libnotify
    inotify-tools
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
  ];

  programs.hyprland.enable = true;
  security.pam.services.hyprlock = {};

  programs.fish.enable = true;
  programs.sway.enable = true;
  programs.sway.extraPackages = [];

  services.emacs.enable = true;
  services.emacs.package = with pkgs;
    (emacsPackagesFor (pkgs.emacs29.override { withPgtk = true; }))
      .emacsWithPackages (epkgs: [ epkgs.vterm ]);

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.silent = true;

  nix.extraOptions = ''
    keep-derivations = true
    keep-outputs = true
  '';
}
