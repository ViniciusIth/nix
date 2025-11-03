{
  config,
  pkgs,
  upkgs,
  ...
}: {
  home.packages = with upkgs; [
    go
    gopls
    golangci-lint
  ];

  programs.go = {
    enable = true;
    goPath = "${config.home.homeDirectory}/go";
    goBin = "${config.home.homeDirectory}/go/bin";
  };

  home.sessionVariables = {
    GOPATH = "${config.home.homeDirectory}/go";
    GOBIN = "${config.home.homeDirectory}/go/bin";
  };
}
