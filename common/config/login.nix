{ config, pkgs, username, ... }:
{
  environment.systemPackages = with pkgs; [
    # Greeter
    greetd.gtkgreet
    # Window manager used to display the greeter
    cage
  ];

  services.greetd.enable = true;
  services.greetd.settings = {
    default_session = {
      command = "cage -s -- gtkgreet";
      user = "greeter";
    };
  };
  
  environment.etc = {
    "greetd/environments".text = ''
      sway
      fish
      bash
    '';
  };
}
