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
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
  };
}
