# {
#   pkgs,
#   inputs,
#   ...
# }: {
#   home.packages = with pkgs; [
#     qt6Packages.qt5compat
#     libsForQt5.qt5.qtgraphicaleffects
#     kdePackages.qtbase
#     kdePackages.qtdeclarative
#     kdePackages.qtstyleplugin-kvantum
#   ];
#
#   programs.quickshell = {
#     enable = true;
#     package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
#       withJemalloc = true;
#       withQtSvg = true;
#       withWayland = true;
#       withX11 = false;
#       withPipewire = true;
#       withPam = true;
#       withHyprland = false;
#       withI3 = false;
#     };
#     systemd.enable = true;
#   };
# }
{}: {}
