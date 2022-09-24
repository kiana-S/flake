{ config, pkgs, nur,
nixpkgs, # The flake's input version of nixpkgs
... }:
{
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    restrict-eval = false
  '';
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ nur.overlay ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.wireless.enable = false;
  networking.networkmanager.enable = true;

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
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };


  fonts = {
    enableDefaultFonts = true;    
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      (nerdfonts.override { fonts = [ "UbuntuMono" "JetBrainsMono" ]; })
      meslo-lgs-nf
      victor-mono
      ubuntu_font_family
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

  services.openssh.enable = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
