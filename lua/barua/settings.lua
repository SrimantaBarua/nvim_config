local opt = vim.opt

-- Completion
-- opt.pumblend = 10              -- Translucent popup menu
opt.wildmode = "longest:full"  -- Complete the to longest common match

-- This option is used by the "omnifunc" completion stuff
opt.completeopt = "menu,menuone"

-- Mouse
opt.mouse = 'n'                -- Enable mouse support in normal mode

-- Clipboard
opt.clipboard = 'unnamedplus'  -- Use the system clipboard

-- Searching
opt.hlsearch = true            -- Highlight search results
opt.incsearch = true           -- Incrementally search
opt.inccommand = 'split'       -- Show incremental output of replacments etc

-- Indentation
opt.expandtab = true           -- Use spaces by default instead of tabs
opt.shiftwidth = 2             -- Size of an indent = 2
opt.tabstop = 2                -- Number of spaces for tab = 2
opt.softtabstop = 2            -- -
opt.cindent = true             -- C-style indentation
opt.autoindent = true          -- This and next - indent automatically
opt.smartindent = true

-- Line wrap
opt.scrolloff = 2              -- Lines of context
opt.wrap = false               -- Disable line wrap
opt.sidescrolloff = 2          -- Columns of context

-- Line numbers
opt.number = true              -- Enable line numbers
opt.relativenumber = true      -- Enable relative numbers for the other lines

-- Splitting windows
opt.splitbelow = true          -- New windows go below the current one
opt.splitright = true          -- New windows go to the right of the current one

-- Misc. display
opt.termguicolors = true       -- Support truecolor
opt.signcolumn = 'yes'         -- Always enable signcolumn so that stuff doesn't keep moving

-- Misc.
opt.hidden = true              -- Enable background buffers (do not unload invisible buffers)
opt.joinspaces = false         -- No double spaces with join with '.' etc

-- opt.list = true                -- Show some invisible characters
-- opt.cursorline = true          -- Highlight the current cursor line
-- opt.colorcolumn = '100'        -- Have a vertical line on column 100
