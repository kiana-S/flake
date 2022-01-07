{ config, pkgs, ... }:
{
  imports = [
    ./config.nix
    ./packages.nix
    ./login.nix
  ];
}
