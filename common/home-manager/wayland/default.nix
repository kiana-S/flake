{ ... }:
{
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
  };

  imports = [
    ./sway.nix
    ./swaylock.nix
    ./wofi.nix
    ./mako.nix
  ];
}
