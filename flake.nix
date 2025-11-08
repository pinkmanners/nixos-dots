{
  description = "Multi-host NixOS configuration with home-manager";

  inputs = {
    # Using nixos-25.05 release branch for stability
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Home-manager following the same release branch
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      # System architecture - all your hosts are x86_64-linux
      system = "x86_64-linux";

      # Import overlays for custom packages
      overlays = [
        # Flatery icon theme overlay
        (final: prev: {
          flatery-icon-theme = final.callPackage ./home/share/icons/flatery/default.nix { };
        })

        # Mocu cursor theme overlay
        (final: prev: {
          mocu-cursors = final.callPackage ./home/share/cursors/mocu/default.nix { };
        })
      ];

      # Function to create nixosConfiguration for a given hostname
      mkHost = hostname: nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs hostname;
        };

        modules = [
          # Apply overlays to nixpkgs
          { nixpkgs.overlays = overlays; }

          # Host-specific configuration
          ./configs/${hostname}/configuration.nix
          ./configs/${hostname}/hardware-configuration.nix
        ];
      };

      # Function to create home-manager configuration for a given hostname
      mkHome = hostname: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};

        extraSpecialArgs = {
          inherit inputs hostname;
        };

        modules = [
          # Apply overlays to home-manager's pkgs
          { nixpkgs.overlays = overlays; }

          # Host-specific home configuration
          ./home/hosts/${hostname}.nix
        ];
      };

    in {
      # NixOS system configurations
      nixosConfigurations = {
        BarkBox = mkHost "BarkBox";
        E5430 = mkHost "E5430";
        L14 = mkHost "L14";
        T450 = mkHost "T450";
        X61 = mkHost "X61";
      };

      # Home-manager configurations
      homeConfigurations = {
        "jayden@BarkBox" = mkHome "BarkBox";
        "jayden@E5430" = mkHome "E5430";
        "jayden@L14" = mkHome "L14";
        "jayden@T450" = mkHome "T450";
        "jayden@X61" = mkHome "X61";
      };

      # Development shells for rust and ruby
      devShells.${system} = {
        rust = import ./home/dev/rust.nix { pkgs = nixpkgs.legacyPackages.${system}; };
        ruby = import ./home/dev/ruby.nix { pkgs = nixpkgs.legacyPackages.${system}; };
      };
    };
}
