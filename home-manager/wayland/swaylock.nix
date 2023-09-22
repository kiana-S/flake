{ pkgs, ... }:
{
  home.packages = [ pkgs.swaylock-effects ];

  xdg.configFile."swaylock/config".text =
    ''
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
}
