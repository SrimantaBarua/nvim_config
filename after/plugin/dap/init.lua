local dap = require('dap')
local dapui = require('dapui')

-- References -
-- - https://github.com/ecosse3/nvim/blob/master/lua/plugins/dap.lua

require('nvim-dap-virtual-text').setup {
    enabled = true,
    enabled_commands = true,
    highlight_changed_variables = true,
    highlight_new_as_changed = false,
    show_stop_reason = true,
    commented = false,                     -- prefix virtual text with comment string
    only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
    all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
    filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
    -- Experimental Features:
    virt_text_pos = 'eol',   -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false,      -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,      -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
}


dapui.setup {
    icons = { expanded = "▾", collapsed = "▸" },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
    },
    expand_lines = true,
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 0.25,
            position = "left",
        },
        {
            elements = {
                "repl",
                "console",
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = 'rounded', -- Border style. Can be "single", "double" or "rounded"
        mappings = {
            close = { "q", "<Esc>" },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
    }
}


dap.set_log_level('TRACE')


vim.g.dap_virtual_text = true


vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '🟢', texthl = '', linehl = '', numhl = '' })


dap.adapters.codelldb = {
    type = 'server',
    host = '127.0.0.1',
    port = 13000,
}

dap.configurations.c = {
    {
        name = 'lldb',
        type = 'codelldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        args = {}
    }
}

dap.configurations.cpp = dap.configurations.c
