{ config, lib, ... }:
lib.mkIf (config.platform == "laptop") {
  services.upower = {
    enable = true;
    
    usePercentageForPolicy = true;
    percentageLow = 15;
    percentageCritical = 5;
  };  
}
