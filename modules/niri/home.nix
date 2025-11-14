{config, ...}: {
  xdg.configFile."niri" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/viniciusith/dotfiles/config/niri";
    recursive = true;
  };
}
