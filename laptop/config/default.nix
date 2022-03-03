{ ... }:
let hashedPassword = "$6$y3eb1phxFWnParRT$w1LNfxJ2ByHoiBa5ywh4STGuIK/r4Tnyxx2Xe/nlovrE6LuuLAVdKRFAroUTtUI/d2BNGI9ErjZ2z2Dl7w/t00";
in {
  imports = [
    ./hardware-configuration.nix
    ./battery.nix
  ];

  networking.hostName = "kiana-laptop";

  boot.loader.grub.useOSProber = true;
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;

  # Passwords
  users.users.kiana = { inherit hashedPassword; };
  users.users.root = { inherit hashedPassword; };

  # Networking
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
  users.users.kiana.extraGroups = [ "networkmanager" ];
}
