return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            -- { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
            -- { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
            "hrsh7th/cmp-nvim-lsp",
            { "antosha417/nvim-lsp-file-operations", config = true },
        },
        config = function()
            local on_attach = function(client, bufnr)
                opts.buffer = bufnr

                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

                opts.desc = "Format file"
                keymap.set("n", "<leader>gf", function()
                    vim.lsp.buf.format { async = true }
                end, opts)
            end

            -- used to enable autocompletion (assign to every lsp server config)
            local capabilities = cmp_nvim_lsp.default_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- Change the Diagnostic symbols in the sign column (gutter)
            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            require("mason-lspconfig").setup_handlers {
                -- Handler padrão para servidores simples
                function(server_name)
                    -- Print server name
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                        on_attach = on_attach
                    })
                end,

                -- Configurações manuais para servidores mais complexos
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup(require("lsp.servers.lua_ls")(capabilities, on_attach))
                end,
                ["gopls"] = function()
                    lspconfig.gopls.setup(require("lsp.servers.gopls")(capabilities, on_attach))
                end,
                ["emmet_language_server"] = function()
                    lspconfig.emmet_language_server.setup(require("lsp.servers.emmet")(capabilities, on_attach))
                end,
                ["rust_analyzer"] = function()
                    lspconfig.rust_analyzer.setup(require("lsp.servers.rust")(capabilities, on_attach))
                end,
            }
        end
    },
    {
        "pmizio/typescript-tools.nvim",
        -- Ensure it loads for relevant filetypes and after nvim-lspconfig
        ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "neovim/nvim-lspconfig", -- ⭐ Make it depend on nvim-lspconfig
        },
        config = function()
            local on_attach = function(_ --[[ client ]], bufnr)
                local keymap = vim.keymap
                local opts = { noremap = true, silent = true, buffer = bufnr }

                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
                keymap.set("n", "K", vim.lsp.buf.hover, opts)
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
                keymap.set("n", "<leader>gf", function()
                    vim.lsp.buf.format { async = true }
                end, opts)
            end

            require("typescript-tools").setup {
                on_attach = on_attach,
                settings = {
                    separate_diagnostic_server = true,
                    expose_as_code_action = "all",
                    tsserver_plugins = {},
                },
            }
        end,
    },
}
