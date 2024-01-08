return {
    "numToStr/Comment.nvim",
    config = function()
        local comment = require('Comment')
        comment.setup({
            toggler = {
                line = "",
                block = "gbc",
            },
            opleader = {
                line = "",
                block = "<M-C-_>",
            },
            mappings = {
                basic = true,
                extra = true,
            },
        })
    end,
    lazy = false,
}
