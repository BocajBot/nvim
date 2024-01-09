return {
    "mbbill/undotree",
    config = function()
        -- toggle and focus undotree
        vim.keymap.set("n","", ":UndotreeToggle<CR>:UndotreeFocus<CR>")
    end,
}
