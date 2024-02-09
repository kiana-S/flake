{ config, lib, pkgs, tokyo-night-sddm-src, ... }:
lib.mkIf (config.platform != "mobile")
  (let
    tokyo-night-sddm = with pkgs.libsForQt5; pkgs.stdenv.mkDerivation {
      name = "tokyo-night-sddm";
      src = tokyo-night-sddm-src;
      installPhase = ''
        cp -f ${./tokyo-night-sddm/theme.conf} ./theme.conf
        mkdir -p $out/share/sddm/themes/tokyo-night-sddm
        mv * $out/share/sddm/themes/tokyo-night-sddm
      '';
    };
  in {
    environment.systemPackages = with pkgs.libsForQt5; [
      tokyo-night-sddm # Theme
      qtbase
      qtsvg
      qtquickcontrols2
      qtgraphicaleffects
    ];

    services.xserver = {
      enable = true;

      displayManager.defaultSession = "hyprland";
      displayManager.sddm = {
        enable = true;
        theme = "tokyo-night-sddm";
      };
    };
  })
