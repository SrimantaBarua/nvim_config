-- My custom color scheme(s). Note that this only works for terminals with 'termguicolors' set.
-- Obviously, I also assume that this is only going to be used with neovim.

-- local M = {}

local nvim = require('barua.nvim')

-- Set up ease-of-use stuff
local highlight = { _mt = {} }

-- This function sets a new highlight, and also creates an entry for easy reference. `value` is
-- expected to be a table with the keys -
-- {
--   fg:    "#rrggbb",
--   bg:    "#rrggbb",
--   sp:    "#rrggbb",
--   attrs: { .. values from `attr-list` },
-- }
highlight._mt.__newindex = function (table, key, value)
  -- Translate to vim terms
  local fg = value.fg or "NONE"
  local bg = value.bg or "NONE"
  local sp = value.sp or "NONE"
  local attr_list = value.attrs or {}
  local attrs = ""
  local first = true
  for _, attr in ipairs(attr_list) do
    if first then
      attrs = attr
    else
      attrs = attrs .. "," .. attr
    end
    first = false
  end
  if attrs == "" then
    attrs = "NONE"
  end
  -- Build up and run a vim command to set a highlight
  local command = "hi " .. key .. " guifg=" .. fg .. " guibg=" .. bg .. " guisp=" .. sp .. " gui=" .. attrs
  nvim.command(command)
  -- Store in the map so it can be referenced
  rawset(table, key, value)
end

setmetatable(highlight, highlight._mt)

-- Set a colors and attributes for a highlighting group.
-- local function highlight(group, guifg, guibg, guisp, attrs)
  -- Build up a vim command to set a highlight with the components which are non-nil
  -- local command = "highlight " .. group
  -- if guifg then command = command .. " guifg=" .. guifg else command = command .. " guifg=NONE" end
  -- if guibg then command = command .. " guibg=" .. guibg else command = command .. " guibg=NONE" end
  -- if guisp then command = command .. " guisp=" .. guisp else command = command .. " guisp=NONE" end
  -- if attrs then command = command .. " gui=" .. attrs else command = command .. " gui=NONE" end
  -- Run the vim command to set the highlight
  -- nvim.command(command)
-- end

-- Apply the basic terminal colors for the theme
-- local function apply_theme_terminal_colors(theme)
  -- nvim.terminal_color_0 = theme.term0
  -- nvim.terminal_color_1 = theme.term1
  -- nvim.terminal_color_2 = theme.term2
  -- nvim.terminal_color_3 = theme.term3
  -- nvim.terminal_color_4 = theme.term4
  -- nvim.terminal_color_5 = theme.term5
  -- nvim.terminal_color_6 = theme.term6
  -- nvim.terminal_color_7 = theme.term7
  -- nvim.terminal_color_8 = theme.term8
  -- nvim.terminal_color_9 = theme.term9
  -- nvim.terminal_color_10 = theme.term10
  -- nvim.terminal_color_11 = theme.term11
  -- nvim.terminal_color_12 = theme.term12
  -- nvim.terminal_color_13 = theme.term13
  -- nvim.terminal_color_14 = theme.term14
  -- nvim.terminal_color_15 = theme.term15
  -- nvim.terminal_color_background = theme.bg
  -- nvim.terminal_color_foreground = theme.fg
-- end

-- Apply colors for the theme "theme"
-- local function apply_theme(theme)
  -- apply_theme_terminal_colors(theme)
--
  -- highlight("Normal",          theme.fg,         theme.bg,       nil,            nil        )
  -- highlight("Bold",            nil,              nil,            nil,            "bold"     )
  -- highlight("Italic",          nil,              nil,            nil,            "italic"   )
  -- highlight("Underlined",      nil,              nil,            nil,            "underline")
--
  -- -- Buitin highlight groups
  -- highlight("ColorColumn", nil, theme.line)  -- used for the columns set with 'colorcolumn'
  -- -- highlight("Conceal")  --  placeholder characters substituted for concealed text (see 'conceallevel')
  -- -- highlight("Cursor")  --  character under the cursor
  -- -- highlight("lCursor")  --  the character under the cursor when |language-mapping| is used (see 'guicursor')
  -- -- highlight("CursorIM")  --  like Cursor, but used when in IME mode |CursorIM|
  -- highlight("CursorColumn", nil, theme.line)  -- Screen-column at the cursor, when 'cursorcolumn' is set.
  -- highlight("CursorLine", nil, theme.line)  -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
  -- highlight("Directory", theme.fg_idle)  -- directory names (and other special names in listings)
  -- highlight("DiffAdd", theme.term2, theme.panel)  -- diff mode: Added line |diff.txt|
  -- highlight("DiffChange", theme.term4, theme.panel)  -- diff mode: Changed line |diff.txt|
  -- highlight("DiffDelete", theme.term9, theme.panel)  -- diff mode: Deleted line |diff.txt|
  -- highlight("DiffText", theme.fg)  -- diff mode: Changed text within a changed line |diff.txt|
  -- -- highlight("EndOfBuffer")  --  filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
  -- -- highlight("TermCursor")  --  cursor in a focused terminal
  -- -- highlight("TermCursorNC")  --  cursor in an unfocused terminal
  -- highlight("ErrorMsg", theme.fg, theme["error"])  -- error messages on the command line
  -- highlight("VertSplit", theme.bg)  -- the column separating vertically split windows
  -- highlight("Folded", theme.fg_idle, theme.panel)  -- line used for closed folds
  -- highlight("FoldColumn", nil, theme.panel)  -- 'foldcolumn'
  -- highlight("SignColumn", nil, theme.background)  -- column where |signs| are displayed
  -- -- highlight("IncSearch")  --  'incsearch' highlighting; also used for the text replaced with ":s///c"
  -- -- highlight("Substitute")  --  |:substitute| replacement text highlighting
  -- highlight("LineNr", theme.guide)  -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
  -- highlight("CursorLineNr", theme.accent)  -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
  -- -- highlight("MatchParen")  --  The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
  -- highlight("ModeMsg", theme.term2)  -- 'showmode' message (e.g., "-- INSERT --")
  -- -- highlight("MsgArea")  --    Area for messages and cmdline
  -- -- highlight("MsgSeparator")  --  Separator for scrolled messages, `msgsep` flag of 'display'
  -- highlight("MoreMsg", theme.term2)  -- |more-prompt|
  -- highlight("NonText", theme.guide)  -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
  -- -- highlight("Normal")  --    normal text
  -- -- highlight("NormalFloat")  --  Normal text in floating windows.
  -- -- highlight("NormalNC")  --  normal text in non-current windows
  -- highlight("Pmenu", theme.fg, theme.selection)  -- Popup menu: normal item.
  -- highlight("PmenuSel", theme.fg, theme.term4)  -- Popup menu: selected item.
  -- -- highlight("PmenuSbar")  --  Popup menu: scrollbar.
  -- -- highlight("PmenuThumb")  --  Popup menu: Thumb of the scrollbar.
  -- -- highlight("Question")  --  |hit-enter| prompt and yes/no questions
  -- -- highlight("QuickFixLine")  --  Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
  -- highlight("Search", theme.bg, theme.constant)  -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
  -- highlight("SpecialKey", theme.selection)  -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
  -- highlight("SpellBad", nil, nil, theme["error"], "undercurl")  -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
  -- highlight("SpellCap", nil, nil, theme.tag, "undercurl")  -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
  -- -- highlight("SpellLocal")  --  Word that is recognized by the spellchecker as one that is used in another region. |spell|  Combined with the highlighting used otherwise.
  -- -- highlight("SpellRare")  --  Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
  -- highlight("StatusLine", theme.fg, theme.panel)  -- status line of current window
  -- highlight("StatusLineNC", theme.fg_idle, theme.panel)  -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
  -- highlight("TabLine", theme.fg, theme.panel)  -- tab pages line, not active tab page label
  -- -- highlight("TabLineFill")  --  tab pages line, where there are no labels
  -- -- highlight("TabLineSel")  --  tab pages line, active tab page label
  -- highlight("Title", theme.keyword)  -- titles for output from ":set all", ":autocmd" etc.
  -- highlight("Visual", nil, theme.selection)  -- Visual mode selection
  -- -- highlight("VisualNOS")  --  Visual mode selection when vim is "Not Owning the Selection".
  -- highlight("WarningMsg", theme.term11)  -- warning messages
  -- -- highlight("Whitespace")  --  "nbsp", "space", "tab" and "trail" in 'listchars'
  -- -- highlight("WildMenu")  --  current match in 'wildmenu' completion
--
  -- -- Standard syntax elements
  -- highlight("Comment", theme.comment)  -- Any comment
  -- highlight("Constant", theme.constant)  -- Any constant
  -- highlight("String", theme.string)  -- String literal
  -- -- highlight("Character", theme.string)  -- Character literal
  -- -- highlight("Number", theme.constant)  -- Number constant
  -- --highlight("Boolean")  -- Boolean constant
  -- --highlight("Float")  -- Floating point constant
  -- highlight("Function", theme["function"])  -- Function/method name
  -- highlight("Identifier", theme.tag)  -- Any variable name
  -- highlight("Statement", theme.keyword)  -- Any statement
  -- --highlight("Conditional")  -- if/then/else/endif/switch
  -- --highlight("Repeat")  -- Loops
  -- --highlight("Label")  -- case/default/goto
  -- highlight("Operator", theme.operator)  -- sizeof/+/*/-
  -- --highlight("Keyword")  -- Any other keyword
  -- --highlight("Exception")  -- try/catch/throw
  -- highlight("PreProc", theme.special)  -- generic Preprocessor
  -- --highlight("Include")  -- preprocessor #include
  -- --highlight("Define")  -- preprocessor #define
  -- --highlight("Macro")  -- same as Define
  -- --highlight("PreCondit")  -- preprocessor #if, #else, #endif, etc.
  -- highlight("Type", theme.tag)  -- int, long, char, etc.
  -- --highlight("StorageClass")  -- static, register, volatile, etc.
  -- highlight("Structure", theme.special)  -- struct, union, enum, etc.
  -- --highlight("Typedef")  -- A typedef
  -- highlight("Special", theme.speial)  -- any special symbol
  -- --highlight("SpecialChar")  -- special character in a constant
  -- --highlight("Tag")  -- you can use CTRL-] on this
  -- --highlight("Delimiter")  -- character that needs attention
  -- --highlight("SpecialComment")  -- special things inside a comment
  -- --highlight("Debug")  -- debugging statements
  -- --highlight("Ignore")  -- left blank, hidden  |hl-Ignore|
  -- highlight("Error", theme.fg, theme["error"])  -- any erroneous construct
  -- highlight("Todo", theme.markup)  -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX
-- end

-- " Conceal, Cursor, CursorIM
-- exe "hi! CursorColumn"  .s:fg_none        .s:bg_line        .s:fmt_none
-- exe "hi! CursorLine"    .s:fg_none        .s:bg_line        .s:fmt_none
-- exe "hi! CursorLineNr"  .s:fg_accent      .s:bg_line        .s:fmt_none
-- exe "hi! LineNr"        .s:fg_guide       .s:bg_none        .s:fmt_none
--
-- exe "hi! Directory"     .s:fg_fg_idle     .s:bg_none        .s:fmt_none
-- exe "hi! DiffAdd"       .s:fg_string      .s:bg_panel       .s:fmt_none
-- exe "hi! DiffChange"    .s:fg_tag         .s:bg_panel       .s:fmt_none
-- exe "hi! DiffText"      .s:fg_fg          .s:bg_panel       .s:fmt_none
-- exe "hi! ErrorMsg"      .s:fg_fg          .s:bg_error       .s:fmt_stnd
-- exe "hi! VertSplit"     .s:fg_bg          .s:bg_none        .s:fmt_none
-- exe "hi! Folded"        .s:fg_fg_idle     .s:bg_panel       .s:fmt_none
-- exe "hi! FoldColumn"    .s:fg_none        .s:bg_panel       .s:fmt_none
-- exe "hi! SignColumn"    .s:fg_none        .s:bg_panel       .s:fmt_none
-- "   Incsearch"
--
-- exe "hi! MatchParen"    .s:fg_fg          .s:bg_bg          .s:fmt_undr
-- exe "hi! ModeMsg"       .s:fg_string      .s:bg_none        .s:fmt_none
-- exe "hi! MoreMsg"       .s:fg_string      .s:bg_none        .s:fmt_none
-- exe "hi! NonText"       .s:fg_guide       .s:bg_none        .s:fmt_none
-- exe "hi! Pmenu"         .s:fg_fg          .s:bg_selection   .s:fmt_none
-- exe "hi! PmenuSel"      .s:fg_fg          .s:bg_selection   .s:fmt_revr
-- "   PmenuSbar"
-- "   PmenuThumb"
-- exe "hi! Question"      .s:fg_string      .s:bg_none        .s:fmt_none
-- exe "hi! Search"        .s:fg_bg          .s:bg_constant    .s:fmt_none
-- exe "hi! SpecialKey"    .s:fg_selection   .s:bg_none        .s:fmt_none
-- exe "hi! SpellCap"      .s:fg_tag         .s:bg_none        .s:fmt_undr
-- exe "hi! SpellLocal"    .s:fg_keyword     .s:bg_none        .s:fmt_undr
-- exe "hi! SpellBad"      .s:fg_error       .s:bg_none        .s:fmt_undr
-- exe "hi! SpellRare"     .s:fg_regexp      .s:bg_none        .s:fmt_undr
-- exe "hi! StatusLine"    .s:fg_fg          .s:bg_panel       .s:fmt_none
-- exe "hi! StatusLineNC"  .s:fg_fg_idle     .s:bg_panel       .s:fmt_none
-- exe "hi! WildMenu"      .s:fg_bg          .s:bg_markup      .s:fmt_none
-- exe "hi! TabLine"       .s:fg_fg          .s:bg_panel       .s:fmt_revr
-- "   TabLineFill"
-- "   TabLineSel"
-- exe "hi! Title"         .s:fg_keyword     .s:bg_none        .s:fmt_none
-- exe "hi! Visual"        .s:fg_none        .s:bg_selection   .s:fmt_none
-- "   VisualNos"
-- exe "hi! WarningMsg"    .s:fg_error       .s:bg_none        .s:fmt_none
--
-- " TODO LongLineWarning to use variables instead of hardcoding
-- hi LongLineWarning  guifg=NONE        guibg=#371F1C     gui=underline ctermfg=NONE        ctermbg=NONE        cterm=underline
-- "   WildMenu"
--
-- "}}}
--
-- " Generic Syntax Highlighting: (see :help group-name)"{{{
-- " ----------------------------------------------------------------------------
-- exe "hi! Comment"         .s:fg_comment   .s:bg_none        .s:fmt_none
--
-- exe "hi! Constant"        .s:fg_constant  .s:bg_none        .s:fmt_none
-- exe "hi! String"          .s:fg_string    .s:bg_none        .s:fmt_none
-- "   Character"
-- "   Number"
-- "   Boolean"
-- "   Float"
--
-- exe "hi! Identifier"      .s:fg_tag       .s:bg_none        .s:fmt_none
-- exe "hi! Function"        .s:fg_function  .s:bg_none        .s:fmt_none
--
-- exe "hi! Statement"       .s:fg_keyword   .s:bg_none        .s:fmt_none
-- "   Conditional"
-- "   Repeat"
-- "   Label"
-- exe "hi! Operator"        .s:fg_operator  .s:bg_none        .s:fmt_none
-- "   Keyword"
-- "   Exception"
--
-- exe "hi! PreProc"         .s:fg_special   .s:bg_none        .s:fmt_none
-- "   Include"
-- "   Define"
-- "   Macro"
-- "   PreCondit"
--
-- exe "hi! Type"            .s:fg_tag       .s:bg_none        .s:fmt_none
-- "   StorageClass"
-- exe "hi! Structure"       .s:fg_special   .s:bg_none        .s:fmt_none
-- "   Typedef"
--
-- exe "hi! Special"         .s:fg_special   .s:bg_none        .s:fmt_none
-- "   SpecialChar"
-- "   Tag"
-- "   Delimiter"
-- "   SpecialComment"
-- "   Debug"
-- "
-- exe "hi! Underlined"      .s:fg_tag       .s:bg_none        .s:fmt_undr
--
-- exe "hi! Ignore"          .s:fg_none      .s:bg_none        .s:fmt_none
--
-- exe "hi! Error"           .s:fg_fg        .s:bg_error       .s:fmt_none
--
-- exe "hi! Todo"            .s:fg_markup    .s:bg_none        .s:fmt_none
--
-- " Quickfix window highlighting
-- exe "hi! qfLineNr"        .s:fg_keyword   .s:bg_none        .s:fmt_none
-- "   qfFileName"
-- "   qfLineNr"
-- "   qfError"
--
-- exe "hi! Conceal"         .s:fg_guide     .s:bg_none        .s:fmt_none
-- exe "hi! CursorLineConceal" .s:fg_guide   .s:bg_line        .s:fmt_none
--
--
-- " Terminal
-- " ---------
-- if has("nvim")
--   let g:terminal_color_0 =  s:palette.bg[s:style]
--   let g:terminal_color_1 =  s:palette.markup[s:style]
--   let g:terminal_color_2 =  s:palette.string[s:style]
--   let g:terminal_color_3 =  s:palette.accent[s:style]
--   let g:terminal_color_4 =  s:palette.tag[s:style]
--   let g:terminal_color_5 =  s:palette.constant[s:style]
--   let g:terminal_color_6 =  s:palette.regexp[s:style]
--   let g:terminal_color_7 =  "#FFFFFF"
--   let g:terminal_color_8 =  s:palette.fg_idle[s:style]
--   let g:terminal_color_9 =  s:palette.error[s:style]
--   let g:terminal_color_10 = s:palette.string[s:style]
--   let g:terminal_color_11 = s:palette.accent[s:style]
--   let g:terminal_color_12 = s:palette.tag[s:style]
--   let g:terminal_color_13 = s:palette.constant[s:style]
--   let g:terminal_color_14 = s:palette.regexp[s:style]
--   let g:terminal_color_15 = s:palette.comment[s:style]
--   let g:terminal_color_background = g:terminal_color_0
--   let g:terminal_color_foreground = s:palette.fg[s:style]
-- else
--   let g:terminal_ansi_colors =  [s:palette.bg[s:style],      s:palette.markup[s:style]]
--   let g:terminal_ansi_colors += [s:palette.string[s:style],  s:palette.accent[s:style]]
--   let g:terminal_ansi_colors += [s:palette.tag[s:style],     s:palette.constant[s:style]]
--   let g:terminal_ansi_colors += [s:palette.regexp[s:style],  "#FFFFFF"]
--   let g:terminal_ansi_colors += [s:palette.fg_idle[s:style], s:palette.error[s:style]]
--   let g:terminal_ansi_colors += [s:palette.string[s:style],  s:palette.accent[s:style]]
--   let g:terminal_ansi_colors += [s:palette.tag[s:style],     s:palette.constant[s:style]]
--   let g:terminal_ansi_colors += [s:palette.regexp[s:style],  s:palette.comment[s:style]]
-- endif
--
--
-- " NerdTree
-- " ---------
-- exe "hi! NERDTreeOpenable"          .s:fg_fg_idle     .s:bg_none        .s:fmt_none
-- exe "hi! NERDTreeClosable"          .s:fg_accent      .s:bg_none        .s:fmt_none
-- " exe "hi! NERDTreeBookmarksHeader"   .s:fg_pink        .s:bg_none        .s:fmt_none
-- " exe "hi! NERDTreeBookmarksLeader"   .s:fg_bg          .s:bg_none        .s:fmt_none
-- " exe "hi! NERDTreeBookmarkName"      .s:fg_keyword     .s:bg_none        .s:fmt_none
-- " exe "hi! NERDTreeCWD"               .s:fg_pink        .s:bg_none        .s:fmt_none
-- exe "hi! NERDTreeUp"                .s:fg_fg_idle    .s:bg_none        .s:fmt_none
-- exe "hi! NERDTreeDir"               .s:fg_function   .s:bg_none        .s:fmt_none
-- exe "hi! NERDTreeFile"              .s:fg_none       .s:bg_none        .s:fmt_none
-- exe "hi! NERDTreeDirSlash"          .s:fg_accent     .s:bg_none        .s:fmt_none
--
--
-- " GitGutter
-- " ---------
-- exe "hi! GitGutterAdd"          .s:fg_string     .s:bg_none        .s:fmt_none
-- exe "hi! GitGutterChange"       .s:fg_tag        .s:bg_none        .s:fmt_none
-- exe "hi! GitGutterDelete"       .s:fg_markup     .s:bg_none        .s:fmt_none
-- exe "hi! GitGutterChangeDelete" .s:fg_function   .s:bg_none        .s:fmt_none
--
-- "}}}

-- Reset everything!
nvim.command("syntax enable")
nvim.command("highlight clear")

-- Collection of colors to build out my theme
local color = {}

-- Basic terminal colors
color.black          = "#0f1419" -- term 0
color.red            = "#f07178" -- term 1
color.green          = "#b8cc52" -- term 2
color.yellow         = "#ffee99" -- term 3
color.blue           = "#36a3d9" -- term 4
color.magenta        = "#aa3198" -- term 5
color.cyan           = "#95e6cb" -- term 6
color.light_gray     = "#a5a2a2" -- term 7
color.dark_gray      = "#3e4b59" -- term 8
color.bright_red     = "#ff3333" -- term 9
color.bright_green   = "#b0ec32" -- term 10
color.bright_yellow  = "#f2d018" -- term 11
color.bright_blue    = "#59c3ff" -- term 12
color.bright_magenta = "#e774da" -- term 13
color.bright_cyan    = "#a5f6eb" -- term 14
color.white          = "#ffffff" -- term 15

-- Additional colors
color.gray_0 = "#233240"
color.gray_1 = "#222222"

-- UI stuff
color.background      = color.black
color.foreground      = "#e6e1cf"
color.foreground_idle = color.dark_gray

-- Language-specific stuff
color.comment         = "#5c6773"
color.func_call       = "#ffb454"
color.func_def        = "#ffb454"
color.operator        = "#e7c547"
color.keyword         = "#ff7733"

-- Apply the basic terminal colors for the theme
nvim.terminal_color_0          = color.black
nvim.terminal_color_1          = color.red
nvim.terminal_color_2          = color.green
nvim.terminal_color_3          = color.yellow
nvim.terminal_color_4          = color.blue
nvim.terminal_color_5          = color.magenta
nvim.terminal_color_6          = color.cyan
nvim.terminal_color_7          = color.light_gray
nvim.terminal_color_8          = color.dark_gray
nvim.terminal_color_9          = color.bright_red
nvim.terminal_color_10         = color.bright_green
nvim.terminal_color_11         = color.bright_yellow
nvim.terminal_color_12         = color.bright_blue
nvim.terminal_color_13         = color.bright_magenta
nvim.terminal_color_14         = color.bright_cyan
nvim.terminal_color_15         = color.white
nvim.terminal_color_background = color.background
nvim.terminal_color_foreground = color.foreground

-- Apply basic vim highlights
highlight.Normal       = { fg = color.foreground, bg = color.background }
highlight.Bold         = { attrs = { "bold" } }
highlight.Italic       = { attrs = { "italic" } }
highlight.Underlined   = { attrs = { "underline" } }
highlight.ColorColumn  = { bg = color.gray_0 }
highlight.CursorColumn = highlight.ColorColumn
highlight.CursorLine   = highlight.CursorColumn
highlight.ErrorMsg     = { fg = color.foreground, bg = color.error }
highlight.VertSplit    = { fg = highlight.ColorColumn.bg }
highlight.Visual       = { bg = color.dark_gray }

-- highlight("Normal", color.foreground, color.background)

-- Set up logical colors for each theme (maybe using terminal colors)
-- themes["black"]["bg"]        = themes["black"]["term0"]  -- Normal background color
-- themes["black"]["fg"]        = "#E6E1CF"                  -- Normal foreground color
-- themes["black"]["fg_idle"]   = themes["black"]["term8"]  -- Foreground color for idle pane
-- themes["black"]["accent"]    = themes["black"]["term3"]
-- themes["black"]["comment"]   = "#5C6773"
-- themes["black"]["constant"]  = themes["black"]["term5"]
-- themes["black"]["string"]    = themes["black"]["term2"]
-- themes["black"]["regexp"]    = themes["black"]["term6"]  -- Regular expressions
-- themes["black"]["func_call"] = "#FFB454"                  -- Function calls
-- themes["black"]["func_defn"] = "#FFB454"                  -- Function definitions
-- themes["black"]["operator"]  = "#E7C547"
-- themes["black"]["keyword"]   = "#FF7733"
-- themes["black"]["error"]     = themes["black"]["term9"]
-- themes["black"]["selection"] = "#253340"                  -- Text selection
-- themes["black"]["guide"]     = "#2D3640"                  -- Stuff like line numbers in the gutter
-- themes["black"]["line"]      = "#22272B"                  -- Stuff like cursorline/cursorcolumn
-- themes["black"]["tag"]       = themes["black"]["term4"]  -- Variable names, types, and stuff?
-- themes["black"]["panel"]     = "#14191F"                  -- Stuff like the background of the status bar or folds
-- themes["black"]["special"]   = "#E6B673"                  -- Stuff like preprocessor things
-- themes["black"]["markup"]    = themes["black"]["term1"]

-- let s:palette.bg        = {'dark': "#0F1419",  'light': "#FAFAFA",  'mirage': "#212733"}
-- let s:palette.comment   = {'dark': "#5C6773",  'light': "#ABB0B6",  'mirage': "#5C6773"}
-- let s:palette.markup    = {'dark': "#F07178",  'light': "#F07178",  'mirage': "#F07178"}
-- let s:palette.constant  = {'dark': "#FFEE99",  'light': "#A37ACC",  'mirage': "#D4BFFF"}
-- let s:palette.operator  = {'dark': "#E7C547",  'light': "#E7C547",  'mirage': "#80D4FF"}
-- let s:palette.tag       = {'dark': "#36A3D9",  'light': "#36A3D9",  'mirage': "#5CCFE6"}
-- let s:palette.regexp    = {'dark': "#95E6CB",  'light': "#4CBF99",  'mirage': "#95E6CB"}
-- let s:palette.string    = {'dark': "#B8CC52",  'light': "#86B300",  'mirage': "#BBE67E"}
-- let s:palette.function  = {'dark': "#FFB454",  'light': "#F29718",  'mirage': "#FFD57F"}
-- let s:palette.special   = {'dark': "#E6B673",  'light': "#E6B673",  'mirage': "#FFC44C"}
-- let s:palette.keyword   = {'dark': "#FF7733",  'light': "#FF7733",  'mirage': "#FFAE57"}
-- let s:palette.error     = {'dark': "#FF3333",  'light': "#FF3333",  'mirage': "#FF3333"}
-- let s:palette.accent    = {'dark': "#F29718",  'light': "#FF6A00",  'mirage': "#FFCC66"}
-- let s:palette.panel     = {'dark': "#14191F",  'light': "#FFFFFF",  'mirage': "#272D38"}
-- let s:palette.guide     = {'dark': "#2D3640",  'light': "#D9D8D7",  'mirage': "#3D4751"}
-- let s:palette.line      = {'dark': "#151A1E",  'light': "#F3F3F3",  'mirage': "#242B38"}
-- let s:palette.selection = {'dark': "#253340",  'light': "#F0EEE4",  'mirage': "#343F4C"}
-- let s:palette.fg        = {'dark': "#E6E1CF",  'light': "#5C6773",  'mirage': "#D9D7CE"}
-- let s:palette.fg_idle   = {'dark': "#3E4B59",  'light': "#828C99",  'mirage': "#607080"}

-- M.set_theme = function(theme_name)
  -- apply_theme(themes[theme_name])
-- end

-- M.set_theme("black")

-- return M
