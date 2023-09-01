{ pkgs, lib, ... }:
let
modifier = "Mod4";
terminal = "alacritty";
in {
  home.packages = with pkgs; [
    swayidle
    wl-clipboard
    wtype
    wlroots
    grim
    slurp
    imv
  ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      inherit modifier terminal;
      menu = "rofi -show drun";

      fonts = {
        names = [ "JetBrainsMono Nerd Font" ];
        style = "Medium";
        size = 10.0;
      };

      bars = [{ command = "waybar"; }];

      window.border = 3;
      gaps = {
        inner = 8;
        outer = 0;
      };
      colors = {
        unfocused.border      = "#474f6f";
        unfocused.background  = "#1a1b26";
        unfocused.text        = "#a9b1d6";
        unfocused.indicator   = "#474f6f";
        unfocused.childBorder = "#474f6f";
        
        focused.border      = "#7bc5e4";
        focused.background  = "#1a1b26";
        focused.text        = "#a9b1d6";
        focused.indicator   = "#7bc5e4";
        focused.childBorder = "#7bc5e4";
        
        focusedInactive.border      = "#787c99";
        focusedInactive.background  = "#1a1b26";
        focusedInactive.text        = "#a9b1d6";
        focusedInactive.indicator   = "#787c99";
        focusedInactive.childBorder = "#787c99";
        
        urgent.border      = "#d5556f";
        urgent.background  = "#444b6a";
        urgent.text        = "#ffffff";
        urgent.indicator   = "#d5556f";
        urgent.childBorder = "#d5556f";
      };

      startup = map (x: { command = x; }) [
        # Make wob channels
        ''mkfifo $XDG_RUNTIME_DIR/wob_volume.sock && tail -f $XDG_RUNTIME_DIR/wob_volume.sock \
            | wob -c ~/.config/wob/volume.ini''
        ''mkfifo $XDG_RUNTIME_DIR/wob_brightness.sock && tail -f $XDG_RUNTIME_DIR/wob_brightness.sock \
            | wob -c ~/.config/wob/brightness.ini''
        ''swayidle timeout 120 'swaylock -f --grace=180' \
                   timeout 600 'systemctl suspend' \
                   before-sleep 'swaylock -f' ''
        ''export XDG_SESSION_TYPE=wayland''
        ''export XDG_CURRENT_DESKTOP=sway''
      ];

      keybindings = let
        # Volume using pamixer and wob
        audio-disp = ''pamixer --get-volume > $XDG_RUNTIME_DIR/wob_volume.sock'';
        audio      = cmd: "exec pamixer ${cmd} && ${audio-disp}";
        # Brightness using brightnessctl and wob
        brightness-disp = ''brightnessctl -e -m | cut -d "," -f4 | tr -d "%" > $XDG_RUNTIME_DIR/wob_brightness.sock'';
        brightness      = x: "exec brightnessctl -e set ${x} && ${brightness-disp}";
        # Play controls using playerctl
        playerctl = cmd: "exec playerctl ${cmd}";
        # Grim screenshot file name
        filename = ''~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png'';
        in pkgs.lib.mkOptionDefault {
          "${modifier}+Shift+d" = "exec rofi -show run -config ~/.config/rofi/noicons.rasi";
          "${modifier}+w"       = "exec rofi -show workspace -config ~/.config/rofi/noicons.rasi";
          "${modifier}+Shift+w" = "exec rofi -show workspacemove -config ~/.config/rofi/noicons.rasi";

          "${modifier}+t" = "layout tabbed";
          "${modifier}+Shift+m" = "exec swaylock";

          # Emacs Everywhere
          "${modifier}+q" = "exec ~/.emacs.d/bin/doom +everywhere";

          # Screenshot
          "Print"             = ''exec grim ${filename}'';
          "Shift+Print"       = ''exec grim -g "$(slurp)" ${filename}'';
          "Mod1+Print" = ''exec grim -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" ${filename}'';

          # Special XF86 key bindings
          "XF86AudioRaiseVolume"       = audio "-ui 2";
          "XF86AudioLowerVolume"       = audio "-ud 2";
          "Shift+XF86AudioRaiseVolume" = audio "-ui 2 --allow-boost";
          "Shift+XF86AudioLowerVolume" = audio "-ud 2 --allow-boost";
          "XF86AudioMute"              = ''exec pamixer --toggle-mute'';
          "XF86AudioMicMute"           = ''exec pactl set-source-mute @DEFAULT_SOURCE@ toggle'';
          "XF86MonBrightnessDown"      = brightness "4%-";
          "XF86MonBrightnessUp"        = brightness "4%+";
          "XF86AudioPlay"              = playerctl "play-pause";
          "XF86AudioNext"              = playerctl "next";
          "XF86AudioPrev"              = playerctl "previous";

          # Exit
          "${modifier}+Shift+e" = ''exec swaynag -t warning -m \
            "You pressed the exit shortcut. Do you really want to exit sway? \
            This will end your Wayland session." -b "Yes, exit sway" "swaymsg exit" '';

          # Workspaces
          "${modifier}+1" = "workspace 10:browser";
          "${modifier}+2" = "workspace 20:terminal";
          "${modifier}+3" = "workspace 30:code";
          "${modifier}+4" = "workspace 40:files";
          "${modifier}+5" = "workspace 50:discord";
          "${modifier}+6" = "workspace 60:settings";
          "${modifier}+Shift+1" = "move container to workspace 10:browser";
          "${modifier}+Shift+2" = "move container to workspace 20:terminal";
          "${modifier}+Shift+3" = "move container to workspace 30:code";
          "${modifier}+Shift+4" = "move container to workspace 40:files";
          "${modifier}+Shift+5" = "move container to workspace 50:discord";
          "${modifier}+Shift+6" = "move container to workspace 60:settings";
      };

       output."*" = {
         bg = "${../../assets/background.png} fill";
       };
    };
  };
}
