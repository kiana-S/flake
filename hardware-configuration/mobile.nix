{ config, lib, pkgs, ... }:
{
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/bd2fe7f4-b0e8-40b3-8da3-68f56dd49fab";
      fsType = "ext4";
    };

  nix.settings.max-jobs = lib.mkDefault 3;
}
