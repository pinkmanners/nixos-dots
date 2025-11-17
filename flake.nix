{
  description = "baked in a buttery, cripsy, flake uwu";

  inputs = {
    # we enjoy stability in this house
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      # what is an arm? i only have 2 of those
      system = "x86_64-linux";

      # muh overlays
      overlays = [
        # flatery icon theme
        (final: prev: {
          flatery-icon-theme = final.callPackage ./home/share/icons/flatery/default.nix { };
        })

        # mocu cursor theme
        (final: prev: {
          mocu-cursors = final.callPackage ./home/share/cursors/mocu/default.nix { };
        })
      ];

      # func -> create nixosConfiguration for X hostname
      mkHost = hostname: nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs hostname;
        };

        modules = [
          { nixpkgs.overlays = overlays; }

          ./configs/${hostname}/configuration.nix
          ./configs/${hostname}/hardware-configuration.nix
        ];
      };

      # func -> create home-manager configuration for X hostname
      mkHome = hostname: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};

        extraSpecialArgs = {
          inherit inputs hostname;
        };

        modules = [
          # apply overlays
          { nixpkgs.overlays = overlays; }

          # in my home configs
          ./home/hosts/${hostname}.nix
        ];
      };

    in {
      nixosConfigurations = {
        BarkBox = mkHost "BarkBox";
        E5430 = mkHost "E5430";
        L14 = mkHost "L14";
        T450 = mkHost "T450";
        X61 = mkHost "X61";
      };

      homeConfigurations = {
        "jayden@BarkBox" = mkHome "BarkBox";
        "jayden@E5430" = mkHome "E5430";
        "jayden@L14" = mkHome "L14";
        "jayden@T450" = mkHome "T450";
        "jayden@X61" = mkHome "X61";
      };

      devShells.${system} = {
        rust = import ./home/dev/rust.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        ruby = import ./home/dev/ruby.nix { pkgs = nixpkgs.legacyPackages.${system}; };
      };
    };
}
