{
description = "System conf";
inputs = rec {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  nur.url = "github:nix-community/NUR";
  nixos-hardware.url = "github:NixOS/nixos-hardware";

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
    moduleArgs = inputs // { inherit system username fullname; };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      "${username}-desktop" = lib.makeOverridable lib.nixosSystem {
        inherit system;
        modules = [
          { _module.args = moduleArgs; }
          ./desktop/config
          ./common/config
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./desktop/home-manager;
            home-manager.extraSpecialArgs = moduleArgs;
          }
        ]; 
      };

      "${username}-laptop" = lib.makeOverridable lib.nixosSystem {
        inherit system;
        modules = [
          { _module.args = moduleArgs; }
          ./laptop/config
          ./common/config
          home-manager.nixosModules.home-manager
          nixos-hardware.nixosModules.microsoft-surface
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./laptop/home-manager;
            home-manager.extraSpecialArgs = moduleArgs;
          }
        ];
      };
    };
  };
}
