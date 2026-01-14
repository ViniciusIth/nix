{
  osConfig,
  pkgs,
  ...
}: let
  hostname = osConfig.networking.hostName or "unknown";
in {
  home.username = "viniciusith";
  home.homeDirectory = "/home/viniciusith";

  imports = [
    ../../modules/zsh/home.nix
    ../../modules/niri/home.nix
    ../../modules/neovim/home.nix
    ../../modules/yazi/home.nix
    ../../modules/git/home.nix
    ../../modules/zellij/home.nix
    ../../modules/nixcord/home.nix
    ../../modules/git/home.nix
    ../../modules/spotify/home.nix
    ../../modules/vivaldi/home.nix
    ../../modules/telegram.nix
    ../../modules/gimp.nix
    ../../modules/onagre.nix
    ../../modules/prism.nix
    ../../modules/noctalia.nix
  ];
  home.packages = with pkgs; [
    unstable.imv
    pop-launcher
  ];

  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    ELECTRON_ENABLE_WAYLAND = "1";
  };

  home.stateVersion = "25.05";
}
