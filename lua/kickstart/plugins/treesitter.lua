return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,

    opts = {
      install_dir = vim.fn.stdpath 'data' .. '/site',

      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'javascript',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'vim',
        'vimdoc',
      },
    },

    config = function(_, opts)
      require('nvim-treesitter').setup(opts)

      -- main branch ignores ensure_installed in setup(); building parsers needs tree-sitter-cli.
      if vim.fn.executable 'tree-sitter' == 1 then
        require('nvim-treesitter').install(opts.ensure_installed)
      end

      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          -- Start only with highlight queries; otherwise keep regex syntax instead of blanking it.
          local lang = vim.treesitter.language.get_lang(args.match) or args.match
          local ok, query = pcall(vim.treesitter.query.get, lang, 'highlights')
          if ok and query then
            pcall(vim.treesitter.start, args.buf, lang)
          end
        end,
      })
    end,
  },
}
