{ pkgs, ... }:
let
modifier = "Mod1";
terminal = "alacritty";
bgimg = "What_Space_Really_Looks_Like_2880x1800.png";
in {
  
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
  };

  home.packages = with pkgs; [ swayidle wl-clipboard wlroots ];

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = {
      inherit modifier terminal;
      menu = "wofi --show drun";

      fonts = {
        names = [ "UbuntuMono" ];
        style = "Medium";
        size = 11.0;
      };

      bars = [{ command = "waybar"; }];

      window.border = 1;
      gaps = {
        inner = 10;
        outer = 5;
      };
      colors = {
        unfocused.border      = "#333333";
        unfocused.background  = "#000000a0";
        unfocused.text        = "#a0a0a0";
        unfocused.indicator   = "#2d292e";
        unfocused.childBorder = "#333333";
        
        focused.border      = "#808080";
        focused.background  = "#000000";
        focused.text        = "#ffffff";
        focused.indicator   = "#2d292e";
        focused.childBorder = "#ffffff";
        
        focusedInactive.border      = "#333333";
        focusedInactive.background  = "#000000";
        focusedInactive.text        = "#ffffff";
        focusedInactive.indicator   = "#4e4850";
        focusedInactive.childBorder = "#333333";
        
        urgent.border      = "#000000";
        urgent.background  = "#900000";
        urgent.text        = "#ffffff";
        urgent.indicator   = "#900000";
        urgent.childBorder = "#000000";
      };
      
      startup = map (x: { command = x; }) [
        ''~/.azotebg''
        # Make wob channel
        ''mkfifo $SWAYSOCK.wob && tail -f $SWAYSOCK.wob | wob''
        ''swayidle timeout 120 'swaylock -f --grace=180' \
                   timeout 600 'systemctl suspend' \
                   before-sleep 'swaylock -f' ''
        ''export XDG_SESSION_TYPE=wayland''
        ''export XDG_CURRENT_DESKTOP=sway''
      ];

      keybindings = let
        # Display volume using wob
        audio-disp = ''pamixer --get-volume > $SWAYSOCK.wob'';
        audio      = cmd: "exec pamixer ${cmd} && ${audio-disp}";
        brightness-set = x: "exec brightnessctl set ${x}";
        playerctl = cmd: "exec playerctl ${cmd}";
        in pkgs.lib.mkOptionDefault {
          "${modifier}+Shift+d" = ''exec wofi --show run'';
          "${modifier}+Shift+l" = ''exec swaylock --grace=30'';

          # Screenshot
          "Print"             = ''exec grim -o $(date +%Y-%m-%d_%H-%m-%s)'';
          "Shift+Print"       = ''exec grim -g "$(slurp)" -o $(date +%Y-%m-%d_%H-%m-%s)'';
          "${modifier}+Print" = ''grim -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" -o $(date +%Y-%m-%d_%H-%m-%s)'';

          # Special XF86 key bindings
          "XF86AudioRaiseVolume"  = audio "-ui 2";
          "XF86AudioLowerVolume"  = audio "-ud 2";
          "XF86AudioMute"         = ''exec pamixer --toggle-mute'';
          "XF86AudioMicMute"      = ''exec pactl set-source-mute @DEFAULT_SOURCE@ toggle'';
          "XF86MonBrightnessDown" = brightness-set "5%-";
          "XF86MonBrightnessUp"   = brightness-set "+5%";
          "XF86AudioPlay"         = playerctl "play-pause";
          "XF86AudioNext"         = playerctl "next";
          "XF86AudioPrev"         = playerctl "previous";
      };

       output."*" = {
         bg = "${./background/${bgimg}} fill";
       };
    };
  };
}
# bindsym $mod+Shift+e exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'
