-- Preserve the most-used Comment.nvim/ts-comments mappings using core 'gc'.
-- Native Neovim already supplies gcc, gc{motion}, and visual gc.
local M = {}

local function comment_parts()
  local lhs, rhs = vim.bo.commentstring:match('^(.-)%%s(.-)$')
  if lhs then
    return lhs, rhs
  end
  vim.notify('No commentstring for this buffer', vim.log.levels.WARN)
end

local function insert_comment(offset)
  local lhs, rhs = comment_parts()
  if not lhs then return end
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local indent = vim.api.nvim_get_current_line():match('^%s*') or ''
  local at = offset == 1 and row or row - 1
  vim.api.nvim_buf_set_lines(0, at, at, false, { indent .. lhs .. rhs })
  vim.api.nvim_win_set_cursor(0, { at + 1, #indent + #lhs })
  vim.cmd.startinsert()
end

local function append_comment()
  local lhs, rhs = comment_parts()
  if not lhs then return end
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local current = vim.api.nvim_get_current_line()
  local spacer = current:match('^%s*$') and '' or ' '
  vim.api.nvim_set_current_line(current .. spacer .. lhs .. rhs)
  vim.api.nvim_win_set_cursor(0, { row, #current + #spacer + #lhs })
  vim.cmd.startinsert()
end

function M.setup()
  vim.keymap.set('n', '<leader>cc', 'gcc', { remap = true, desc = 'Toggle current line comment' })
  vim.keymap.set('x', '<leader>cc', 'gc', { remap = true, desc = 'Toggle selected lines' })
  for _, lhs in ipairs { '<C-_>', '<C-/>' } do
    vim.keymap.set('n', lhs, 'gcc', { remap = true, desc = 'Toggle current line comment' })
    vim.keymap.set('x', lhs, 'gc', { remap = true, desc = 'Toggle selection comment' })
  end
  vim.keymap.set('n', 'gco', function() insert_comment(1) end, { desc = 'Insert comment below' })
  vim.keymap.set('n', 'gcO', function() insert_comment(-1) end, { desc = 'Insert comment above' })
  vim.keymap.set('n', 'gcA', append_comment, { desc = 'Insert end-of-line comment' })
end

return M
