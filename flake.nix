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
    
    modulesFor = system:
      [
        { _module.args = moduleArgs; }
        ./common/config
        ./${system}/config
        home-manager.nixosModules.home-manager
        { home-manager = {
          useGlobalPkgs = true;
          users.${username} = import ./${system}/home-manager;
          extraSpecialArgs = moduleArgs;
        }; }
      ];
  in {
    nixosConfigurations = {
      "kiana-desktop" = lib.makeOverridable lib.nixosSystem {
        inherit system;
        modules = modulesFor "desktop"; 
      };

      "kiana-laptop" = lib.makeOverridable lib.nixosSystem {
        inherit system;
        modules = modulesFor "laptop";
      };
    };
  };
}
