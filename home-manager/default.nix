{ config, pkgs, username, fullname, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/" + username;

  home.stateVersion = "21.11";

  imports = [ ./shell ./wayland ];

  xdg.enable = true;
  xdg.userDirs.enable = true;

  programs.git = {
    enable = true;
    userName = fullname;
    userEmail = "kiana.a.sheibani@gmail.com";

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

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "curses";
    extraConfig = ''
      allow-loopback-pinentry
    '';
  };
}
