{osConfig, ...}: let
  hostname = osConfig.networking.hostName or "unknown";
in {
  home.username = "viniciusith";
  home.homeDirectory = "/home/viniciusith";

  imports = [
    ../../modules/niri/home.nix
    ../../modules/neovim/home.nix
    ../../modules/yazi/home.nix
    ../../modules/git/home.nix
    ../../modules/zellij/home.nix
    ../../modules/zsh/home.nix
    ../../modules/nixcord/home.nix
    ../../modules/git/home.nix
    ../../modules/quickshell/home.nix
    ./go
  ];

  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    ELECTRON_ENABLE_WAYLAND = "1";
  };

  home.stateVersion = "25.05";
}
