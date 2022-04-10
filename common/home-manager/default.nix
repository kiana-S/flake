{ config, pkgs, username, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/" + username;

  imports = [ ./shell ./wayland ./spacemacs.nix ];

  xdg.enable = true;
  xdg.userDirs.enable = true;

  programs.git = {
    enable = true;
    userName = "kiana-S";
    userEmail = "kiana.a.sheibani@gmail.com";

    extraConfig = {
      credential.helper = "store";
      git.allowForcePush = true;
      init.defaultBranch = "main";
    };
  };
}
