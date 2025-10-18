require("nvim-treesitter.configs").setup({
    ensure_installed = {},
    highlight = { enable = true },
    indent = { enable = true },
    auto_install = false, -- prevent runtime downloading (handled by nix)
})
