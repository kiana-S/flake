{ config, pkgs, lib, ... }:
{
  imports = [ pkgs.nur.repos.noneucat.modules.pinephone.sxmo ];
}
