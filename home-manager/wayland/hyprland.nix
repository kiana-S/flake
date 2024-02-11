{ config, pkgs, lib, ... }:
let
scripts = ../../scripts;
modifier = "SUPER";
terminal = "alacritty";
in {
  home.packages = with pkgs; [
    swaybg
    swayidle
  ];
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  xdg.portal.config.hyprland.default = [ "hyprland" "gtk" ];

  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = config.platform == "desktop";
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      "$mod" = modifier;
      "$terminal" = terminal;
      "$menu" = "rofi -show drun";

      exec-once = [
        "${scripts}/autostart ${../../assets/background.png}"
      ];

      general = {
        border_size = 3;
        gaps_in = 8;
        gaps_out = 8;

        cursor_inactive_timeout = 5;
        resize_on_border = true;

        "col.inactive_border" = "rgb(474f6f)";
        "col.active_border" = "rgb(7bc5e4)";
        "col.nogroup_border" = "rgb(d5556f)";
        "col.nogroup_border_active" = "rgb(d5556f)";
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
        bezier = [ "overshot, 0.13, 0.99, 0.29, 1.1" ];
        animation = [
          "windows, 1, 2, default, popin 70%"
          "windowsMove, 1, 4, overshot, slide"
          "border, 1, 8, default,"
          "fade, 1, 8, default,"
          "workspaces, 1, 4, overshot, slide"
        ];
      };

      misc.disable_hyprland_logo = true;

      bind = [
        "$mod, Return, exec, $terminal"
        "$mod, D, exec, $menu"
        "$mod, E, exec, ${scripts}/exit"
        "$mod Shift, E, exit,"
        "$mod, M, exec, swaylock"

        # Emacs Everywhere
        "$mod, Q, exec, $HOME/.emacs.d/bin/doom +everywhere"

        # Windows
        "$mod, Left, movefocus, l"
        "$mod, Right, movefocus, r"
        "$mod, Up, movefocus, u"
        "$mod, Down, movefocus, d"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"

        "$mod Shift, Left, movewindow, l"
        "$mod Shift, Right, movewindow, r"
        "$mod Shift, Up, movewindow, u"
        "$mod Shift, Down, movewindow, d"
        "$mod Shift, H, movewindow, l"
        "$mod Shift, L, movewindow, r"
        "$mod Shift, K, movewindow, u"
        "$mod Shift, J, movewindow, d"

        "$mod Shift, Q, killactive,"
        "$mod, G, togglegroup,"
        "$mod, Tab, changegroupactive, f"
        "$mod Shift, Tab, changegroupactive, b"

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

      bindl = let
        # Volume using pamixer
        audio-disp = "${scripts}/multimedia Volume pamixer $(pamixer --get-volume)";
        audio      = cmd: "pamixer ${cmd} && ${audio-disp}";
        # Brightness using brightnessctl
        brightness-disp = ''${scripts}/multimedia Brightness brightnessctl $(brightnessctl -e -m | cut -d "," -f4 | tr -d "%")'';
        brightness      = x: "brightnessctl -e set ${x} && ${brightness-disp}";
      in [
          # Special XF86 key bindings
        ", XF86AudioRaiseVolume, exec, ${audio "-i 2"}"
        ", XF86AudioLowerVolume, exec, ${audio "-d 2"}"
        "Shift, XF86AudioRaiseVolume, exec, ${audio "-i 2 --allow-boost"}"
        "Shift, XF86AudioLowerVolume, exec, ${audio "-d 2 --allow-boost"}"
        ", XF86AudioMute, exec, pamixer --toggle-mute"
        ", XF86AudioMicMute, exec, pactl set-source-mute @DEFAULT_SOURCE@ toggle"
        ", XF86MonBrightnessDown, exec, ${brightness "4%-"}"
        ", XF86MonBrightnessUp, exec, ${brightness "4%+"}"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        # Screenshot
        ", Print, exec, ${scripts}/screenshot"
        "Shift, Print, exec, ${scripts}/screenshot-slurp"
      ];
    };
  };
}
