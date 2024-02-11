{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ffmpeg
    openssl
    jaq
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

  programs.hyprland.enable = true;

  programs.fish.enable = true;
  programs.sway.enable = true;
  programs.sway.extraPackages = [];

  services.emacs.enable = true;
  services.emacs.package = pkgs.emacs29.override {
      withPgtk = true;
      withWebP = true;
      withSQLite3 = true;
  };

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.silent = true;

  nix.extraOptions = ''
    keep-derivations = true
    keep-outputs = true
  '';
}
