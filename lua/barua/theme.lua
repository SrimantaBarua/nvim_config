-- My custom color scheme(s). Note that this only works for terminals with 'termguicolors' set.
-- Obviously, I also assume that this is only going to be used with neovim.

-- local M = {}

local nvim = require('barua.nvim')

-- Set up ease-of-use stuff
local hl = { _mt = {} }

-- This function sets a new highlight, and also creates an entry for easy reference. `value` is
-- expected to be a table with the keys -
-- {
--   fg:    "#rrggbb",
--   bg:    "#rrggbb",
--   sp:    "#rrggbb",
--   attrs: { .. values from `attr-list` },
-- }
hl._mt.__newindex = function (table, key, value)
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

setmetatable(hl, hl._mt)

-- Reset everything!
nvim.command("syntax enable")
nvim.command("highlight clear")

-- Color palette
local black      = "#0f1419"
local red_0      = "#f07178"
local red_1      = "#ef2333"
local green_0    = "#b8cc52"
local green_1    = "#b0ec23"
local yellow_0   = "#e7c547"
local yellow_1   = "#f2d018"
local yellow_2   = "#ffee99"
local orange_0   = "#ff7733"
local orange_1   = "#e6b673"
local orange_2   = "#ffb454"
local blue_0     = "#36a3d9"
local blue_1     = "#59c3ff"
local magenta_0  = "#aa3198"
local magenta_1  = "#e774da"
local cyan_0     = "#95e6cb"
local cyan_1     = "#a5f6eb"
local gray_0     = "#14191f"
local gray_1     = "#151a1e"
local gray_2     = "#253340"
local gray_3     = "#2d3640"
local gray_4     = "#3e4b59"
local gray_5     = "#d9d8d7"
local foreground = "#e6e1cf"
local white      = "#ffffff"

-- Apply the basic terminal colors for the theme
nvim.terminal_color_0          = black
nvim.terminal_color_1          = red_0
nvim.terminal_color_2          = green_0
nvim.terminal_color_3          = yellow_0
nvim.terminal_color_4          = blue_0
nvim.terminal_color_5          = magenta_0
nvim.terminal_color_6          = cyan_0
nvim.terminal_color_7          = gray_4
nvim.terminal_color_8          = gray_2
nvim.terminal_color_9          = red_1
nvim.terminal_color_10         = green_1
nvim.terminal_color_11         = yellow_1
nvim.terminal_color_12         = blue_1
nvim.terminal_color_13         = magenta_1
nvim.terminal_color_14         = cyan_1
nvim.terminal_color_15         = white
nvim.terminal_color_background = black
nvim.terminal_color_foreground = foreground

-- Apply basic vim highlights
hl.Normal       = { fg = foreground, bg = black }
hl.Bold         = { attrs = { "bold" } }
hl.Italic       = { attrs = { "italic" } }
hl.Underlined   = { attrs = { "underline" } }
hl.ColorColumn  = { bg = gray_0 }
hl.CursorColumn = hl.ColorColumn
hl.CursorLine   = hl.CursorColumn
hl.DiffAdd      = { fg = green_0, bg = gray_0 }
hl.DiffChange   = { fg = yellow_1, bg = gray_0 }
hl.DiffDelete   = { fg = red_0, bg = gray_0 }
hl.DiffText     = { fg = foreground, bg = gray_0 }
hl.ErrorMsg     = { fg = foreground, bg = red_1 }
hl.VertSplit    = { fg = hl.ColorColumn.bg }
hl.Folded       = { fg = gray_4, bg = gray_1 }
hl.FoldColumn   = { bg = gray_1 }
hl.SignColumn   = { bg = black }
hl.LineNr       = { fg = gray_2 }
hl.CursorLineNr = { fg = orange_2, bg = hl.CursorLine.bg, attrs = { "bold" } }
hl.ModeMsg      = { fg = green_0 }
hl.MoreMsg      = { fg = green_0 }
hl.NonText      = { fg = gray_4 }
hl.Pmenu        = { fg = foreground, bg = gray_2 }
hl.PmenuSel     = { fg = black, bg = cyan_1 }
hl.PmenuSbar    = { bg = gray_1 }
hl.PmenuThumb   = { bg = gray_5 }
hl.Search       = { fg = black, bg = yellow_2 }
hl.SpecialKey   = { fg = gray_4 }
hl.SpellBad     = { sp = red_1, attrs = { "undercurl" } }
hl.SpellCap     = { sp = yellow_2, attrs = { "undercurl" } }
hl.StatusLine   = { fg = foreground, bg = gray_0 }
hl.StatusLineNC = { fg = gray_5, bg = gray_0 }
hl.TabLine      = { fg = foreground, bg = gray_0 }
hl.Title        = { fg = orange_0 }
hl.Visual       = { bg = gray_2 }
hl.VisualNC     = { bg = gray_0 }
hl.WarningMsg   = { fg = black, bg = yellow_1 }

-- I don't want to see the tildes at the end of buffer
hl.EndOfBuffer = { fg = black }

-- Standard syntax elements
hl.Comment      = { fg = gray_4 }
hl.Constant     = { fg = yellow_2 }
hl.String       = { fg = green_0 }
hl.Character    = hl.String
hl.Number       = hl.Constant
hl.Function     = { fg = orange_2 }
hl.Identifier   = { fg = blue_0 }
hl.Statement    = { fg = orange_0 }
hl.Operator     = { fg = yellow_0 }
hl.PreProc      = { fg = orange_1 }
hl.Type         = hl.Identifier
hl.Structure    = hl.PreProc
hl.Special      = hl.PreProc
hl.Error        = hl.ErrorMsg
hl.Todo         = { fg = red_0 }

-- For my own "plugins"
hl.BaruaPresentH1        = { fg = cyan_0, attrs = { "bold" } }
hl.BaruaPresentH2        = { fg = magenta_1, attrs = { "bold" } }
hl.BaruaPresentH3        = { fg = yellow_2, attrs = { "bold" } }
hl.BaruaPresentCodeBlock = { bg = gray_1 }

-- Tree-sitter highlights (TODO)
--
-- `TSAttribute`
-- Annotations that can be attached to the code to denote some kind of meta
-- information. e.g. C++/Dart attributes.
-- `TSBoolean`
-- Boolean literals: `True` and `False` in Python.
-- `TSCharacter`
-- Character literals: `'a'` in C.
-- `TSCharacterSpecial`
-- Special characters.
-- `TSComment`
-- Line comments and block comments.
-- `TSConditional`
-- Keywords related to conditionals: `if`, `when`, `cond`, etc.
-- `TSConstant`
-- Constants identifiers. These might not be semantically constant.
-- E.g. uppercase variables in Python.
-- `TSConstBuiltin`
-- Built-in constant values: `nil` in Lua.
-- `TSConstMacro`
-- Constants defined by macros: `NULL` in C.
-- `TSConstructor`
-- Constructor calls and definitions: `{}` in Lua, and Java constructors.
-- `TSDebug`
-- Debugging statements.
-- `TSDefine`
-- Preprocessor #define statements.
-- `TSError`
-- Syntax/parser errors. This might highlight large sections of code while the
-- user is typing still incomplete code, use a sensible highlight.
-- `TSException`
-- Exception related keywords: `try`, `except`, `finally` in Python.
-- `TSField`
-- Object and struct fields.
-- `TSFloat`
-- Floating-point number literals.
-- `TSFunction`
-- Function calls and definitions.
-- `TSFuncBuiltin`
-- Built-in functions: `print` in Lua.
-- `TSFuncMacro`
-- Macro defined functions (calls and definitions): each `macro_rules` in
-- Rust.
-- `TSInclude`
-- File or module inclusion keywords: `#include` in C, `use` or `extern crate` in
-- Rust.
-- `TSKeyword`
-- Keywords that don't fit into other categories.
-- `TSKeywordFunction`
-- Keywords used to define a function: `function` in Lua, `def` and `lambda` in
-- Python.
-- `TSKeywordOperator`
-- Unary and binary operators that are English words: `and`, `or` in Python;
-- `sizeof` in C.
-- `TSKeywordReturn`
-- Keywords like `return` and `yield`.
-- `TSLabel`
-- GOTO labels: `label:` in C, and `::label::` in Lua.
-- `TSMethod`
-- Method calls and definitions.
-- `TSNamespace`
-- Identifiers referring to modules and namespaces.
-- `TSNone`
-- No highlighting (sets all highlight arguments to `NONE`). this group is used
-- to clear certain ranges, for example, string interpolations. Don't change the
-- values of this highlight group.
-- `TSNumber`
-- Numeric literals that don't fit into other categories.
-- `TSOperator`
-- Binary or unary operators: `+`, and also `->` and `*` in C.
-- `TSParameter`
-- Parameters of a function.
-- `TSParameterReference`
-- References to parameters of a function.
-- `TSPreProc`
-- Preprocessor #if, #else, #endif, etc.
-- `TSProperty`
-- Same as `TSField`.
-- `TSPunctDelimiter`
-- Punctuation delimiters: Periods, commas, semicolons, etc.
-- `TSPunctBracket`
-- Brackets, braces, parentheses, etc.
-- `TSPunctSpecial`
-- Special punctuation that doesn't fit into the previous categories.
-- `TSRepeat`
-- Keywords related to loops: `for`, `while`, etc.
-- `TSStorageClass`
-- Keywords that affect how a variable is stored: `static`, `comptime`, `extern`,
-- etc.
-- `TSString`
-- String literals.
-- `TSStringRegex`
-- Regular expression literals.
-- `TSStringEscape`
-- Escape characters within a string: `\n`, `\t`, etc.
-- `TSStringSpecial`
-- Strings with special meaning that don't fit into the previous categories.
-- `TSSymbol`
-- Identifiers referring to symbols or atoms.
-- `TSTag`
-- Tags like HTML tag names.
-- `TSTagAttribute`
-- HTML tag attributes.
-- `TSTagDelimiter`
-- Tag delimiters like `<` `>` `/`.
-- `TSText`
-- Non-structured text. Like text in a markup language.
-- `TSStrong`
-- Text to be represented in bold.
-- `TSEmphasis`
-- Text to be represented with emphasis.
-- `TSUnderline`
-- Text to be represented with an underline.
-- `TSStrike`
-- Strikethrough text.
-- `TSTitle`
-- Text that is part of a title.
-- `TSLiteral`
-- Literal or verbatim text.
-- `TSURI`
-- URIs like hyperlinks or email addresses.
-- `TSMath`
-- Math environments like LaTeX's `$ ... $`
-- `TSTextReference`
-- Footnotes, text references, citations, etc.
-- `TSEnvironment`
-- Text environments of markup languages.
-- `TSEnvironmentName`
-- Text/string indicating the type of text environment. Like the name of a
-- `\begin` block in LaTeX.
-- `TSNote`
-- Text representation of an informational note.
-- `TSWarning`
-- Text representation of a warning note.
-- `TSDanger`
-- Text representation of a danger note.
-- `TSTodo`
-- Anything that needs extra attention, such as keywords like TODO or FIXME.
-- `TSType`
-- Type (and class) definitions and annotations.
-- `TSTypeBuiltin`
-- Built-in types: `i32` in Rust.
-- `TSTypeQualifier`
-- Qualifiers on types, e.g. `const` or `volatile` in C or `mut` in Rust.
-- `TSTypeDefinition`
-- Type definitions, e.g. `typedef` in C.
-- `TSVariable`
-- Variable names that don't fit into other categories.
-- `TSVariableBuiltin`
-- Variable names defined by the language: `this` or `self` in Javascript.

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
