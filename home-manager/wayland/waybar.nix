{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = false;

    settings =
      let spanfa = "<span font=\"Font Awesome 5 Regular 11\">";
      in [{
        layer = "top";
        height = 32;
        margin = "8 8 0";

        modules-left = [ "hyprland/workspaces" "custom/sep" "cpu" "memory" "temperature" ];

        modules-center = [ "hyprland/window" ];

        modules-right =
          if config.platform == "laptop" then
            [ "battery" "pulseaudio" "backlight" "network" "clock" "idle_inhibitor" ]
          else
            [ "pulseaudio" "network" "clock" "idle_inhibitor" ];


        modules = {
          "mpd" = {
            format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ ";
            format-disconnected = "Disconnected ";
            format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
            unknown-tag = "N/A";
            interval = 2;

            consume-icons.on = " ";
            random-icons.off = "<span color=\"#f53c3c\"></span> ";
            random-icons.on = " ";
            repeat-icons.on = " ";
            single-icons.on = "1 ";
            state-icons.paused = "";
            state-icons.playing = "";

            tooltip-format = "MPD (connected)";
            tooltip-format-disconnected = "MPD (disconnected)";
          };
          "idle_inhibitor" = {
            format = "{icon}";
            format-icons.activated = "";
            format-icons.deactivated = "";
          };
          "tray" = {
            # icon-size = 21;
            spacing = 10;
          };
          "clock" = {
            format = "<span font_family=\"Font Awesome 6 Pro Solid 11\"></span> {:%H:%M}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = " {:%Y-%m-%d}";
          };
          "cpu" = {
            format = "<big> </big>{usage}%";
            tooltip = false;
          };
          "battery" = {
            states.warning = 30;
            states.low = 15;
            states.critical = 5;

            format = "<big>{icon}</big> {capacity}%";
            format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰁿" "󰂁" "󰂂" "󰁹" ];
            format-charging = "󰂄 {capacity}%";
            format-time = "{H}h {M}m";
          };
          "memory" = {
            format = "${spanfa}<small></small></span> {}%";
          };
          "temperature" = {
            # thermal-zone = 2;
            # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
            critical-threshold = 80;
            format = "${spanfa}<small>{icon}</small></span> {temperatureC}°C";
            format-icons = [ "" "" "" "" "" ];
          };
          "backlight" = {
            # device = "acpi_video1";
            format = "<span size=\"12pt\" rise=\"-0.5pt\">{icon}</span><span size=\"13pt\"> </span>{percent}%";
            format-icons = [ "󰃚" "󰃞" "󰃟" "󰃝" "󰃠" ];
          };
          "network" = {
            # interface = "wlp2*"; # (Optional) To force the use of this interface
            format = "{ifname}";
            format-wifi = "${spanfa}<small></small></span> Online";
            format-ethernet = "${spanfa} </span>";
            format-disconnected = "";
            tooltip-format-wifi = "{essid} - {signalStrength}%";
            tooltip-format-ethernet = "{signalStrength}%";
            tooltip-format-disconnected = "";
          };
          "pulseaudio" = {
            scroll-step = 1;
            smooth-scrolling-threshold = 2.0;
            format = "${spanfa}{icon}</span> {volume}%";
            format-bluetooth = " ${spanfa}{icon}</span> {volume}%";
            format-bluetooth-muted = "${spanfa} </span>  0%";
            format-muted = "${spanfa}</span> {volume}%";

            format-icons.headphone  = "";
            format-icons.phone      = "";
            format-icons.portable   = "";
            format-icons.car        = "";
            format-icons.default    = [ "" "" "" ];

            on-click = "pamixer -t";
          };
          "custom/media" = {
            format = "{icon} {}";
            return-type = "json";
            max-length = 40;

            format-icons.spotify = "";
            format-icons.default = "🎜";

            escape = true;
          };
          "custom/sep".format = "";
        };
      }];
    
    style =
      ''
        @define-color background #1a1b26;
        @define-color foreground #a9b1d6;
        @define-color red #ce7284;
        @define-color green #7dc5a0;
        @define-color yellow #caaa6a;
        @define-color blue #7bc5e4;
        @define-color magenta #ad8ee6;
        @define-color altred #d5556f;
        @define-color altgreen #b9f27c;
        @define-color altyellow #ff9e64;
        @define-color altblend #282e49;
        @define-color empty #474f6f;
        @define-color pink #c386c0;
        @define-color violet #8682de;

        * {
            border: none;
            font-family: "JetBrainsMono Nerd Font", monospace;
            font-size: 13px;
        }

        window#waybar {
            background-color: @background;
            border-radius: 8px;
            color: @foreground;
            padding: 3px 0px;
        }

        #custom-sep {
          color: @altblend;
          font-size: 14px;
        }

        #workspaces {
            margin-left: 6px;
        }

        #workspaces button {
            padding: 0px 3px;
            border-radius: 0px;
            color: @blue;
        }

        #workspaces button:hover {
            box-shadow: inherit;
            background: @background;
            border: none;
            padding: 0px 3px;
            text-shadow: 0px 0px 2px shade(@blue, 1.1);
        }

        #workspaces button.active {
          color: shade(@pink, 1.1);
          text-shadow: 0px 0px 2px shade(@pink, 1.2);
        }

        #workspaces button.urgent {
            background-color: @altred;
            color: #ffffff;
        }

        #clock,
        #battery,
        #cpu,
        #memory,
        #disk,
        #temperature,
        #network,
        #custom-media,
        #tray,
        #mode,
        #idle_inhibitor,
        #mpd {
            margin: 0px 8px;
        }

        #idle_inhibitor {
            padding: 0px 8px 0px 0px;
        }


        #cpu {
            background-color: @altblend;
            margin: 3px 0px 3px 2px;
            padding-right: 5px;
            padding-left: 8px;
            border-radius: 18px 0px 0px 18px;
        }

        #pulseaudio {
            background-color: @altblend;
            ${
              if config.platform == "laptop" then
                ''
                margin: 3px 0px 3px 2px;
                padding-right: 5px;
                padding-left: 8px;
                border-radius: 18px 0px 0px 18px;
                ''
              else
                ''
                margin: 3px 2px;
                padding: 0px 8px;
                border-radius: 18px;
                ''
            }
        }

        #backlight, #memory {
            background-color: @altblend;
            margin: 3px 4px 3px 0px;
            padding-left: 5px;
            padding-right: 8px;
            border-radius: 0px 18px 18px 0px;
        }

        #network {
            background-color: @altblend;
            margin: 3px 4px;
            padding: 0px 6px;
            border-radius: 18px;
        }


        #window {
            font-family: "NotoSans Nerd Font";
            font-size: 12px;
        }

        #mode {
            color: @magenta;
            text-shadow: 0px 0px 2px shade(@magenta, 1.05);
        }

        #cpu {color: @green;}
        #memory {color: @yellow;}
        #temperature {color: @blue;}
        #clock {color: @blue;}

        #temperature {color: @blue;}
        #temperature.critical {color: @altyellow;}

        @keyframes blink { to { color: @background; } }

        #battery {color: @green;}
        #battery.warning:not(.charging) {color: @altyellow;}
        #battery.low:not(.charging) {color: @altred;}
        #battery.critical:not(.charging) {
            color: #ff2525;
            animation-name: blink;
            animation-duration: 1s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        #backlight {color: @yellow;}
        #network {color: @green;}
        #pulseaudio {color: @pink;}
        #pulseaudio.muted {color: @red;}
        #idle_inhibitor.deactivated {color: @altred;}
        #idle_inhibitor.activated {color: @altgreen;}
      '';
  };
}
