{
  pkgs,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
    profiles.default.extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "kanagawa";
        publisher = "qufiwefefwoyn";
        version = "1.5.1";
        sha256 = "sha256-AGGioXcK/fjPaFaWk2jqLxovUNR59gwpotcSpGNbj1c=";
      }
      {
        name = "cobol";
        publisher = "bitlang";
        version = "25.12.5";
        sha256 = "sha256-t3aXT1X/UXwxt5/0+m4Lh4X9vvQS+lgEW+g8RMrBgsE=";
      }
      {
        name = "zopeneditor";
        publisher = "IBM";
        version = "6.2.0";
        sha256 = "sha256-rZpJj4beNYBDq0HGgGJ4QSaIUWEVpPV+s40rgH3AiuQ=";
      }
      {
        name = "vscode-extension-for-zowe";
        publisher = "Zowe";
        version = "3.3.1";
        sha256 = "sha256-vw8bfFnQ6c0JjNhH352u9SGERhcsxmLTz0kMohX6qFA=";
      }
      {
        name = "material-product-icons";
        publisher = "PKief";
        version = "1.7.1";
        sha256 = "sha256-knYRG4j8cU6frLXSpwvaSyE+EWFd1ne/ctYa5kqp5bw=";
      }
    ];
  };
}
