{
description = "System conf";
inputs = {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  nur.url = "github:nix-community/NUR";

  nixos-hardware.url = "github:NixOS/nixos-hardware";
  mobile-nixos.url = "github:wentam/mobile-nixos/ppp-pr";
  mobile-nixos.flake = false;

  home-manager.url = "github:nix-community/home-manager/master";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";

  tokyo-night-sddm-src.url = "github:rototrash/tokyo-night-sddm";
  tokyo-night-sddm-src.flake = false;
};
outputs = { self,
            nixpkgs,
            home-manager,
            nixos-hardware,
...}@inputs:
  let
    system = "x86_64-linux";
    username = "kiana";
    fullname = "Kiana Sheibani";
    moduleArgs = { inherit system username fullname; } // inputs;
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      "${username}-desktop" = lib.makeOverridable lib.nixosSystem {
        inherit system;
        modules = [
          ./config

          ./platform.nix
          ./hardware-configuration/desktop.nix
          { _module.args = moduleArgs;
            platform = "desktop"; }
          home-manager.nixosModules.home-manager
          {
            home-manager.users.${username} = import ./home-manager;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ ./platform.nix { platform = "desktop"; } ];
            home-manager.extraSpecialArgs = moduleArgs;
          }
        ]; 
      };

      "${username}-laptop" = lib.makeOverridable lib.nixosSystem {
        inherit system;
        modules = [
          ./config

          { _module.args = moduleArgs;
            platform = "laptop"; }
          ./platform.nix
          ./hardware-configuration/laptop.nix
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.microsoft-surface
          {
            home-manager.users.${username} = import ./home-manager;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ ./platform.nix { platform = "laptop"; } ];
            home-manager.extraSpecialArgs = moduleArgs;
          }
        ];
      };

      "${username}-mobile" = lib.makeOverridable lib.nixosSystem {
        inherit system;
        modules = [
          ./config

          { _module.args = moduleArgs;
            platform = "mobile"; }
          ./platform.nix
          ./hardware-configuration/mobile.nix
          home-manager.nixosModules.home-manager
          (import ${mobile-nixos}/lib/configuration.nix { device = "pine64-pinephonepro"; })
          ${mobile-nixos}/examples/phosh/phosh.nix
          {
            home-manager.users.${username} = import ./mobile/home-manager.nix;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ ./platform.nix { platform = "mobile"; } ];
            home-manager.extraSpecialArgs = moduleArgs;
          }
        ];
      };
    };
  };
}
