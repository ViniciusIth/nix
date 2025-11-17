{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    initContent = lib.mkOrder 1000 ''
      zj_ressurrect () {
          local sessions
          sessions=$(echo "''${ZJ_SESSIONS}")
          [ -z "''${sessions}" ] && { echo "No sessions found."; zellij attach -c; return; }
          echo "''${sessions}" | fzf --ansi --multi --preview "echo {}" | awk '{print $1}' | xargs -o -I {} zellij attach {}
      }

      # Guard: don't recurse inside zellij; skip on SSH
      if [ -z "''${ZELLIJ:-}" ] && [ -z "''${SSH_TTY:-}" ]; then
          ZJ_SESSIONS=$(zellij list-sessions)
          NO_SESSIONS=$(echo "''${ZJ_SESSIONS}" | grep -v '^$' | wc -l)
          if [ "''${NO_SESSIONS}" -ge 2 ]; then
              zj_ressurrect
          else
              zellij attach -c
          fi
      fi
    '';
  };

  xdg.configFile."zellij/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/config/zellij/config.kdl";
}
