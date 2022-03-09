modules-left:
modules-center:
modules-right:
{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    
    settings = [{
      height = 30;

      inherit modules-left modules-center modules-right;

      modules = {
        "sway/mode" = {
          "format" = "<span style=\"italic\">{}</span>";
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
          format-icons.deactivated = "";
        };
        "tray" = {
          # icon-size = 21;
          spacing = 10;
        };
        "clock" = {
          # timezone = "America/New_York";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        "cpu" = {
          format = " {usage}%";
          tooltip = false;
        };
        "battery" = {
          states.warning = 30;
          states.low = 15;
          states.critical = 5;

          format-icons = [ "" "" "" "" "" ];
          format = "{icon}  {capacity}%";
          format-charging = "{icon}  {capacity}% ⚡";
          format-time = "{H}h {M}m";
        };
        "memory" = {
          format = " {}%";
        };
        "temperature" = {
          # thermal-zone = 2;
          # hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          # format-critical = "{temperatureC}°C {icon}";
          format = "{icon} {temperatureC}°C";
          format-icons = [ "" "" "" ];
        };
        "backlight" = {
          # device = "acpi_video1";
          format = "{icon}  {percent}%";
          format-icons = [ "" "" ];
        };
        "network" = {
          # interface = "wlp2*"; # (Optional) To force the use of this interface
          format-wifi = "  {essid} <span foreground='#B0B0B0'>{signalStrength}%</span>";
          format-ethernet = "  wired";
          format-disconnected = "disconnected";
          tooltip-format = "{ifname} {ipaddr}";
          tooltip-format-disconnected = "disconnected";
        };
        "pulseaudio" = {
          # scroll-step = 1; # %, can be a float
          format = "{icon} {volume}%";
          format-bluetooth = " {icon} {volume}%";
          format-bluetooth-muted = "  0%";
          format-muted = " {volume}%";

          format-icons.headphone  = "";
          format-icons.hands-free = "";
          format-icons.headset    = "";
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
      };
    }];
    
    style =
      ''
        * {
            border: none;
            border-radius: 0;
            font-family: "UbuntuMono Nerd Font", sans-serif;
            font-size: 16px;
            min-height: 0;
        }

        window#waybar {
            background-color: rgba(0, 0, 0, 0.6);
            color: #ffffff;
            transition: background-color .2s;
            padding: 5px 0;
        }

        window#waybar.hidden {
            opacity: 0.2;
        }

        /*
        window#waybar.empty {
            background-color: transparent;
        }
        window#waybar.solo {
            background-color: #FFFFFF;
        }
        */

        window#waybar.termite {
            background-color: #3F3F3F;
        }

        window#waybar.chromium {
            background-color: #000000;
            border: none;
        }

        #workspaces button {
            padding: 0 5px;
            background-color: transparent;
            color: #ffffff;
            /* Use box-shadow instead of border so the text isn't offset */
            box-shadow: inset 0 -3px transparent;
        }

        #workspaces button:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        #workspaces button.focused {
            background: rgba(255, 255, 255, 0.2);
            box-shadow: inset 0 -3px #ffffff;
        }

        #workspaces button.urgent {
            background-color: #eb4d4b;
        }

        #mode {
            background-color: #64727D;
            border-bottom: 3px solid #ffffff;
        }

        #clock,
        #battery,
        #cpu,
        #memory,
        #disk,
        #temperature,
        #backlight,
        #network,
        #pulseaudio,
        #custom-media,
        #tray,
        #mode,
        #idle_inhibitor,
        #mpd {
            padding: 0px 10px;
            margin: 0px 16px 0px 0px;
        }

        #window,
        #workspaces {
            margin: 0 4px;
        }

        /* If workspaces is the leftmost module, omit left margin */
        .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
        }

        /* If workspaces is the rightmost module, omit right margin */
        .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
        }

        #clock {
            box-shadow: inset 0 -3px #0a6cf5;
        }

        #battery {
            box-shadow: inset 0 -3px #a0f23c;
        }

        #battery.warning:not(.charging) {
            box-shadow: inset 0 -3px #fcda44;
            color: #fce788;
        }

        #battery.low:not(.charging) {
            box-shadow: inset 0 -3px #f93920;
            color: #f97f6f;
        }

        @keyframes blink {
            80% {
                color: rgba(0, 0, 0, 0);
            }
        }

        #battery.critical:not(.charging) {
            box-shadow: inset 0 -3px #400000;
            color: #ff2525;
            animation: blink 1.5s step-start infinite;
        }

        #backlight {
            box-shadow: inset 0 -3px #ffff50;
        }

        #network {
            box-shadow: inset 0 -3px #9f78ff;
        }

        #pulseaudio {
            box-shadow: inset 0 -3px #5af78e;
        }

        #pulseaudio.muted {
            box-shadow: inset 0 -3px #ff5c57;
        }

        label:focus {
            background-color: #000000;
        }
      '';
  };
}
