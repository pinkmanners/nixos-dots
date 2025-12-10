{
  description = "baked in a buttery, cripsy, flake uwu";

  inputs = {
    # we enjoy stability in this house
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    catppuccin.url = "github:catppuccin/nix/release-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, catppuccin, home-manager, ... }@inputs:
    let
      # what is an arm? i only have 2 of those
      system = "x86_64-linux";

      # muh overlays
      pkgs = import nixpkgs {
        inherit system;
        overlays = overlays;
      };

      overlays = [
        (import ./home/share/icons/flatery/default.nix)
        (import ./home/share/cursors/mocu/default.nix)
        (import ./home/share/fonts/space-grotesk/default.nix)
        (import ./home/share/themes/catppuccin-gtk/default.nix)
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
          catppuccin.nixosModules.catppuccin
        ];
      };

      # func -> create home-manager configuration for X hostname
      mkHome = hostname: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          inherit inputs hostname;
        };

        modules = [
          # in my home configs
          ./home/hosts/${hostname}.nix
          catppuccin.homeModules.catppuccin
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
        rust = import ./home/dev/rust.nix { inherit pkgs; };
        ruby = import ./home/dev/ruby.nix { inherit pkgs; };
      };
    };
}
