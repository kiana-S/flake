{ lib, ... }:
{
  options.custom.platform = lib.mkOption {
    description = "The platform to configure for";
    type = lib.types.enum [ "desktop" "laptop" "mobile" ];
  };
}
