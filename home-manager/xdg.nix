{ pkgs, ... }:
let
  org-protocol = pkgs.writeTextDir
    "/share/applications/org-protocol.desktop"
    ''
      [Desktop Entry]
      Name=Org-Protocol
      Exec=emacsclient %u
      Icon=emacs-icon
      Type=Application
      Terminal=false
      MimeType=x-scheme-handler/org-protocol
    '';
in {
  xdg.enable = true;
  xdg.userDirs.enable = true;

  # Org Roam Protocol
  home.packages = [ org-protocol ];
  xdg.mimeApps = {
    enable = true;
    defaultApplications."x-scheme-handler/org-protocol" = [ "org-protocol.desktop" ];
  };
}
