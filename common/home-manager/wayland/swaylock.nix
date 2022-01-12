{ pkgs, ... }:
{
  home.packages = [ pkgs.swaylock-effects ];

  xdg.configFile."swaylock/config".text =
    ''
      ignore-empty-password
      grace-no-mouse

      fade-in=0.3

      indicator
      screenshots

      font=Ubuntu
      text-color=ffffff

      color=00000000
      ring-color=151fea
      key-hl-color=6ecef4

      line-uses-inside

      indicator-radius=120
      indicator-thickness=7


      clock
      datestr=%A, %e.%m.%Y

      effect-scale=0.4
      effect-vignette=0.3:0.7
      effect-blur=2x2
    '';
}
