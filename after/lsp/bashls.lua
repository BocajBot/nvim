local util = require 'lspconfig.util'

return {
  filetypes = { 'sh', 'bash', 'zsh' },

  -- Force activation for dotfiles outside a repo by always providing a root.
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(util.find_git_ancestor(fname) or vim.fn.expand '~')
  end,
}
