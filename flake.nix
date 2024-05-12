{
description = "System conf";
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  nixos-hardware.url = "github:NixOS/nixos-hardware";
  mobile-nixos.url = "github:kiana-S/mobile-nixos";
  mobile-nixos.flake = false;

  sxmo.url = "github:wentam/sxmo-nix";
  sxmo.flake = false;

  home-manager.url = "github:nix-community/home-manager/master";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";

  tokyo-night-sddm-src.url = "github:rototrash/tokyo-night-sddm";
  tokyo-night-sddm-src.flake = false;
};
outputs = { self,
            nixpkgs,
            home-manager,
            nixos-hardware,
            mobile-nixos,
            sxmo,
...}@inputs:
  let
    username = "kiana";
    fullname = "Kiana Sheibani";
    email = "kiana.a.sheibani@gmail.com";

    moduleArgs = { inherit username fullname email; } // inputs;

    mkConfig =
      { platform,
        system ? "x86_64-linux",
        configModules ? [ ./config ],
        configExtraModules ? [],
        homeModules ? [ ./home-manager ],
        homeExtraModules ? []
      }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules =
          configModules ++
          configExtraModules ++
          [
            ./platform.nix
            { _module.args = moduleArgs;
              inherit platform; }
            ./hardware-configuration/${platform}.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = moduleArgs;

              home-manager.sharedModules = [ ./platform.nix { inherit platform; } ];
              home-manager.users.${username} = {
                imports = homeModules ++ homeExtraModules;
              };
            }
          ];
      };
  in {
    nixosConfigurations = {
      "${username}-desktop" = mkConfig {
        platform = "desktop";
      };

      "${username}-laptop" = mkConfig {
        platform = "laptop";
        configExtraModules = [
          nixos-hardware.nixosModules.microsoft-surface-pro-intel
        ];
      };

      "${username}-mobile" = mkConfig {
        platform = "mobile";
        system = "aarch64-linux";
        configExtraModules = [
          ./mobile/config.nix
          (import (mobile-nixos + /lib/configuration.nix)
            { device = "pine64-pinephonepro"; })
          (sxmo + /modules/sxmo)
          (sxmo + /modules/tinydm)
        ];
        homeModules = [
          ./mobile/home-manager.nix
        ];
      };
    };
  };
}
