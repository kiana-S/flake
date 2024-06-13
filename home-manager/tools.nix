{ pkgs, fullname, email, ... }:
{

  # Password Store

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions
      (exts: with exts; [ pass-update pass-file pass-otp ]);
  };

  # MPV

  programs.mpv.enable = true;
  programs.mpv.scripts = with pkgs.mpvScripts;
    [ autoload mpris reload seekTo thumbnail quality-menu ];

  programs.mpv.config = {
    osc = false;
  };

  # Git

  programs.git = {
    enable = true;
    userName = fullname;
    userEmail = email;

    signing.key = "6CB106C25E86A9F7";
    signing.signByDefault = true;

    extraConfig = {
      github.user = "kiana-S";
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
