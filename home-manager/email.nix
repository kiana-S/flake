{ config, pkgs, lib, fullname, email, ... }:
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
        passwordCommand = "${lib.getExe pass} email/GmailApp/${email}";
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
        passwordCommand = "${lib.getExe pass} email/${ksumail}";
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
      postExec = "${lib.getExe pkgs.mu} index -m ${maildir}";
    };
  };
}
