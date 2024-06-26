{ config, pkgs, lib, ... }:
let
  scripts = ./scripts;
  modifier = "SUPER";
  terminal = "alacritty";
in {
  home.packages = with pkgs; [
    swaybg
    swayidle
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    plugins = with pkgs.hyprlandPlugins; [ hy3 ];

    settings = let
      # Volume using pamixer
      audio-disp = "${scripts}/multimedia Volume $(pamixer --get-mute) pamixer $(pamixer --get-volume)";
      audio      = cmd: "pamixer ${cmd} && ${audio-disp}";
      # Brightness using brightnessctl
      brightness-disp = ''${scripts}/multimedia Brightness "" brightnessctl $(brightnessctl -e -m | cut -d, -f4 | tr -d "%")'';
      brightness      = x: "brightnessctl -e set ${x} && ${brightness-disp}";
    in {
      "$mod" = modifier;
      "$terminal" = terminal;
      "$menu" = "rofi -show drun";

      exec-once = [
        "background=${../../assets/background.png} platform=${config.platform} ${scripts}/autostart"
      ];

      general = {
        layout = "hy3";

        border_size = 3;
        gaps_in = 8;
        gaps_out = 8;

        cursor_inactive_timeout = 5;
        resize_on_border = true;

        "col.inactive_border" = "rgb(474f6f)";
        "col.active_border" = "rgb(b4f9f8)";
      };

      plugin.hy3 = {
        tab_first_window = false;

        tabs = {
          height = 6;
          render_text = false;

          "col.active" = "rgb(b4f9f8)";
          "col.inactive" = "rgb(474f6f)";
          "col.urgent" = "rgb(f7768e)";
        };
      };

      decoration = {
        rounding = 10;

        "col.shadow" = "rgba(1a1b26c0)";
      };

      group.groupbar = {
        font_family = "JetBrainsMono Nerd Font";
        font_size = 14;
      };

      layerrule = [
        "noanim, ^(notifications)$"
      ];

      animations = {
        bezier = [ "overshot, 0.13, 0.99, 0.29, 1.06" ];
        animation = [
          "windows, 1, 2, default, popin 70%"
          "windowsMove, 1, 4, overshot, slide"
          "border, 1, 8, default,"
          "fade, 1, 8, default,"
          "workspaces, 1, 5, overshot, slidevert"
        ];
      };

      misc.disable_hyprland_logo = true;

      # Bindings

      bind = [
        "$mod, Return, exec, $terminal"
        "$mod, D, exec, $menu"
        "$mod Shift, E, exec, ${scripts}/exit"
        "$mod, M, exec, hyprlock --immediate"

        # Emacs Everywhere
        # "$mod, Q, exec, $HOME/.config/emacs/bin/doom +everywhere"

        # Windows
        "$mod, Left, hy3:movefocus, l"
        "$mod, Right, hy3:movefocus, r"
        "$mod, Up, hy3:movefocus, u"
        "$mod, Down, hy3:movefocus, d"
        "$mod, H, hy3:movefocus, l"
        "$mod, L, hy3:movefocus, r"
        "$mod, K, hy3:movefocus, u"
        "$mod, J, hy3:movefocus, d"

        "$mod Shift, Left, hy3:movewindow, l"
        "$mod Shift, Right, hy3:movewindow, r"
        "$mod Shift, Up, hy3:movewindow, u"
        "$mod Shift, Down, hy3:movewindow, d"
        "$mod Shift, H, hy3:movewindow, l"
        "$mod Shift, L, hy3:movewindow, r"
        "$mod Shift, K, hy3:movewindow, u"
        "$mod Shift, J, hy3:movewindow, d"

        "$mod, F, fullscreen, 1"
        "$mod Shift, F, fullscreen, 0"
        "$mod Shift, Q, hy3:killactive,"

        "$mod, V, hy3:makegroup, v, ephemeral"
        "$mod, B, hy3:makegroup, h, ephemeral"
        "$mod, T, hy3:makegroup, tab"
        "$mod Shift, T, hy3:changegroup, toggletab"
        "$mod, E, hy3:changegroup, opposite"
        "$mod, A, hy3:changefocus, raise"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # Workspace Movement
        "$mod Shift, 1, movetoworkspace, 1"
        "$mod Shift, 2, movetoworkspace, 2"
        "$mod Shift, 3, movetoworkspace, 3"
        "$mod Shift, 4, movetoworkspace, 4"
        "$mod Shift, 5, movetoworkspace, 5"
        "$mod Shift, 6, movetoworkspace, 6"
        "$mod Shift, 7, movetoworkspace, 7"
        "$mod Shift, 8, movetoworkspace, 8"
        "$mod Shift, 9, movetoworkspace, 9"
        "$mod Shift, 0, movetoworkspace, 10"
      ];

      bindn = [
        ", mouse:272, hy3:focustab, mouse"
      ];

      bindl = [
        # XF86 key bindings
        ", XF86AudioMute, exec, ${audio "--toggle-mute"}"
        ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        # Screenshot
        ", Print, exec, ${scripts}/screenshot"
        "Shift, Print, exec, ${scripts}/screenshot-slurp"
      ];

      bindle = [
        # XF86 key bindings
        ", XF86AudioRaiseVolume, exec, ${audio "-i 2"}"
        ", XF86AudioLowerVolume, exec, ${audio "-d 2"}"
        "Shift, XF86AudioRaiseVolume, exec, ${audio "-i 2 --allow-boost"}"
        "Shift, XF86AudioLowerVolume, exec, ${audio "-d 2 --allow-boost"}"
        ", XF86MonBrightnessDown, exec, ${brightness "4%-"}"
        ", XF86MonBrightnessUp, exec, ${brightness "4%+"}"
      ];
    };
  };
}
