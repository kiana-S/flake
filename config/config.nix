{ config, pkgs, nur,
nixpkgs, # The flake's input version of nixpkgs
... }:
let hashedPassword = "$6$lokU/kizIJ/HwEI8$N6c80K0.VHkFBaOMcS8Bc1Fz5bx8qqTRH8brf0.duTOkf4Mja90bLwki8IVCBVpHnj7WqEkF4.CtZA6WczeqQ1";
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    restrict-eval = false
  '';
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ nur.overlay ];
  
  # Pin nixpkgs to the flake input
  nix.registry.nixpkgs.flake = nixpkgs;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kiana-pc"; # Define your hostname.
  networking.wireless.enable = true;
  networking.wireless.networks = {
    "NETGEAR97".psk = "pastelcello694";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware.opengl.enable = true;

  users.mutableUsers = false;
  users.users.kiana = {
    isNormalUser = true;
    description = "Kiana Sheibani";
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    inherit hashedPassword;
  };
  users.users.root = {
    inherit hashedPassword;
  };


  fonts = {
    enableDefaultFonts = true;    
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      ubuntu_font_family
      (nerdfonts.override { fonts = [ "FiraCode" "Ubuntu" "UbuntuMono" ]; })
      meslo-lgs-nf
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "Meslo Nerd Font" ];
      };
    };
  };

  environment.sessionVariables.GTK_THEME = "Adwaita:dark";


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
