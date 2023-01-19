local builtin = require('telescope.builtin')
local wk = require('which-key')

wk.register({
    ['<leader>f'] = {
        name = 'find',
        b = { builtin.buffers, 'find buffer' },
        f = { builtin.find_files, 'find files' },
        g = { builtin.live_grep, 'live grep' },
        G = { builtin.git_files, 'git files' },
        h = { builtin.help_tags, 'help tags' },
    }
})
