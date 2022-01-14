{
description = "System conf";
inputs = rec {
  nixpkgs.url = "nixpkgs/nixos-unstable";

  nur.url = "github:nix-community/NUR";

  nixos-hardware.url = "github:NixOS/nixos-hardware";

  home-manager.url = "github:nix-community/home-manager/master";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";
};
outputs = { self,
            nixpkgs,
            home-manager,
            nixos-hardware,
...}@inputs:
  let
    system = "x86_64-linux";
    username = "kiana";
    moduleArgs = inputs // { inherit system username; };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      "kiana-desktop" = lib.makeOverridable lib.nixosSystem {
        inherit system;
        modules = [
          { _module.args = moduleArgs; }
          ./common/config
          ./desktop/config
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./desktop/home-manager;
            home-manager.extraSpecialArgs = moduleArgs;
          }
        ]; 
      };

      "kiana-laptop" = lib.makeOverridable lib.nixosSystem {
        inherit system;
        modules = [
          { _module.args = moduleArgs; }
          ./common/config
          ./laptop/config
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
