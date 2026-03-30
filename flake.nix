{
  description = "HyprixZero";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestianix = {
      url = "github:Xellor-Dev/caelestia-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, caelestianix, ... }:
    let
      system = "x86_64-linux";
      hostname = "nixos";
      username = "dairozero";
    in {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home-manager/home.nix;
            home-manager.extraSpecialArgs = { inherit caelestianix; };
          }
        ];
      };
    };
}
