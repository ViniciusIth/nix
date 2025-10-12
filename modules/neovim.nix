{ config, pkgs, lib, ...}

{
    home.packages = with pkgs; [
        ripgrep
        fd
        fzf

        lua-language-server
        nil
        nixpkgs-fmt

        nodejs
        zig
        tree-sitter
        cargo
    ];

    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        # optional: If you want to manage your plugins with nix, instead of with lazy.nvim,
        # you can do it with the plugins key.
        # plugins = with pkgs.vimPlugins; [
        #     telescope-nvim
        #     nvim-treesitter
        #     nvim-lspconfig
        #     # Any other packages you want pinned at.
        # ];
    };

    xdg.configFile."nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/viniciusith/nixos-dotfiles/config/nvim";
        recursive = true;
    };
}
