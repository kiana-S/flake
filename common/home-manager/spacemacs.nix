{ config, pkgs, spacemacs, spacemacs-config, ... }:
{
  # Set up spacemacs using local emacs config

  home.file.".emacs.d" = {
    recursive = true;
    source = spacemacs;
  };

  # Spacemacs config

  home.file.".spacemacs.d".source = spacemacs-config;
}

