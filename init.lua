require("bocaj")
vim.g.mapleader = " "
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
-- 		"tanvirtin/monokai.nvim",
-- 		config = function() end,
-- 	},
-- 	{
-- 		"nvim-telescope/telescope.nvim",
-- 		branch = "0.1.x",
-- 		dependencies = { { "nvim-lua/plenary.nvim" } },
-- 	},
-- 	{
-- 		"folke/trouble.nvim",
-- 		config = function()
-- 			require("trouble").setup({
-- 				icons = false,
-- 				-- your configuration comes here
-- 				-- or leave it empty to  the default settings
-- 				-- refer to the configuration section below
-- 			})
-- 		end,
-- 	},
-- 	{
-- 		"sudormrfbin/cheatsheet.nvim",
--
-- 		dependencies = {
-- 			{ "nvim-telescope/telescope.nvim" },
-- 			{ "nvim-lua/popup.nvim" },
-- 			{ "nvim-lua/plenary.nvim" },
-- 		},
-- 	},
-- 	{
-- 		"kevinhwang91/nvim-ufo",
-- 		dependencies = {
-- 			"kevinhwang91/promise-async",
-- 			{
-- 				"luukvbaal/statuscol.nvim",
-- 				config = function()
-- 					local builtin = require("statuscol.builtin")
-- 					require("statuscol").setup({
-- 						relculright = true,
-- 						segments = {
-- 							{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
-- 							{ text = { "%s" }, click = "v:lua.ScSa" },
-- 							{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
-- 						},
-- 					})
-- 				end,
-- 			},
-- 		},
-- 	},
-- 	{
-- 		"nvim-lualine/lualine.nvim",
-- 		dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
-- 	},
-- 	{
-- 		"folke/noice.nvim",
-- 		dependencies = {
-- 			"MunifTanjim/nui.nvim",
-- 			"rcarriga/nvim-notify",
-- 		},
-- 	},
-- 	{
-- 		"folke/which-key.nvim",
-- 		config = function()
-- 			vim.o.timeout = true
-- 			vim.o.timeoutlen = 300
-- 			require("which-key").setup({
-- 				-- your configuration comes here
-- 				-- or leave it empty to  the default settings
-- 				-- refer to the configuration section below
-- 			})
-- 		end,
-- 	},
-- 	{
-- 		"VonHeikemen/lsp-zero.nvim",
-- 		dependencies = {
-- 			-- LSP Support
-- 			{ "neovim/nvim-lspconfig" },
-- 			{ "williamboman/mason.nvim" },
-- 			{ "williamboman/mason-lspconfig.nvim" },
--
-- 			-- Autocompletion
-- 			{ "hrsh7th/nvim-cmp" },
-- 			{ "hrsh7th/cmp-buffer" },
-- 			{ "hrsh7th/cmp-path" },
-- 			{ "saadparwaiz1/cmp_luasnip" },
-- 			{ "hrsh7th/cmp-nvim-lsp" },
-- 			{ "hrsh7th/cmp-nvim-lua" },
--
-- 			-- Snippets
-- 			{ "L3MON4D3/LuaSnip" },
-- 			{ "rafamadriz/friendly-snippets" },
-- 		},
-- 	},
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
