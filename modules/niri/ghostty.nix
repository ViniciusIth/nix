{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [
    pkgs.ghostty
  ];
}
