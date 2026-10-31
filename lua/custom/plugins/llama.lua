-- Local llama.cpp completion and instruction editing through llama-swap.
-- Set LLAMA_VIM_FIM_MODEL and LLAMA_VIM_INST_MODEL to IDs from /v1/models.
return {
  'ggml-org/llama.vim',
  init = function()
    local endpoint = (vim.env.LLAMA_VIM_ENDPOINT or 'http://127.0.0.1:9292'):gsub('/+$', '')

    vim.g.llama_config = {
      endpoint_fim = endpoint .. '/infill',
      endpoint_inst = endpoint .. '/v1/chat/completions',
      model_fim = vim.env.LLAMA_VIM_FIM_MODEL or '',
      model_inst = vim.env.LLAMA_VIM_INST_MODEL or '',
      api_key = vim.env.LLAMA_VIM_API_KEY or '',

      -- nvim-cmp already provides automatic completion; request FIM manually.
      auto_fim = false,

      -- Avoid nvim-cmp's <C-h>/<C-l> snippet mappings.
      keymap_fim_next = '<leader>lln',
      keymap_fim_prev = '<leader>llp',
    }
  end,
}
