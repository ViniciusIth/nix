{
  config,
  lib,
  pkgs,
  ...
}: let
  nixos-wsl = builtins.fetchTarball {
    url = "https://github.com/nix-community/nixos-wsl/archive/eabf2ecbb69a6d501b4e85117f4799e0efb0e889.tar.gz";
    sha256 = "0khwas4icq6x7xb7gsaqwnihfllfz4cs0rn15xcg9b9vm6vx98dd";
  };
in {
  imports = [
    ./hardware-configuration.nix
    (import "${nixos-wsl}/modules")
  ];

  # WSL-specific configuration
  wsl = {
    enable = true;
    defaultUser = "viniciusith";
    startMenuLaunchers = true;
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

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

    docker-compose
  ];

  # Programs
  programs = {
    git.enable = true;
    zsh.enable = true;
  };

  virtualisation.docker = {
    enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

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
    uid = 1000;
    shell = pkgs.zsh;
  };

  # DO NOT CHANGE this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  system.stateVersion = "25.05";
}
