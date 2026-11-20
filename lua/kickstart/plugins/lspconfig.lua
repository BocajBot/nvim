-- Native Neovim LSP client with nvim-lspconfig presets and Mason provisioning.
-- No nvim-cmp, fidget, or custom completion capabilities required.
return function()
  require('mason').setup()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, opts)
            vim.keymap.set('n', keys, func, vim.tbl_extend('force', { buf = event.buf, desc = 'LSP: ' .. desc }, opts or {}))
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          require('keymaps').lsp(map, client)

          -- Native completion replaces nvim-cmp. Rust stays explicit/manual to
          -- avoid the didChange and completion latency that this config guarded.
          if client and client:supports_method('textDocument/completion', event.buf) then
            local is_rust = client.name == 'rust_analyzer' or client.name == 'rust-analyzer'
            vim.lsp.completion.enable(true, client.id, event.buf, {
              autotrigger = not is_rust,
            })
          end

          if client and client.server_capabilities.documentHighlightProvider and client.name ~= 'rust-analyzer' and client.name ~= 'rust_analyzer' then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end
        end,
      })

      vim.lsp.config('*', {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
      })

      local servers = {
        lua_ls = {
          settings = {
            Lua = { completion = { callSnippet = 'Replace' } },
          },
        },

        bashls = {
          filetypes = { 'sh', 'bash', 'zsh' },
          settings = {
            bashIde = {
              -- optional but useful: include zsh-ish names for workspace indexing
              globPattern = '*@(.sh|.inc|.bash|.command|.zsh|zshrc|.zshrc|zsh_*|.zsh_*)',
            },
          },
        },
      }

      for server_name, server in pairs(servers) do
        vim.lsp.config(server_name, server)
      end

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'rust_analyzer',
        'pylsp',
        'bashls',
        'html',
        'clangd',
        'jsonls',
        'yamlls',
        'quick-lint-js',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        automatic_enable = {
          exclude = { 'rust_analyzer' },
        },
      }
end
