modules-left:
modules-center:
modules-right:
{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;

    settings =
      let spanfa = "<span font=\"Font Awesome 5 Regular 11\">";
      in [{
        height = 30;
        margin = "8 8 0";

        inherit modules-left modules-center modules-right;

        modules = {
          "sway/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            numeric-first = true;
            format = "<big>{icon}</big>";

            persistent_workspaces = {
              "10:browser" = [];
              "20:terminal" = [];
              "30:code" = [];
              "40:files" = [];
              "50:discord" = [];
              "60:settings" = [];
            };

            format-icons = {
              terminal = "${spanfa}</span>";
              code = "${spanfa}</span>";
              browser = "${spanfa}<big></big></span>";
              files = "${spanfa}</span>";
              discord = "${spanfa}</span>";
              settings = "${spanfa}</span>";
            };
          };
          "sway/mode" = {
            format = "<span style=\"italic\">{}</span>";
          };
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
            format = "<span font=\"Font Awesome 5 Regular 13\"></span> <span rise=\"1pt\">{usage}%</span>";
            tooltip = false;
          };
          "battery" = {
            states.warning = 30;
            states.low = 15;
            states.critical = 5;

            format-icons = [ "" "" "" "" "" "" "" "" "" "" "" ];
            format = "<span font=\"UbuntuMono Nerd Font 12\">{icon}</span> {capacity}%";
            format-charging = "<span font=\"UbuntuMono Nerd Font 12\"> </span>{capacity}%";
            format-time = "{H}h {M}m";
          };
          "memory" = {
            format = "${spanfa}<small></small></span> {}%";
          };
          "temperature" = {
            # thermal-zone = 2;
            # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
            critical-threshold = 70;
            format = "${spanfa}<small>{icon}</small></span> {temperatureC}°C";
            format-icons = [ "" "" "" "" "" ];
          };
          "backlight" = {
            # device = "acpi_video1";
            format = "<span font=\"Font Awesome 5 Regular 12\"><big>{icon}</big></span><small> </small><span rise=\"2pt\">{percent}%</span>";
            format-icons = [ "" "" "" "" ];
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
            format = "${spanfa}{icon}</span>{volume}%";
            format-bluetooth = " {icon} {volume}%";
            format-bluetooth-muted = "  0%";
            format-muted = " {volume}%";

            format-icons.headphone  = "";
            format-icons.phone      = "";
            format-icons.portable   = "";
            format-icons.car        = "";
            format-icons.default    = [ "" "" " " ];

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
        @define-color black #32344a;
        @define-color red #ce7284;
        @define-color green #7dc5a0;
        @define-color yellow #caaa6a;
        @define-color blue #7bc5e4;
        @define-color magenta #ad8ee6;
        @define-color cyan #449dab;
        @define-color white #787c99;
        @define-color altblack #444b6a;
        @define-color altred #d5556f;
        @define-color altgreen #b9f27c;
        @define-color altyellow #ff9e64;
        @define-color altblue #7da6ff;
        @define-color altmagenta #bb9af7;
        @define-color altcyan #0db9d7;
        @define-color altwhite #acb0d0;
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
            padding: 3px 0;
        }

        #custom-sep {
          color: @altblend;
          font-size: 14px;
        }

        #workspaces {
            margin-left: 6px;
        }

        #workspaces button {
            padding: 0 3px;
            border-radius: 0;
            color: @blue;
        }

        #workspaces button:hover {
            box-shadow: inherit;
            text-shadow: inherit;
            background: @background;
            border: none;
            padding: 0 3px;
        }

        #workspaces button.persistent {color: @empty;}
        #workspaces button.focused {
          color: shade(@pink, 1.1);
          text-shadow: 0 0 2 shade(@pink, 1.2);
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
            margin: 0 8px;
        }

        #idle_inhibitor {
            padding: 0 8px 0 0;
        }


        #cpu, #pulseaudio {
            background-color: @altblend;
            margin: 3px 0 3px 2px;
            padding-right: 5px;
            padding-left: 8px;
            border-radius: 18px 0 0 18px;
        }

        #backlight, #memory {
            background-color: @altblend;
            margin: 3px 4px 3px 0;
            padding-left: 5px;
            padding-right: 8px;
            border-radius: 0 18px 18px 0;
        }

        #network {
            background-color: @altblend;
            margin: 3px 4px;
            padding: 0 6px;
            border-radius: 18px;
        }


        #window {
            font-family: "NotoSans Nerd Font";
            font-size: 12px;
        }

        #mode {color: @cyan;}
        #cpu {color: @green;}
        #memory {color: @yellow;}
        #temperature {color: @blue;}
        #clock {color: @blue;}

        #battery {color: @green;}
        #battery.warning:not(.charging) {color: @altyellow;}
        #battery.low:not(.charging) {color: @altred;}
        #battery.critical:not(.charging) {color: #ff2525;}

        #backlight {color: @yellow;}
        #network {color: @green;}
        #pulseaudio {color: @pink;}
        #pulseaudio.muted {color: @red;}
        #idle_inhibitor.deactivated {color: @altred;}
        #idle_inhibitor.activated {color: @altgreen;}
      '';
  };
}
