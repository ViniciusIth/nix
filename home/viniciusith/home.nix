{osConfig, ...}: let
  hostname = osConfig.networking.hostName or "unknown";
in {
  home.username = "viniciusith";
  home.homeDirectory = "/home/viniciusith";

  imports = [
    ../../modules/neovim
    ../../modules/yazi
    ./zsh
    ./git
    ./zellij
    ./go
    ./bun
  ];

  home.stateVersion = "25.05";
}
