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

-- 0.12 is required by nvim-treesitter/main and the native plugin setup.
if vim.fn.has 'nvim-0.12' ~= 1 then
  error 'This configuration requires Neovim 0.12 or newer'
end

-- Bundled modules are opt-in.
vim.cmd.packadd 'nvim.undotree'
vim.cmd.packadd 'nvim.difftool'

-- External plugins are installed and configured by Neovim's own vim.pack.
require 'native-plugins'
