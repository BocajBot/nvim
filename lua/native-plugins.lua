-- Neovim 0.12 native plugin manager. Kickstart upstream also uses vim.pack.
-- Keep plugins only where their behavior is not adequately provided by core.
local gh = function(repo)
  return 'https://github.com/' .. repo
end

-- Some plugin global options must be defined before loading the plugin.
require('custom.plugins.llama').init()
require('custom.plugins.rustaceanvim').init()

-- vim.pack manages installation, updates and a reproducible lockfile.
-- Dependencies are explicit: no separate lazy-loading framework is required.
vim.pack.add {
  gh 'tpope/vim-sleuth',
  gh 'tanvirtin/monokai.nvim',
  gh 'nvim-lua/plenary.nvim',
  gh 'lewis6991/gitsigns.nvim',
  gh 'folke/which-key.nvim',
  gh 'nvim-telescope/telescope.nvim',
  gh 'nvim-telescope/telescope-ui-select.nvim',
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'folke/lazydev.nvim',
  gh 'stevearc/conform.nvim',
  gh 'folke/todo-comments.nvim',
  gh 'nvim-mini/mini.nvim',
  { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' },
  gh 'nvim-lualine/lualine.nvim',
  gh 'lukas-reineke/indent-blankline.nvim',
  { src = gh 'ThePrimeagen/harpoon', version = 'harpoon2' },
  gh 'folke/twilight.nvim',
  { src = gh 'mrcjkb/rustaceanvim', version = vim.version.range '9.*' },
  gh 'ggml-org/llama.vim',
  gh 'akinsho/toggleterm.nvim',
}

-- Monokai and custom appearance remain unchanged.
require('custom.plugins.colors').init()

-- These legacy spec files supply only their config/opts; lazy.nvim is not used.
require('gitsigns').setup(require('kickstart.plugins.gitsigns')[1].opts)
require('kickstart.plugins.which-key')[1].config()
require('kickstart.plugins.telescope')[1].config()
require('lazydev').setup {
  library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } },
}
require('kickstart.plugins.lspconfig')()
require('conform').setup(require('kickstart.plugins.conform')[1].opts)
require('todo-comments').setup(require('kickstart.plugins.todo-comments')[1].opts)
require('kickstart.plugins.mini')[1].config()
local ts = require('kickstart.plugins.treesitter')[1]
ts.config(nil, ts.opts)
require('custom.plugins.lualine').config()
require('custom.plugins.indent-blankline').config()

local harpoon = require('custom.plugins.harpoon')
harpoon.config()
for _, key in ipairs(harpoon.keys) do
  vim.keymap.set('n', key[1], key[2], { desc = key.desc })
end

local twilight = require('custom.plugins.twilight')
require('twilight').setup(twilight.opts)
for _, key in ipairs(twilight.keys) do
  vim.keymap.set('n', key[1], key[2], { desc = key.desc })
end

local terminal = require('custom.plugins.toggle-terminal')[1]
require('toggleterm').setup(terminal.opts)
for _, key in ipairs(terminal.keys()) do
  vim.keymap.set(key.mode or 'n', key[1], key[2], { desc = key.desc })
end
