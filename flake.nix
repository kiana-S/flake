{
description = "System conf";
inputs = rec {
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  nur.url = "github:nix-community/NUR";
  nixos-hardware.url = "github:NixOS/nixos-hardware";

  home-manager.url = "github:nix-community/home-manager/master";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";

  emacs-overlay.url = "github:nix-community/emacs-overlay";
  emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
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

      "kiana-laptop" = lib.makeOverridable lib.nixosSystem {
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
