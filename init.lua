-- RA-Multiplex needed for Rust Analyzer to work properly
-- https://github.com/pr2502/ra-multiplex/
require("bocaj")
vim.g.mapleader = " "
vim.g.loaded_perl_provider = 0
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

local opts = { noremap = true, silent = true }
local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end
vim.keymap.set('n', '<leader>qf', quickfix, opts)

vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
