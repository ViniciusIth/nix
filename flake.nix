{
  description = "NixOS";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  # quickshell = {
  #   # add ?ref=<tag> to track a tag
  #   url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
  #   inputs.nixpkgs.follows = "nixpkgs";
  # };
  # hyprland = {
  #   url = "github:hyprwm/Hyprland";
  #   inputs.nixpkgs.follows = "nixpkgs";
  # };
  # ghostty = {
  #   url = "github:ghostty-org/ghostty";
  #   inputs.nixpkgs.follows = "nixpkgs";
  # };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, ...}: {
    nixosConfigurations = {
      desknix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/desknix/configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.viniciusith = import ./home/viniciusith/home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
      wslnix = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/wslnix/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit inputs; };
              users.viniciusith = import ./home/viniciusith/home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
  };
}
