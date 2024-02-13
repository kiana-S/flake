{ config, pkgs, fullname, email, ... }:
let
  maildir = "${config.xdg.dataHome}/mail";
  pass = config.programs.password-store.package;
in {
  accounts.email = {
    maildirBasePath = maildir;
    accounts = {
      gmail = {
        address = email;
        userName = email;
        flavor = "gmail.com";
        passwordCommand = "${pass}/bin/pass Email/gmail.com";
        primary = true;
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" ];
        };
        realName = fullname;
        msmtp.enable = true;
      };
    };
  };

  programs = {
    msmtp.enable = true;
    mbsync.enable = true;
  };

  services = {
    mbsync = {
      enable = true;
      preExec = "${pkgs.isync}/bin/mbsync -Ha";
      postExec = "${pkgs.mu}/bin/mu index -m ${maildir}";
    };
  };
}
