{
description = "System conf";
inputs = rec {
  nixpkgs.url = "nixpkgs/nixos-unstable";

  nur.url = "github:nix-community/NUR";

  home-manager.url = "github:nix-community/home-manager/master";
  home-manager.inputs.nixpkgs.follows = "nixpkgs";
};
outputs = { self,
            nixpkgs,
            home-manager,
...}@inputs:
  let
    system = "x86_64-linux";
    username = "kiana";
    moduleArgs = inputs // { inherit system username; };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      "kiana-pc" = lib.makeOverridable lib.nixosSystem {
        inherit system;
        modules = [
          { _module.args = moduleArgs; }
          ./config
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.kiana = import ./home-manager;
            home-manager.extraSpecialArgs = moduleArgs;
          }
        ]; 
      };
    };
  };
}
