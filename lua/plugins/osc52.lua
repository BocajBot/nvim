return {
    'ojroques/nvim-osc52',
    config = function()
        require('osc52').setup()
        local function copy(lines, _)
            require('osc52').copy(table.concat(lines, '\n'))
        end

        local function paste()
            return { vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('') }
        end

        -- Use xsel or pbcopy if available otherwise use osc52
        if vim.fn.executable('xsel') == 1 then
            vim.g.clipboard = {
                name = 'xsel',
                copy = { ['+'] = { 'xsel', '-ib' }, ['*'] = { 'xsel', '-ib' } },
                paste = { ['+'] = { 'xsel', '-ob' }, ['*'] = { 'xsel', '-ob' } },
            }
        elseif vim.fn.executable('pbcopy') == 1 then
            vim.g.clipboard = {
                name = 'pbcopy',
                copy = { ['+'] = { 'pbcopy' }, ['*'] = { 'pbcopy' } },
                paste = { ['+'] = { 'pbpaste' }, ['*'] = { 'pbpaste' } },
            }
        else
            vim.g.clipboard = {
                name = 'osc52',
                copy = { ['+'] = copy, ['*'] = copy },
                paste = { ['+'] = paste, ['*'] = paste },
            }
        end

        -- Now the '+' register will copy to system clipboard using OSC52
        -- vim.keymap.set('n', '<leader>c', '"+y')
        -- vim.keymap.set('n', '<leader>cc', '"+yy')
    end,
}
