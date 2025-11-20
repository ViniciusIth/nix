{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: let
  quickshellPackage = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
    withJemalloc = true;
    withQtSvg = true;
    withWayland = true;
    withX11 = false;
    withPipewire = true;
    withPam = true;
    withHyprland = false;
    withI3 = false;
  };
in {
  home.packages = with pkgs; [
    qt6Packages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtstyleplugin-kvantum
    quickshellPackage
  ];

  home.sessionVariables = {
    QML_IMPORT_PATH = lib.makeSearchPath "lib/qt-6/qml" [
      pkgs.kdePackages.qt5compat
      pkgs.kdePackages.qtbase
      pkgs.kdePackages.qtdeclarative
      pkgs.kdePackages.qtmultimedia
      pkgs.libsForQt5.qt5.qtgraphicaleffects
      quickshellPackage
    ];
  };

  xdg.configFile."quickshell" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/viniciusith/dotfiles/config/quickshell";
    recursive = true;
  };
}
