-- Local llama.cpp completion and instruction editing through llama-swap.
-- LLAMA_VIM_FIM_MODEL / LLAMA_VIM_INST_MODEL override defaults; <leader>m / <leader>M pick at runtime.
return {
  'ggml-org/llama.vim',
  init = function()
    local endpoint = (vim.env.LLAMA_VIM_ENDPOINT or 'http://127.0.0.1:9292'):gsub('/+$', '')

    vim.g.llama_config = {
      endpoint_fim = endpoint .. '/infill',
      endpoint_inst = endpoint .. '/v1/chat/completions',
      model_fim = vim.env.LLAMA_VIM_FIM_MODEL or 'Qwen3-Coder-30B-A3B-Instruct-UD-Q4_K_XL',
      model_inst = vim.env.LLAMA_VIM_INST_MODEL or 'Qwen3-Coder-30B-A3B-Instruct-UD-Q4_K_XL',
      api_key = vim.env.LLAMA_VIM_API_KEY or '',

      -- nvim-cmp already provides automatic completion; request FIM manually.
      auto_fim = false,

      -- Avoid nvim-cmp's <C-h>/<C-l> snippet mappings.
      keymap_fim_next = '<leader>lln',
      keymap_fim_prev = '<leader>llp',
    }

    -- Pick a model from llama-swap's /v1/models for the given llama_config key.
    local function pick(key, label)
      vim.system({ 'curl', '-sf', '-m', '5', endpoint .. '/v1/models' }, { text = true }, vim.schedule_wrap(function(res)
        local ok, body = pcall(vim.json.decode, res.stdout or '')
        if res.code ~= 0 or not ok or type(body.data) ~= 'table' then
          return vim.notify('llama: cannot list models at ' .. endpoint, vim.log.levels.ERROR)
        end
        local ids = vim.tbl_map(function(m) return m.id end, body.data)
        table.sort(ids)
        vim.ui.select(ids, { prompt = label .. ' model (now: ' .. vim.g.llama_config[key] .. ')' }, function(id)
          if not id then return end
          local cfg = vim.g.llama_config -- vim.g returns a copy; reassign whole table
          cfg[key] = id
          vim.g.llama_config = cfg
          vim.notify('llama ' .. label .. ' model: ' .. id)
        end)
      end))
    end

    vim.keymap.set('n', '<leader>m', function() pick('model_fim', 'FIM') end, { desc = 'llama: pick FIM model' })
    vim.keymap.set('n', '<leader>M', function() pick('model_inst', 'Instruct') end, { desc = 'llama: pick instruct model' })
  end,
}
