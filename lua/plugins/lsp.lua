return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "j-hui/fidget.nvim",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind-nvim",
        "VonHeikemen/lsp-zero.nvim",
    },
    config = function()
        local lsp_zero = require("lsp-zero")
        lsp_zero.on_attach(function(_, bufnr)
            lsp_zero.default_keymaps({
                bufnr = bufnr
            })
        end)

        local cmp = require("cmp")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            sources = cmp.config.sources({
                { name = "path" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "luasnip", keyword_length = 2 },
                { name = "buffer",  keyword_length = 3 },
            }),
            formatting = lsp_zero.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
        })

        require("fidget").setup()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "tsserver",
            },
            handlers = {
                lsp_zero.default_setup,
                -- require 'lspconfig'.rust_analyzer.setup {
                --     cmd = vim.lsp.rpc.connect("127.0.0.1", 27631),
                --     init_options = {
                --         lspMux = {
                --             version = "1",
                --             method = "connect",
                --             server = "rust-analyzer",
                --         },
                --     },
                -- },
                lua_ls = function()
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            },
        })

        vim.diagnostic.config({
            update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}
