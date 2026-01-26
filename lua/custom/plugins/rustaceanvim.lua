return {
  'mrcjkb/rustaceanvim',
  version = '^4',
  ft = { 'rust' },
  init = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
    if ok then
      capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())
    end

    local rustfmt = vim.fn.exepath('rustfmt')
    local server = {
      capabilities = capabilities,
      settings = function(_, default_settings)
        if rustfmt ~= '' then
          default_settings['rust-analyzer'] = default_settings['rust-analyzer'] or {}
          default_settings['rust-analyzer'].rustfmt = default_settings['rust-analyzer'].rustfmt or {}
          default_settings['rust-analyzer'].rustfmt.overrideCommand = { rustfmt }
        end
        return default_settings
      end,
    }
    if vim.fn.executable('lspmux') == 1 then
      server.cmd = { 'lspmux', 'client', '--server-path', 'rust-analyzer' }
    end

    vim.g.rustaceanvim = {
      server = server,
    }
  end,
}
