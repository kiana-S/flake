{ config, pkgs, fullname, email, ... }:
let
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
        passwordCommand = "${pass}/bin/pass Email/GmailApp/kiana.a.sheibani@gmail.com";
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
    };
  };

  services = {
    mbsync = {
      enable = true;
      preExec = "${pkgs.isync}/bin/mbsync -Ha";
      postExec = "${pkgs.mu}/bin/mu index -m ${maildir}";
    };
  };
}
