{ config, pkgs, ... }:
let
  vscodium-extensions = with pkgs.vscode-extensions;
    [
      # Global dev tools (ghc, hlint, cargo) will not be
      # installed by default; they must be managed
      # per-package using nix-shell
            
      # Haskell extensions
      haskell.haskell
     
      # Rust extensions
      matklad.rust-analyzer
      tamasfe.even-better-toml
      
      # Other
      ms-python.python
      ms-toolsai.jupyter
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      # Extensions that aren't built-in to nixpkgs
      # I REALLY want to make this flake-based, but there's no
      # documentation on how to do that anywhere.
      {
        name = "git-extension-pack";
        publisher = "pinage404";
        version = "1.0.0";
        sha256 = "1bradnx0ll8zninqn8lnjj6dp8dgxxgpc6yzaap8xghb1jv1hn39";
      }
      {
        name = "nix-extension-pack";
        publisher = "pinage404";
        version = "1.0.0";
        sha256 = "10hi9ydx50zd9jhscfjiwlz3k0v4dfi0j8p58x8421rk5dspi98x";
      }
      {
        name = "haskell-linter";
        publisher = "hoovercj";
        version = "0.0.6";
        sha256 = "0fb71cbjx1pyrjhi5ak29wj23b874b5hqjbh68njs61vkr3jlf1j";
      }
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
