{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    gnumake
    gcc
    go-swag
    unstable.air
    unstable.go
    unstable.gopls
    unstable.golangci-lint
    unstable.delve
  ];

  home.sessionVariables = {
    GOPATH = "${config.home.homeDirectory}/go";
    GOBIN = "${config.home.homeDirectory}/go/bin";
  };
  home.sessionPath = ["${config.home.homeDirectory}/go/bin"];
}
