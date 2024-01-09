return {
    "github/copilot.vim",
    config = function()
        local function SuggestOneWord()
            local bar = vim.fn["copilot#TextQueuedForInsertion"]()
            return vim.fn.split(bar, [[[ .]\zs]])[1]
        end

        local map = vim.keymap.set
        map("i", "<C-Right>", SuggestOneWord, { expr = true, remap = true })
    end,
}
