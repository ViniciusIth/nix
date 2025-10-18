{ config, pkgs, inputs, lib, osConfig, ...  }: 

let
  hostname = osConfig.networking.hostName or "unknown";

in
{
  home.username = "viniciusith";
  home.homeDirectory =  "/home/viniciusith";

  imports = [
    # "../../modules/win-manager/quickshell"
    # ../../modules/win-manager/hyprland/home.nix
  ];

  home.stateVersion = "25.05";
}

