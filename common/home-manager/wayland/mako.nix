{ pkgs, ... }:
{
  programs.mako = {
    enable = true;

    font = "UbuntuMono Light 11";
    format = ''<i>%a</i>\n<b>%s</b>\n\n%b'';
    layer = "overlay";
    backgroundColor = "#111320d0";
    width = 300;
    margin = "5";
    padding = "5,10";
    borderSize = 2;
    borderColor = "#04c2e8";
    borderRadius = 5;
    defaultTimeout = 10000;
    
    extraConfig =
      ''
        [urgency=low]
        format=<i>%s</i>\n%b
        background-color=#111111c0
        border-color=#ffffff
        border-size=1

        [urgency=high]
        background-color=#1e0909d0
        border-color=#bf616a
        border-size=4
        default-timeout=0
        ignore-timeout=1

        [app-name=discordcanary]
        format=<b>%s</b>\n%b
        border-color=#88c0d0
      '';
  };
}
