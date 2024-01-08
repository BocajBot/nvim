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
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
-- {
-- 	{
-- 		"numToStr/Comment.nvim",
-- 		config = function()
-- 			require("Comment").setup()
-- 		end,
-- 	},
-- 	-- {
-- 	-- 	"ThePrimeagen/harpoon",
-- 	-- 	branch = "harpoon2",
-- 	-- 	dependencies = { { "nvim-lua/plenary.nvim" } },
-- 	-- },
-- 	"nvim-treesitter/nvim-treesitter",
-- 	"nvim-treesitter/nvim-treesitter-context",
-- 	"nvim-treesitter/playground",
--
-- 	"theprimeagen/refactoring.nvim",
-- 	"mbbill/undotree",
-- 	"tpope/vim-fugitive",
-- 	"stevearc/dressing.nvim",
-- 	"simrat39/rust-tools.nvim",
-- 	"mfussenegger/nvim-dap",
-- 	"gelguy/wilder.nvim",
-- 	"folke/zen-mode.nvim",
-- 	"github/copilot.vim",
-- 	"laytan/cloak.nvim",
-- 	"nvimtools/none-ls.nvim",
-- 	"lukas-reineke/indent-blankline.nvim",
-- 	"lewis6991/impatient.nvim",
-- }
