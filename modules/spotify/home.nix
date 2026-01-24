{
  pkgs,
  inputs,
  ...
}: let
  spicetifyPkg = inputs.spicetify.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [
    inputs.spicetify.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;
    theme = spicetifyPkg.themes.bloom;
  };
}
