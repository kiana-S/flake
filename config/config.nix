{ config, pkgs, lib, username, fullname, ... }:
let
  inherit (config) platform;
  isMobile = platform == "mobile";

  hashedPassword =
      if platform == "desktop" then
        "$6$HYibiGhDN.JgLtw6$cecU7NjfumTUJSkFNFQG4uVgdd3tTPLGxK0zHAwYn3un/V43IUlyVBNKoRMLCQk65RckbD/.AjsLFVFKUUHVA/"
      else if platform == "laptop" then
        "$6$y3eb1phxFWnParRT$w1LNfxJ2ByHoiBa5ywh4STGuIK/r4Tnyxx2Xe/nlovrE6LuuLAVdKRFAroUTtUI/d2BNGI9ErjZ2z2Dl7w/t00"
      else # if platform == "mobile"
        "$6$vmmMT7pEY1W0Bj9R$Kb6nuwdg/KzCrGcUPkEo2jJ6a2NJRikiOeN8/I8ObU1K6rVYvgYqPVgPg9NkLaUScdh1PWcabuvaHCFLMw14A0";
in
{
  nix.package = pkgs.nixFlakes;
  nix.settings.auto-optimise-store = true;
  nix.extraOptions = ''
    experimental-features = nix-command flakes ca-derivations
    restrict-eval = false
  '';
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = !isMobile;
  boot.loader.efi.canTouchEfiVariables = !isMobile;

  networking.hostName = "kiana-${platform}";
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;

  # Power button settings
  services.logind = {
    extraConfig = ''
        HandlePowerKey=ignore
        HandlePowerKeyLongPress=poweroff
      '';
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.wireplumber.enable = true;

  hardware.opengl.enable = true;

  users.mutableUsers = false;
  users.users.${username} = {
    isNormalUser = true;
    description = fullname;
    extraGroups = [ "wheel" "networkmanager" ]
                  ++ lib.optionals isMobile [ "dialout" "feedbackd" "video" ];
    shell = pkgs.fish;
    inherit hashedPassword;
  };

  users.users.root = { inherit hashedPassword; };


  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # Monospace
      victor-mono
      jetbrains-mono
      (nerdfonts.override {
        fonts = [
          "VictorMono"
          "JetBrainsMono"
          "NerdFontsSymbolsOnly"
        ];
      })
      font-awesome
      emacs-all-the-icons-fonts

      # Regular
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-sans-pro

      # Display
      quicksand

      # Unicode
      symbola
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = lib.optional (!isMobile) "Noto Serif";
        sansSerif = lib.optional (!isMobile) "Noto Sans";
        monospace = [ "VictorMono" ];
      };
    };
  };

  environment.sessionVariables.GTK_THEME = "Adwaita:dark";

  services.openssh.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
