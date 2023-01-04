{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      
      # Based on the Tokyo Night theme
      colors.primary = {
        foreground = "#a9b1d6";
        background = "#1a1b26";
      };
      colors.normal = {
        black   = "#32344a";
        red     = "#ce7284";
        green   = "#7dc5a0";
        yellow  = "#caaa6a";
        blue    = "#7bc5e4";
        magenta = "#ad8ee6";
        cyan    = "#449dab";
        white   = "#787c99";
      };
      colors.bright = {
        black   = "#444b6a";
        red     = "#d5556f";
        green   = "#b9f27c";
        yellow  = "#ff9e64";
        blue    = "#7da6ff";
        magenta = "#bb9af7";
        cyan    = "#0db9d7";
        white   = "#acb0d0";
      };

      font =
        let family = "VictorMono";
            font-style = style: { inherit family style; };
        in {
          normal      = font-style "SemiBold";
          bold        = font-style "Bold";
          italic      = font-style "SemiBold Italic";
          bold_italic = font-style "Bold Italic";
 
          size = 11;
      };
    };
  };
}
