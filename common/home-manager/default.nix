{ config, pkgs, username, ... }:
{
  home.username = username;
  home.homeDirectory = "/home/" + username;

  imports = [ ./shell ./wayland ];

  xdg.enable = true;
  xdg.userDirs.enable = true;

  programs.git = {
    enable = true;
    userName = "Kiana Sheibani";
    userEmail = "kiana.a.sheibani@gmail.com";

    extraConfig = {
      credential.helper = "store";
      git.allowForcePush = true;
      init.defaultBranch = "main";

      user.signingkey = "6CB106C25E86A9F7";
      commit.gpgsign = true;
    };
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "curses";
  };
}
