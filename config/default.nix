{ pkgs, lib, ... }:
{
  imports = [
    ./config.nix
    ./packages.nix
    ./login.nix
    ./battery.nix
  ];
}
