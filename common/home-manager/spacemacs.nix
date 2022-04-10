{ config, pkgs, spacemacs, ... }:
{
  # Set up spacemacs using local emacs config

  home.file.".emacs.d" = {
    recursive = true;
    source = spacemacs;
  };
}

