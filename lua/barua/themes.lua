-- My custom color scheme(s). Note that this only works for terminals with 'termguicolors' set.
-- Obviously, I also assume that this is only going to be used with neovim.

local M = {}

local nvim = require('barua.nvim')

-- Set a colors and attributes for a highlighting group.
local function highlight(group, guifg, guibg, guisp, attrs)
  -- Build up a vim command to set a highlight with the components which are non-nil
  local command = "highlight " .. group
  if guifg then command = command .. " guifg=" .. guifg else command = command .. " guifg=NONE" end
  if guibg then command = command .. " guibg=" .. guibg else command = command .. " guibg=NONE" end
  if guisp then command = command .. " guisp=" .. guisp else command = command .. " guisp=NONE" end
  if attrs then command = command .. " gui=" .. attrs else command = command .. " gui=NONE" end
  -- Run the vim command to set the highlight
  nvim.command(command)
end

-- Apply the basic terminal colors for the theme
local function apply_theme_terminal_colors(theme)
  nvim.terminal_color_0 = theme.term0
  nvim.terminal_color_1 = theme.term1
  nvim.terminal_color_2 = theme.term2
  nvim.terminal_color_3 = theme.term3
  nvim.terminal_color_4 = theme.term4
  nvim.terminal_color_5 = theme.term5
  nvim.terminal_color_6 = theme.term6
  nvim.terminal_color_7 = theme.term7
  nvim.terminal_color_8 = theme.term8
  nvim.terminal_color_9 = theme.term9
  nvim.terminal_color_10 = theme.term10
  nvim.terminal_color_11 = theme.term11
  nvim.terminal_color_12 = theme.term12
  nvim.terminal_color_13 = theme.term13
  nvim.terminal_color_14 = theme.term14
  nvim.terminal_color_15 = theme.term15
  nvim.terminal_color_background = theme.bg
  nvim.terminal_color_foreground = theme.fg
end

-- Apply colors for the theme "theme"
local function apply_theme(theme)
  apply_theme_terminal_colors(theme)

  highlight("Normal",          theme.fg,         theme.bg,       nil,            nil        )
  highlight("Bold",            nil,              nil,            nil,            "bold"     )
  highlight("Italic",          nil,              nil,            nil,            "italic"   )
  highlight("Underlined",      nil,              nil,            nil,            "underline")

  -- Buitin highlight groups
  highlight("ColorColumn",     nil,              theme.line,     nil,            nil        )  -- used for the columns set with 'colorcolumn'
  -- highlight("Conceal",      nil, nil, nil, nil )  --    placeholder characters substituted for concealed text (see 'conceallevel')
  -- highlight("Cursor",       nil, nil, nil, nil )  --    character under the cursor
  -- highlight("lCursor",      nil, nil, nil, nil )  --    the character under the cursor when |language-mapping| is used (see 'guicursor')
  -- highlight("CursorIM",     nil, nil, nil, nil )  --  like Cursor, but used when in IME mode |CursorIM|
  highlight("CursorColumn",    nil,              theme.line,     nil,            nil        )  -- Screen-column at the cursor, when 'cursorcolumn' is set.
  highlight("CursorLine",      nil,              theme.line,     nil,            nil        )  -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
  highlight("Directory",       theme.fg_idle,    nil,            nil,            nil        )  -- directory names (and other special names in listings)
  highlight("DiffAdd",         theme.term2,      theme.panel,    nil,            nil        )  -- diff mode: Added line |diff.txt|
  highlight("DiffChange",      theme.term4,      theme.panel,    nil,            nil        )  -- diff mode: Changed line |diff.txt|
  highlight("DiffDelete",      theme.term9,      theme.panel,    nil,            nil        )  -- diff mode: Deleted line |diff.txt|
  highlight("DiffText",        theme.fg,         nil,            nil,            nil        )  -- diff mode: Changed text within a changed line |diff.txt|
  -- highlight("EndOfBuffer",  nil, nil, nil, nil )  --  filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
  -- highlight("TermCursor",   nil, nil, nil, nil )  --  cursor in a focused terminal
  -- highlight("TermCursorNC", nil, nil, nil, nil )  --  cursor in an unfocused terminal
  highlight("ErrorMsg",        theme.fg,         theme["error"], nil,            nil        )  -- error messages on the command line
  highlight("VertSplit",       theme.bg,         nil,            nil,            nil        )  -- the column separating vertically split windows
  highlight("Folded",          theme.fg_idle,    theme.panel,    nil,            nil        )  -- line used for closed folds
  highlight("FoldColumn",      nil,              theme.panel,    nil,            nil        )  -- 'foldcolumn'
  highlight("SignColumn",      nil,              theme.panel,    nil,            nil        )  -- column where |signs| are displayed
  -- highlight("IncSearch",    nil, nil, nil, nil )  --  'incsearch' highlighting; also used for the text replaced with ":s///c"
  -- highlight("Substitute",   nil, nil, nil, nil )  --  |:substitute| replacement text highlighting
  highlight("LineNr",          theme.guide,     nil,             nil,            nil        )  -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
  highlight("CursorLineNr",    theme.accent,    nil,             nil,            nil        )  -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
  -- highlight("MatchParen",   nil, nil, nil, nil )  --  The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
  highlight("ModeMsg",         theme.term2,      nil,             nil,           nil        )  -- 'showmode' message (e.g., "-- INSERT --")
  -- highlight("MsgArea", nil, nil, nil, nil )  --    Area for messages and cmdline
  -- highlight("MsgSeparator", nil, nil, nil, nil )  --  Separator for scrolled messages, `msgsep` flag of 'display'
  highlight("MoreMsg",         theme.term2,     nil,             nil,            nil        )  -- |more-prompt|
  highlight("NonText",         theme.guide,     nil,             nil,            nil        )  -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
  -- highlight("Normal",       nil, nil, nil, nil )  --    normal text
  -- highlight("NormalFloat",  nil, nil, nil, nil )  --  Normal text in floating windows.
  -- highlight("NormalNC",     nil, nil, nil, nil )  --  normal text in non-current windows
  highlight("Pmenu",           theme.fg,        theme.selection, nil,            nil        )  -- Popup menu: normal item.
  highlight("PmenuSel",        theme.fg,        theme.term4,     nil,            nil        )  -- Popup menu: selected item.
  -- highlight("PmenuSbar",    nil, nil, nil, nil )  --  Popup menu: scrollbar.
  -- highlight("PmenuThumb",   nil, nil, nil, nil )  --  Popup menu: Thumb of the scrollbar.
  -- highlight("Question",     nil, nil, nil, nil )  --  |hit-enter| prompt and yes/no questions
  -- highlight("QuickFixLine", nil, nil, nil, nil )  --  Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
  highlight("Search",          theme.bg,        theme.constant,  nil,            nil         )  -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
  highlight("SpecialKey",      theme.selection, nil,             nil,            nil         )  -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
  highlight("SpellBad",        nil,             nil,             theme["error"], "undercurl" )  -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
  highlight("SpellCap",        nil,             nil,             theme.tag,      "undercurl" )  -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
  -- highlight("SpellLocal",   nil, nil, nil, nil )  --  Word that is recognized by the spellchecker as one that is used in another region. |spell|  Combined with the highlighting used otherwise.
  -- highlight("SpellRare",    nil, nil, nil, nil )  --  Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
  highlight("StatusLine",      theme.fg,        theme.panel,     nil,            nil         )  -- status line of current window
  highlight("StatusLineNC",    theme.fg_idle,   theme.panel,     nil,            nil         )  -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
  highlight("TabLine",         theme.fg,        theme.panel,     nil,            nil         )  -- tab pages line, not active tab page label
  -- highlight("TabLineFill",  nil, nil, nil, nil )  --  tab pages line, where there are no labels
  -- highlight("TabLineSel",   nil, nil, nil, nil )  --  tab pages line, active tab page label
  highlight("Title",           theme.keyword,   nil,             nil,            nil         )  -- titles for output from ":set all", ":autocmd" etc.
  highlight("Visual",          nil,             theme.selection, nil,            nil         )  -- Visual mode selection
  -- highlight("VisualNOS",    nil, nil, nil, nil )  --  Visual mode selection when vim is "Not Owning the Selection".
  highlight("WarningMsg",      theme.term11,    nil,             nil,            nil         )  -- warning messages
  -- highlight("Whitespace",   nil, nil, nil, nil )  --  "nbsp", "space", "tab" and "trail" in 'listchars'
  -- highlight("WildMenu",     nil, nil, nil, nil )  --  current match in 'wildmenu' completion

  -- Standard syntax elements
  highlight("Comment",        theme.comment,     nil,            nil,           nil          )  -- Any comment
  highlight("Constant",       theme.constant,    nil,            nil,           nil          )  -- Any constant
  highlight("String",         theme.string,      nil,            nil,           nil          )  -- String literal
  -- highlight("Character",   theme.string,      nil,        nil, nil        )  -- Character literal
  -- highlight("Number",      theme.constant,      nil,        nil, nil        )  -- Number constant
  --highlight("Boolean",      nil,      nil,        nil, nil        )  -- Boolean constant
  --highlight("Float",        nil,      nil,        nil, nil        )  -- Floating point constant
  highlight("Function",       theme["function"], nil,            nil,           nil          )  -- Function/method name
  highlight("Identifier",     theme.tag,         nil,            nil,           nil          )  -- Any variable name
  highlight("Statement",      theme.keyword,     nil,            nil,           nil          )  -- Any statement
  --highlight("Conditional",  nil,      nil,        nil, nil        )  -- if/then/else/endif/switch
  --highlight("Repeat",       nil,      nil,        nil, nil        )  -- Loops
  --highlight("Label",        nil,      nil,        nil, nil        )  -- case/default/goto
  highlight("Operator",       theme.operator,    nil,            nil,           nil          )  -- sizeof/+/*/-
  --highlight("Keyword",      nil,      nil,        nil, nil        )  -- Any other keyword
  --highlight("Exception",    nil,      nil,        nil, nil        )  -- try/catch/throw
  highlight("PreProc",        theme.special,     nil,           nil,            nil          )  -- generic Preprocessor
  --highlight("Include",      nil,      nil,        nil, nil        )  -- preprocessor #include
  --highlight("Define",       nil,      nil,        nil, nil        )  -- preprocessor #define
  --highlight("Macro",        nil,      nil,        nil, nil        )  -- same as Define
  --highlight("PreCondit",    nil,      nil,        nil, nil        )  -- preprocessor #if, #else, #endif, etc.
  highlight("Type",           theme.tag,         nil,           nil,            nil          )  -- int, long, char, etc.
  --highlight("StorageClass", nil,      nil,        nil, nil        )  -- static, register, volatile, etc.
  highlight("Structure",      theme.special,     nil,           nil,            nil          )  -- struct, union, enum, etc.
  --highlight("Typedef",      nil,      nil,        nil, nil        )  -- A typedef
  highlight("Special",        theme.speial,      nil,           nil,            nil          )  -- any special symbol
  --highlight("SpecialChar",    nil,               nil,           nil,            nil          )  -- special character in a constant
  --highlight("Tag",            nil,               nil,           nil,            nil          )  -- you can use CTRL-] on this
  --highlight("Delimiter",      nil,               nil,           nil,            nil          )  -- character that needs attention
  --highlight("SpecialComment", nil,               nil,           nil,            nil          )  -- special things inside a comment
  --highlight("Debug",          nil,               nil,           nil,            nil          )  -- debugging statements
  --highlight("Ignore",         nil,               nil,           nil,            nil          )  -- left blank, hidden  |hl-Ignore|
  highlight("Error",          theme.fg,          theme["error"],nil,            nil          )  -- any erroneous construct
  highlight("Todo",           theme.markup,      nil,           nil,            nil          )  -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX
end

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

-- Collection of colors to build out my theme
local themes = {}

-- Set up the basic 16 terminal colors for each theme
themes["black"] = {
  term0  = "#0F1419",  -- Normal Black
  -- term0  = "000000",  -- Normal Black
  term1  = "#F07178",  -- Normal Red
  term2  = "#B8CC52",  -- Normal Green
  term3  = "#F29718",  -- Normal Yellow
  term4  = "#36A3D9",  -- Normal Blue
  term5  = "#FFEE99",  -- Normal Magenta
  term6  = "#95E6CB",  -- Normal Cyan
  term7  = "#A5A2A2",  -- Normal White (light grey)
  term8  = "#3E4B59",  -- Bright Black (dark grey)
  term9  = "#FF3333",  -- Bright Red
  term10 = "#B8CC52",  -- Bright Green
  term11 = "#F29718",  -- Bright Yellow
  term12 = "#36A3D9",  -- Bright Blue
  term13 = "#FFEE99",  -- Bright Magenta
  term14 = "#95E6CB",  -- Bright Cyan
  term15 = "#FFFFFF",  -- Bright White
}

-- Set up logical colors for each theme (maybe using terminal colors)
themes["black"]["bg"]        = themes["black"]["term0"]  -- Normal background color
themes["black"]["fg"]        = "#E6E1CF"                  -- Normal foreground color
themes["black"]["fg_idle"]   = themes["black"]["term8"]  -- Foreground color for idle pane
themes["black"]["accent"]    = themes["black"]["term3"]
themes["black"]["comment"]   = "#5C6773"
themes["black"]["constant"]  = themes["black"]["term5"]
themes["black"]["string"]    = themes["black"]["term2"]
themes["black"]["regexp"]    = themes["black"]["term6"]  -- Regular expressions
themes["black"]["func_call"] = "#FFB454"                  -- Function calls
themes["black"]["func_defn"] = "#FFB454"                  -- Function definitions
themes["black"]["operator"]  = "#E7C547"
themes["black"]["keyword"]   = "#FF7733"
themes["black"]["error"]     = themes["black"]["term9"]
themes["black"]["selection"] = "#253340"                  -- Text selection
themes["black"]["guide"]     = "#2D3640"                  -- Stuff like line numbers in the gutter
themes["black"]["line"]      = "#22272B"                  -- Stuff like cursorline/cursorcolumn
themes["black"]["tag"]       = themes["black"]["term4"]  -- Variable names, types, and stuff?
themes["black"]["panel"]     = "#14191F"                  -- Stuff like the background of the status bar or folds
themes["black"]["special"]   = "#E6B673"                  -- Stuff like preprocessor things
themes["black"]["markup"]    = themes["black"]["term1"]

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

nvim.command("syntax enable")
nvim.command("highlight clear")

M.set_theme = function(theme_name)
  apply_theme(themes[theme_name])
end

return M
