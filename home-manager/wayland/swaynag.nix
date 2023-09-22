{ pkgs, ... }:
{
  xdg.configFile."swaynag/config".text =
    ''
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
}
