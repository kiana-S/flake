{ config, pkgs, username, fullname, email, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/" + username;

  home.stateVersion = "21.11";

  imports = [ ./shell ./wayland ./password.nix ./email.nix ];

  xdg.enable = true;
  xdg.userDirs.enable = true;

  programs.git = {
    enable = true;
    userName = fullname;
    userEmail = email;

    signing.key = "6CB106C25E86A9F7";
    signing.signByDefault = true;

    extraConfig = {
      credential.helper = "store";
      git.allowForcePush = true;
      push.followTags = true;
      init.defaultBranch = "main";
    };

    delta.enable = true;
    delta.options = {
      features = "decorations";
      relative-paths = true;

      decorations = {
        file-style = "yellow";
        hunk-header-style = "line-number syntax";
      };
    };
  };
}
