local dap = require('dap')
local dapui = require('dapui')
local wk = require('which-key')

wk.register({
    ['<leader>d'] = {
        name = 'debug',
        b = { dap.toggle_breakpoint, 'toggle breakpoint' },
        E = { function() dapui.eval(vim.fn.input('Expression > ')) end, 'eval' },
        h = { require('dap.ui.widgets').hover, 'hover' },
        U = { dapui.toggle, 'toggle ui' },
        r = { dap.repl.toggle, 'toggle repl' },
        q = { dap.close, 'close' },
    },
    ['<F5>'] = { dap.continue, 'debug: continue' },
    ['<F8>'] = { dap.step_over, 'debug: step over' },
    ['<F9>'] = { dap.step_into, 'debug: step into' },
    ['<F10>'] = { dap.step_out, 'debug: step out' },
})

vim.keymap.set('v', '<leader>dE', dapui.eval)
