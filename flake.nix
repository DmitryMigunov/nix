{
  description = "Nix with Flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    mkHost = name:
      nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
          hostName = name;
        };

        modules = [
          ({...}: {
            nixpkgs.config.allowUnfree = true;
          })

          ./configuration.nix
          ./host.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.dmitry = import ./home.nix;

            home-manager.extraSpecialArgs = {
              inherit inputs system;
              hostName = name;
            };
          }
        ];
      };
  in {
    nixosConfigurations = {
      dm = mkHost "dm";
      citadele = mkHost "citadele";
    };

    formatter.${system} = pkgs.alejandra;
  };
}
