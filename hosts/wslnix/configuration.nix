{ 
  config, 
  lib, 
  pkgs, 
  ... 
}: 
{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "wslnix";

  time.timeZone = "America/Sao_Paulo";

  # System packages
  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    git

    # terminal utilities
    btop
    file
    tree
    unzip
  ];

  # Programs
  programs = {
    git.enable = true;
    bash.completion.enable = true;
  };

  # Allow proprietary packages
  nixpkgs.config.allowUnfree = true;

  users.users.viniciusith = {
    isNormalUser = true;
    description = "ViniciusIth";
    extraGroups = [
      "wheel" 
      "docker" 
      "networkmanager" 
    ];
  };

  # DO NOT CHANGE this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  system.stateVersion = "25.05";
}
