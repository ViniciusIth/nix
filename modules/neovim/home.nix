{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      # Icons
      nvim-web-devicons

      # Theme
      catppuccin-nvim

      # Navigation & Files
      telescope-nvim
      plenary-nvim # Required for telescope
      telescope-fzf-native-nvim # Better performance
      nvim-tree-lua
      oil-nvim
      undotree

      # Git
      gitsigns-nvim
      vim-fugitive

      # Editing
      comment-nvim
      nvim-surround
      flash-nvim
      (pkgs.vimUtils.buildVimPlugin {
        name = "multicursor-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "jake-stewart";
          repo = "multicursor.nvim";
          rev = "0c6ceae228bf209e8b8717df9de500770c4e7022";
          sha256 = "sha256-QhYUwFGYXoeXr2dRraHvpYx4z/7R9TyL9OC2sGmIAMY=";
        };
      })

      (pkgs.vimUtils.buildVimPlugin {
        name = "promise-async";
        src = pkgs.fetchFromGitHub {
          owner = "kevinhwang91";
          repo = "promise-async";
          rev = "119e8961014c9bfaf1487bf3c2a393d254f337e2";
          sha256 = "sha256-9eM66brPjiFlY64vmBetRYrKnpDyN7+/URMm4GsGimA=";
        };
        doCheck = false;
      }) # nvim-ufo dependency
      (pkgs.vimUtils.buildVimPlugin {
        name = "nvim-ufo";
        src = pkgs.fetchFromGitHub {
          owner = "kevinhwang91";
          repo = "nvim-ufo";
          rev = "72d54c31079d38d8dfc5456131b1d0fb5c0264b0";
          sha256 = "sha256-VMa09rdDpaiRgD5ORDBjOtqcHTV+czfUY3hCmP9y3e4=";
        };
        doCheck = false;
      })

      # UI & Helpers
      which-key-nvim

      nvim-dap
      nvim-dap-virtual-text
      nvim-dap-go
      nvim-dap-view

      (nvim-treesitter.withPlugins (p: [
        p.bash
        p.css
        p.csv
        p.diff
        p.dockerfile
        p.git_config
        p.git_rebase
        p.gitattributes
        p.gitcommit
        p.gitignore
        p.go
        p.gomod
        p.gosum
        p.gowork
        p.gotmpl
        p.html
        p.javascript
        p.json
        p.jsonnet
        p.lua
        p.make
        p.mermaid
        p.nix
        p.proto
        p.python
        p.qmljs
        p.rust
        p.sql
        p.templ
        p.terraform
        p.toml
        p.tsx
        p.typescript
        p.vimdoc
        p.vim
        p.vue
        p.yaml
        p.zig
      ]))
      nvim-treesitter-context
      nvim-treesitter-textobjects
    ];

    extraPackages = with pkgs; [
      # Telescope dependencies
      ripgrep
      fd
      fzf

      # LSP & Formatters
      lua-language-server
      nil
      alejandra

      # Development
      nodejs
      zig
      tree-sitter
      cargo
      unstable.delve

      # Clipboard
      wl-clipboard
    ];
  };

  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/viniciusith/dotfiles/config/nvim";
    recursive = true;
  };
}
