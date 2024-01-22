return {
    "simrat39/rust-tools.nvim",
    config = function()
        local rt = require("rust-tools")

        rt.setup({
            server = {
                on_attach = function(_, bufnr)
                    -- Hover actions
                    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                    -- Code action groups
                    vim.keymap.set("n", "<Leader>ag", rt.code_action_group.code_action_group, { buffer = bufnr })
                end,
            },
        })
    end,
}
-- return {
--     "mrcjkb/rustaceanvim",
--     version = "^3", -- Recommended
--     ft = { "rust" },
--     opts = {
--         server = {
--             on_attach = function(client, bufnr)
--                 -- register which-key mappings
--                 local wk = require("which-key")
--                 wk.register({
--                     ["<leader>cR"] = {
--                         function()
--                             vim.cmd.RustLsp("codeAction")
--                         end,
--                         "Code Action",
--                     },
--                     ["<leader>dr"] = {
--                         function()
--                             vim.cmd.RustLsp("debuggables")
--                         end,
--                         "Rust debuggables",
--                     },
--                 }, { mode = "n", buffer = bufnr })
--             end,
--             settings = {
--                 -- rust-analyzer language server configuration
--                 ["rust-analyzer"] = {
--                     cargo = {
--                         allFeatures = true,
--                         loadOutDirsFromCheck = true,
--                         runBuildScripts = true,
--                     },
--                     -- Add clippy lints for Rust.
--                     checkOnSave = {
--                         allFeatures = true,
--                         command = "clippy",
--                         extraArgs = { "--no-deps" },
--                     },
--                     procMacro = {
--                         enable = true,
--                         ignored = {
--                             ["async-trait"] = { "async_trait" },
--                             ["napi-derive"] = { "napi" },
--                             ["async-recursion"] = { "async_recursion" },
--                         },
--                     },
--                 },
--             },
--         },
--     },
--     config = function(_, opts)
--         vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
--     end,
-- }
