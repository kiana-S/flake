{ pkgs, lib, ... }:
let
  wayland-idle-inhibitor = pkgs.stdenv.mkDerivation {
    pname = "wayland-idle-inhibitor";
    version = "1.0.0";

    buildInputs = [
      (pkgs.python312.withPackages (ps: with ps; [
        pywayland
      ]))
    ];

    dontUnpack = true;
    installPhase = ''
      install -Dm755 ${./idle/wayland-idle-inhibitor.py} \
        $out/bin/wayland-idle-inhibitor
    '';
  };
in {

  services.hypridle.enable = true;
  services.hypridle.settings = {
    general = {
      before_sleep_cmd = "swaylock -f";
    };

    listener = [
      {
        timeout = 120;
        on-timeout = "swaylock -f --grace=180";
      }
      {
        timeout = 600;
        on-timeout = "systemctl suspend";
      }
    ];
  };

  # Idle inhibiting

  home.packages = [
    wayland-idle-inhibitor
  ];

  systemd.user.services.wayland-pipewire-idle-inhibit = {
    Install.WantedBy = [ "graphical-session.target" ];

    Unit = {
      Description = "Inhibit Wayland idling when media is played through pipewire";
      Documentation= "https://github.com/rafaelrc7/wayland-pipewire-idle-inhibit";
      After = [ "graphical-session-pre.target" ];
      PartOf = [ "graphical-session.target" ];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };

    Service = {
      ExecStart = "${lib.getExe pkgs.wayland-pipewire-idle-inhibit}";
      Restart = "always";
      RestartSec = "10";
    };
  };
}
