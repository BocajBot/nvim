return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require 'lualine'

    -- Colors
    local colors = {
      bg = '#202328',
      fg = '#bbc2cf',
      yellow = '#ECBE7B',
      cyan = '#008080',
      darkblue = '#081633',
      green = '#98be65',
      orange = '#FF8800',
      violet = '#a9a1e1',
      magenta = '#c678dd',
      blue = '#51afef',
      red = '#ec5f67',
    }

    -- Conditions
    local function buffer_not_empty()
      return vim.fn.empty(vim.fn.expand '%:t') ~= 1
    end

    local function hide_in_width()
      return vim.fn.winwidth(0) > 80
    end

    local function check_git_workspace()
      local filepath = vim.fn.expand '%:p:h'
      local gitdir = vim.fn.finddir('.git', filepath .. ';')
      return gitdir and #gitdir > 0 and #gitdir < #filepath
    end

    -- Config
    local config = {
      options = {
        component_separators = '',
        section_separators = '',
        theme = {
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- Insert Components
    local function ins(section, component)
      table.insert(config.sections[section], component)
    end

    -- Insert Components
    ins('lualine_c', {
      function()
        return '▊'
      end,
      color = { fg = colors.blue },
      padding = { left = 0, right = 1 },
    })
    ins('lualine_c', {
      function()
        return ''
      end,
      color = function()
        -- auto change color according to neovims mode
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
      end,
      padding = { right = 1 },
    }) -- mode component
    ins('lualine_c', { 'filesize', cond = buffer_not_empty })
    ins('lualine_c', { 'filename', cond = buffer_not_empty, color = { fg = colors.magenta, gui = 'bold' } })
    ins('lualine_c', { 'location' })
    ins('lualine_c', { 'progress', color = { fg = colors.fg, gui = 'bold' } })
    ins('lualine_c', {
      function()
        return '%='
      end,
    }) -- mid section
    ins('lualine_c', {
      function()
        local msg = 'No Active Lsp'
        -- Fix deprecated functions
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_clients()
        --
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      icon = ' LSP:',
      color = { fg = '#ffffff', gui = 'bold' },
    }) -- LSP server name

    -- Add components right section
    ins('lualine_x', { 'o:encoding', fmt = string.upper, cond = hide_in_width, color = { fg = colors.green, gui = 'bold' } })
    ins('lualine_x', { 'fileformat', fmt = string.upper, icons_enabled = false, color = { fg = colors.green, gui = 'bold' } })
    ins('lualine_x', { 'branch', icon = '', color = { fg = colors.violet, gui = 'bold' }, cond = check_git_workspace })
    ins('lualine_x', {
      'diff',
      symbols = { added = ' ', modified = '', removed = ' ' },
      diff_color = { added = { fg = colors.green }, modified = { fg = colors.orange }, removed = { fg = colors.red } },
      cond = hide_in_width,
    })
    ins('lualine_x', {
      function()
        return '▊'
      end,
      color = { fg = colors.blue },
      padding = { left = 1 },
    })

    lualine.setup(config)
  end,
}
