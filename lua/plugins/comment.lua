return {
    "numToStr/Comment.nvim",
    config = function()
        local comment = require('Comment')
        comment.setup({
            toggler = {
                line = "<C-/>",
                block = "gbc",
            },
            opleader = {
                line = "<C-/>",
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
