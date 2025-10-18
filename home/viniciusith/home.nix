{ config, pkgs, inputs, lib, osConfig, ...  }: 

let
  hostname = osConfig.networking.hostName or "unknown";

in
{
  home.username = "viniciusith";
  home.homeDirectory =  "/home/viniciusith";

  imports = [
    ../../modules/neovim
  ];

  home.stateVersion = "25.05";
}

