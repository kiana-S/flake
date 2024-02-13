{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    swaylock-effects
    wl-clipboard
    wtype
    wlroots
    grim
    slurp
    imv
  ];

  xdg.configFile = {
    "swaylock/config".text = ''
      ignore-empty-password
      fade-in=0.3

      indicator
      screenshots

      font=JetBrainsMono
      text-color=ffffff
      color=00000000
      ring-color=7da6ff
      key-hl-color=7bc5e4

      line-uses-inside
      indicator-radius=120
      indicator-thickness=7

      clock
      datestr=%a, %Y-%m-%d

      effect-scale=0.4
      effect-vignette=0.3:0.7
      effect-blur=2x2
    '';

    "swaynag/config".text = ''
      font=JetBrainsMono 10
      layer=top

      [exit]
      background=111320D0
      text=a9b1d6
      border-bottom=7BC5E4
      border-bottom-size=1
      button-background=282E49F0
      button-border-size=2
    '';
  };

  # Rofi

  programs.rofi.enable = true;
  programs.rofi.package = pkgs.rofi-wayland;

  xdg.configFile.rofi.source = ./rofi;

  # Mako

  services.mako = {
    enable = true;

    font = "JetBrainsMono Nerd Font 10";
    format = ''<i>%a</i>\n<b>%s</b>\n\n%b'';
    layer = "overlay";
    backgroundColor = "#111320d0";
    width = 300;
    margin = "5";
    padding = "5,10";
    borderSize = 2;
    borderColor = "#7bc5e4";
    borderRadius = 5;
    progressColor = "source #4e90ad";

    extraConfig =
      ''
        [urgency=low]
        format=<i>%s</i>\n%b
        background-color=#111111c0
        border-color=#787c99
        progress-color=source #474f6f
        border-size=1

        [urgency=high]
        background-color=#1e0909d0
        border-color=#ce7284
        progress-color=source #bc5469
        border-size=3
        default-timeout=0
        ignore-timeout=1


        [app-name=discord]
        format=<b>%s</b>\n\n%b
        border-color=#7da6ff

        [app-name=discordcanary]
        format=<b>%s</b>\n\n%b
        border-color=#7da6ff


        [category=multimedia]
        anchor=center
        width=430
        font=JetBrainsMono Nerd Font 13
        format=<i>%s</i>
        border-size=1
        default-timeout=2000

        [category=multimedia app-name=pamixer]
        background-color=#111111c0
        border-color=#787c99
        progress-color=source #474f6f

        [category=multimedia app-name=brightnessctl]
        background-color=#111111c0
        border-color=#ffea63
        progress-color=source #a08348
      '';
  };
}
