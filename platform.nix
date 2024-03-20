{ lib, ... }:
{
  options.platform = lib.mkOption {
    description = "The platform to configure for";
    type = lib.types.str;
  };
}
