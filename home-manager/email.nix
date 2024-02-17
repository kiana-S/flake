{ config, pkgs, fullname, email, ... }:
let
  ksumail = "bsheiban@students.kennesaw.edu";
  maildir = "${config.xdg.dataHome}/mail";
  pass = config.programs.password-store.package;
in {
  programs = {
    msmtp.enable = true;
    mbsync.enable = true;
    mu.enable = true;
  };
  home.packages = [ pkgs.emacsPackages.mu4e ];

  accounts.email = {
    maildirBasePath = maildir;
    accounts = {
      gmail = {
        address = email;
        userName = email;
        flavor = "gmail.com";
        passwordCommand = "${pass}/bin/pass Email/GmailApp/${email}";
        primary = true;
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" ];
        };
        realName = fullname;
        msmtp.enable = true;
        mu.enable = true;
      };
      ksu = {
        address = ksumail;
        userName = ksumail;
        flavor = "outlook.office365.com";
        passwordCommand = "${pass}/bin/pass Email/${ksumail}";
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
          patterns = [ "*" ];
        };
        realName = fullname;
        msmtp.enable = true;
        mu.enable = true;
      };
    };
  };

  services = {
    mbsync = {
      enable = true;
      postExec = "${pkgs.mu}/bin/mu index -m ${maildir}";
    };
  };
}
