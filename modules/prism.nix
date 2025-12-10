{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    prismlauncher
  ];

  xdg.configFile."onagre" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/viniciusith/dotfiles/config/onagre";
    recursive = true;
  };
}
