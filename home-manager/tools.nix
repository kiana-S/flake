{ pkgs, ... }:
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
}
