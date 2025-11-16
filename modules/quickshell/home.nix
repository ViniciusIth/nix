{
  pkgs,
  inputs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    qt6Packages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtstyleplugin-kvantum
    (inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
      withQMLLib = true;
      withJemalloc = true;
      withQtSvg = true;
      withWayland = true;
      withX11 = false;
      withPipewire = true;
      withPam = true;
      withHyprland = false;
      withI3 = false;
    })
  ];

  xdg.configFile."quickshell" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/viniciusith/dotfiles/config/quickshell";
    recursive = true;
  };
}
