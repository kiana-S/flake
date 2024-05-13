{ pkgs, lib, ... }:
let
  wayland-idle-inhibitor = pkgs.python312Packages.buildPythonApplication {
    pname = "wayland-idle-inhibitor";
    version = "1.0.0";

    propagatedBuildInputs = with pkgs.python312Packages; [
      pywayland
    ];

    dontUnpack = true;
    installPhase = ''
      install -Dm755 ${./idle/wayland-idle-inhibitor.py} \
        $out/bin/wayland-idle-inhibitor
    '';
  }
in {

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
