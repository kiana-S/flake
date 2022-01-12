{ config, pkgs, ... }:
let
  vscodium-extensions = with pkgs.vscode-extensions;
    [
      # Global dev tools (ghc, hlint, cargo) will not be
      # installed by default; they must be managed
      # per-package using nix-shell
      
      # Git extensions
      pinage404.git-extension-pack
      
      # Haskell extensions
      haskell.haskell
      justusadam.language-haskell
      hoovercj.haskell-linter
      
      # Nix extensions
      pinage404.nix-extension-pack
      
      # Rust extensions
      matklad.rust-analyzer
      wcrichton.flowistry
      tamasfe.even-better-toml
      swellaby.vscode-rust-test-adapter
      
      # Other
      hbenl.vscode-test-explorer
      ms-python.python
      ms-toolsai.jupyter
    ];
  vscodium-with-extensions = pkgs.vscode-with-extensions.override {
    vscode = pkgs.vscodium;
    vscodeExtensions = vscodium-extensions;
  };

  # nix-direnv with flake support
  nix-direnv-with-flakes = pkgs.nix-direnv.override { enableFlakes = true; };
in {
  environment.systemPackages = with pkgs; [
    vscodium-with-extensions
    
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


  # direnv setup

  nix.extraOptions = ''
    keep-derivations = true
    keep-outputs = true
  '';

  environment.pathsToLink = [ "/share/nix-direnv" ];
}
