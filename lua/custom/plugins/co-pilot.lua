return {
  'github/copilot.vim',
  config = function()
    vim.keymap.set('i', '<C-Right>', '<Plug>(copilot-accept-word)')
    vim.keymap.set('i', '<C-S-Right>', '<Plug>(copilot-accept-line)')
  end,
}
