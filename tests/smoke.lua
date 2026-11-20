-- Headless checks for Neovim 0.12 native-first configuration.
local function check(label, condition)
  if not condition then
    error('Neovim smoke test failed: ' .. label)
  end
end

check('version', vim.fn.has 'nvim-0.12' == 1)
check('native DiffTool command', vim.fn.exists ':DiffTool' == 2)
check('native Undotree command', vim.fn.exists ':Undotree' == 2)
check('undo keymap', vim.fn.maparg('<leader>u', 'n') ~= '')
check('comment keymap', vim.fn.maparg('<leader>cc', 'n') ~= '')
check('LSP completion keymap', vim.fn.maparg('<C-Space>', 'i') ~= '')
check('Telescope installed', type(require('telescope').setup) == 'function')
check('GitSigns installed', type(require('gitsigns').setup) == 'function')
check('Harpoon installed', type(require('harpoon').setup) == 'function')
check('ToggleTerm command', vim.fn.exists ':ToggleTerm' == 2)
print 'Neovim 0.12 native-first smoke tests passed'
