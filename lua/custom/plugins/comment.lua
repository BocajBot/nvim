return {
  'numToStr/Comment.nvim',
  keys = {
    { 'gc', mode = { 'n', 'x', 'o' } },
    { 'gb', mode = { 'n', 'x', 'o' } },
    { '<C-_>', mode = { 'n', 'x' } },
  },
  opts = {
    toggler = {
      line = '<C-/>',
      block = 'gbc',
    },
    opleader = {
      line = '<C-/>',
      block = '<M-C-_>',
    },
    mappings = {
      basic = true,
      extra = true,
    },
  },
}
