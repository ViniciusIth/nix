{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    unstable.bun
  ];
}
