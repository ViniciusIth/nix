{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    history.size = 10000;
    history.ignoreAllDups = true;

    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };

    initContent = lib.mkOrder 1200 "
        source ~/.p10k.zsh
        fastfetch
    ";

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };

  home.packages = with pkgs; [
    fastfetch
  ];

  xdg.configFile."fastfetch" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/viniciusith/dotfiles/config/fastfetch";
    recursive = true;
  };
}
