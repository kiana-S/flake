{ ... }:
{
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
  };

  imports = [
    ./sway.nix
    ./swaylock.nix
    ./swaynag.nix
    ./mako.nix
    ./rofi.nix
    ./waybar.nix
    ./wob.nix
  ];
}
