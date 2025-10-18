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

  systemd.services.systemd-logind.restartIfChanged = false;

  networking.hostName = "wslnix";
  networking.firewall.enable = false;

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

  # WSL-specific configuration
  wsl = {
    enable = true;
    defaultUser = "viniciusith";
    startMenuLaunchers = true;
    
    wslKind = "wsl2";
  };

  users.users.viniciusith = {
    isNormalUser = true;
    description = "ViniciusIth";
    extraGroups = [
      "wheel" 
      "docker" 
      "networkmanager" 
    ];
    uid = 1000;
  };

  users.users.nixos = lib.mkForce {};

  # DO NOT CHANGE this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  system.stateVersion = "25.05";
}
