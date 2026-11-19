vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

if vim.loader then
  vim.loader.enable()
end

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = false

-- Disable unused remote plugin providers to reduce startup checks and health noise.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- [[ Setting options ]]
require 'options'

require('keymaps').setup()

-- [[ Built-in tools introduced in Neovim 0.12 ]]
-- Load the opt-in native diff tool so :DiffTool is available immediately.
-- Keep lazy.nvim for third-party plugins and nvim-cmp for completion.
if vim.fn.has 'nvim-0.12' == 1 then
  vim.cmd.packadd 'nvim.difftool'
end

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'
