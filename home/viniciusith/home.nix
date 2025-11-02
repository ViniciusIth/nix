{
  config,
  pkgs,
  inputs,
  lib,
  osConfig,
  ...
}: let
  hostname = osConfig.networking.hostName or "unknown";
in {
  home.username = "viniciusith";
  home.homeDirectory = "/home/viniciusith";

  imports = [
    ../../modules/neovim
    ./git
  ];

  home.stateVersion = "25.05";
}
