{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    bashInteractive
  ];

  programs.yazi = {
    enable = true;
  };

  xdg.configFile."yazi" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/viniciusith/nixos-dotfiles/config/yazi";
    recursive = true;
  };

  programs.zsh.initExtra = ''
    y() {
      local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
      yazi "$@" --cwd-file="$tmp"
      if [ -f "$tmp" ]; then
        local dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -n "$dir" ] && [ "$dir" != "$PWD" ]; then
          cd "$dir"
        fi
      fi
    }
  '';
}
