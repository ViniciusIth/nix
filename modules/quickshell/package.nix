# {
#   pkgs,
#   lib,
#   inputs,
#   ...
# }: let
#   qsCore = inputs.quickshell.packages.${pkgs.system}.quickshell;
#   qsModules = inputs.quickshell.packages.${pkgs.system}.qt6-qmlmodules;
#
#   quickshell-wrapped =
#     pkgs.runCommand "quickshell-wrapped" {
#       nativeBuildInputs = [pkgs.makeWrapper];
#     } ''
#       mkdir -p $out/bin
#
#       makeWrapper ${qsCore}/bin/qs $out/bin/qs \
#         --prefix QML2_IMPORT_PATH : "${qsModules}/lib/qt6/qml" \
#         --prefix QML2_IMPORT_PATH : "${qsModules}/share/qt6/qml" \
#         --prefix QML2_IMPORT_PATH : "${qsModules}/qml" \
#         --prefix QT_PLUGIN_PATH : "${pkgs.qt6.qtbase}/${pkgs.qt6.qtbase.qtPluginPrefix}" \
#         --prefix QT_PLUGIN_PATH : "${pkgs.qt6.qt5compat}/${pkgs.qt6.qtbase.qtPluginPrefix}"
#     '';
# in {
#   quickshell = quickshell-wrapped;
# }
{}: {}
