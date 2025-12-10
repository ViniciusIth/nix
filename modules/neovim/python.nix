{
  config,
  pkgs,
  ...
}: {
  home.packages = [
    pkgs.python3Full
  ];
}
