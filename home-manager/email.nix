{ pkgs, fullname, email, ... }:
let
  maildir = "/home/kiana/.mail";
in {
  accounts.email = {
    maildirBasePath = maildir;
    accounts = {
      Gmail = {
        address = email;
        userName = email;
        flavor = "gmail.com";
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
