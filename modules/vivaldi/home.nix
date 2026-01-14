{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    google-chrome
    (vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
    })
  ];
}
