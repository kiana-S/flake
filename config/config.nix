{ config, pkgs, nur, username, fullname, ... }:
let
  inherit (config.custom) platform;

  hashedPassword =
      if platform == "desktop" then
        "$6$HYibiGhDN.JgLtw6$cecU7NjfumTUJSkFNFQG4uVgdd3tTPLGxK0zHAwYn3un/V43IUlyVBNKoRMLCQk65RckbD/.AjsLFVFKUUHVA/"
      else if platform == "laptop" then
        "$6$y3eb1phxFWnParRT$w1LNfxJ2ByHoiBa5ywh4STGuIK/r4Tnyxx2Xe/nlovrE6LuuLAVdKRFAroUTtUI/d2BNGI9ErjZ2z2Dl7w/t00"
      else
        "$6$vmmMT7pEY1W0Bj9R$Kb6nuwdg/KzCrGcUPkEo2jJ6a2NJRikiOeN8/I8ObU1K6rVYvgYqPVgPg9NkLaUScdh1PWcabuvaHCFLMw14A0";
in
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

  networking.hostName = "kiana-${platform}";
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
  users.users.${username} = {
    isNormalUser = true;
    description = fullname;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    inherit hashedPassword;
  };

  users.users.root = { inherit hashedPassword; };


  fonts = {
    enableDefaultFonts = true;    
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "UbuntuMono" "JetBrainsMono" ]; })
      font-awesome
      victor-mono
      ubuntu_font_family
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "VictorMono" ];
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