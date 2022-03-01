{ config, pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.9;
      
      # Based on the GNOME Dark theme
      colors.primary = {
        foreground = "#d0cfcc";
        background = "#000000";
        bright_foreground = "#ffffff";
      };
      colors.normal = {
        black   = "#171421";
        red     = "#c01c28";
        green   = "#26a269";
        yellow  = "#a2734c";
        blue    = "#12488b";
        magenta = "#a347ba";
        cyan    = "#2aa1b3";
        white   = "#d0cfcc";
      };
      colors.bright = {
        black   = "#5e5c64";
        red     = "#f66151";
        green   = "#33d17a";
        yellow  = "#e9ad0c";
        blue    = "#2a7bde";
        magenta = "#c061cb";
        cyan    = "#33c7de";
        white   = "#ffffff";
      };

      font =
        let family = "FiraCode Nerd Font Mono";
            font-style = style: { inherit family style; };
        in {
          normal      = font-style "Regular";
          bold        = font-style "Bold";
          italic      = font-style "Italic";
          bold_italic = font-style "Bold Italic";
 
          size = 11;
      };
    };
  };
}
