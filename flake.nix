{
  description = "NixOS";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:kaylorben/nixcord/db15ef80264e0c9f60aea019b657e3f9523445bd";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  }: {
    nixosConfigurations = {
      desknix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          {nixpkgs.overlays = [(import ./overlays/unstable.nix {inherit inputs;})];}

          ./hosts/desknix/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.viniciusith = import ./home/viniciusith/home.nix;
              backupFileExtension = "backup";

              sharedModules = [
                inputs.nixcord.homeModules.nixcord
              ];
            };
          }
        ];
      };

      wslnix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          {nixpkgs.overlays = [(import ./overlays/unstable.nix {inherit inputs;})];}

          ./hosts/wslnix/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.viniciusith = import ./home/viniciusith/home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
  };
}
