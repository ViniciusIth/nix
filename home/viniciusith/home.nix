{osConfig, ...}: let
  hostname = osConfig.networking.hostName or "unknown";
in {
  home.username = "viniciusith";
  home.homeDirectory = "/home/viniciusith";

  imports = [
    ../../modules/neovim/home.nix
    ../../modules/yazi/home.nix
    ../../modules/niri/home.nix
    ./zsh
    ./git
    ./zellij
    ./go
  ];

  home.stateVersion = "25.05";
}
