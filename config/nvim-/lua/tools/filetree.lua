local function my_on_attach(bufnr)
end

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        -- OpenpNvimTree

        require("nvim-tree").setup {
            on_attach = my_on_attach,
        }
    end,
}
