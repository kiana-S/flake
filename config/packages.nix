{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs;
    let aspell' = aspellWithDicts.override {
          aspell = aspell.overrideAttrs (super: {
            postInstall = super.postInstall + ''
              mkdir -p $out/etc
              cat > $out/etc/aspell.conf << EOF
              lang en_US
              add-extra-dicts en-computers.rws
              add-extra-dicts en_US-science.rws
              EOF
            '';
          });
        } (ps: with ps; [ en en-computers en-science ]);
    in [
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
    aspell'
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
