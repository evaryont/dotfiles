" Vim color file:  devolved.vim
" Last Change: 31. Oct 2011
" License: public domain
" Maintainer: evaryont <colin@evaryont.me>
"
" {{{ for a 256 color capable terminal like xterm-256color, ... or gvim as well
" it only works in such a terminal and when you have:
" set t_Co=256
" in your vimrc
" }}}

" {{{ reset colors and set colors_name and store cpo setting
set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif

let g:colors_name = "devolved"

let s:save_cpo = &cpo
set cpo&vim
" }}}

" {{{ t_Co=256 is set - check
if &t_Co != 256 && ! has("gui_running")
    finish
endif
" }}}

" FORMAT:"{{{
"
" \ ["color-group", "term-style", "foreground-color", "background-color", "gui-style", "under-curl-color" ],
"
" 'term-style'/'gui-style' can be:
"              bold, underline, undercurl, reverse, inverse, italic, standout, NONE
"
" if gui-style is empty, the term-style value is used for the gui
"
" (Note: not everything is supported by a terminal nor the gui)
"
" besides empty values defaults to 'NONE"
"
" may also check:  :help highlight-groups
"                  :help hl-<highlight-group> "
"
" for the Color numbers (0-255) for the foreground/background and under-curl-colors:
" http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

"}}}

" The fill-in-the-blanks for anything else that's missing.
let s:standardC = ["Normal",        "NONE",       "253",  "233",  "NONE",     "NONE"]
" Color arrays {{{
let s:colors256 = [
                \ ["Cursor",        "",           "255",  "33",   "",         ""   ],
                \ ["CursorLine",    "underline",  "",     "",     "",         ""   ],
                \ ["CursorColumn",  "",           "",     "223",  "",         ""   ],
                \ ["Incsearch",     "bold",       "195",  "124",  "",         ""   ],
                \ ["Search",        "",           "232",  "184",  "",         ""   ],
                \ ["ErrorMsg",      "bold",       "16",   "202",  "",         ""   ],
                \ ["WarningMsg",    "bold",       "16",   "190",  "",         ""   ],
                \ ["ModeMsg",       "bold",       "226",  "18",   "",         ""   ],
                \ ["MoreMsg",       "bold",       "16",   "154",  "",         ""   ],
                \ ["Question",      "bold",       "70",   "",     "",         ""   ],
                \ ["StatusLine",    "bold",       "84",   "234",  "",         ""   ],
                \ ["StatusLineNC",  "",           "41",   "233",  "",         ""   ],
                \ ["User1",         "bold",       "28",   "",     "",         ""   ],
                \ ["User2",         "bold",       "39",   "",     "",         ""   ],
                \ ["VertSplit",     "",           "84",   "22",   "",         ""   ],
                \ ["WildMenu",      "bold",       "208",  "",     "",         ""   ],
                \ ["DiffText",      "",           "16",   "190",  "",         ""   ],
                \ ["DiffChange",    "",           "18",   "83",   "",         ""   ],
                \ ["DiffDelete",    "",           "79",   "124",  "",         ""   ],
                \ ["DiffAdd",       "",           "79",   "21",   "",         ""   ],
                \ ["Folded",        "bold",       "38",   "234",  "",         ""   ],
                \ ["FoldedColumn",  "",           "39",   "190",  "",         ""   ],
                \ ["FoldColumn",    "",           "38",   "234",  "",         ""   ],
                \ ["Directory",     "",           "28",   "",     "",         ""   ],
                \ ["LineNr",        "NONE",       "23",   "233",  "",         ""   ],
                \ ["NonText",       "",           "244",  "",     "",         ""   ],
                \ ["SpecialKey",    "",           "190",  "",     "",         ""   ],
                \ ["Title",         "bold",       "98",   "",     "",         ""   ],
                \ ["Visual",        "",           "",     "238",  "",         ""   ],
                \ ["Comment",       "italic",     "240",  "",     "",         ""   ],
                \ ["Constant",      "",           "75",   "",     "",         ""   ],
                \ ["Include",       "",           "67",   "",     "",         ""   ],
                \ ["String",        "",           "198",  "234",  "",         ""   ],
                \ ["Error",         "",           "69",   "",     "",         ""   ],
                \ ["Identifier",    "",           "196",  "",     "",         ""   ],
                \ ["Ignore",        "",           "",     "",     "",         ""   ],
                \ ["Number",        "",           "50",   "",     "",         ""   ],
                \ ["PreProc",       "",           "62",   "",     "",         ""   ],
                \ ["SignColumn",    "NONE",       "",     "233",  "",         ""   ],
                \ ["Special",       "",           "15",   "234",  "",         ""   ],
                \ ["SpecialChar",   "",           "155",  "",     "",         ""   ],
                \ ["Statement",     "",           "69",   "",     "",         ""   ],
                \ ["Todo",          "bold",       "16",   "148",  "",         ""   ],
                \ ["Type",          "",           "34",   "",     "",         ""   ],
                \ ["Underlined",    "bold",       "77",   "",     "",         ""   ],
                \ ["TaglistTagName","bold",       "48",   "124",  "",         ""   ]]

let s:colorvim7 = [
                \ ["ColorColumn",   "",          "11",   "239",  "",         ""   ],
                \ ["Pmenu",         "",          "228",  "236",  "",         ""   ],
                \ ["PmenuSel",      "bold",      "226",  "233",  "",         ""   ],
                \ ["PmenuSbar",     "",          "119",  "16",   "",         ""   ],
                \ ["PmenuThumb",    "",          "11",   "16",   "",         ""   ],
                \ ["SpellBad",      "underline", "88",   "",     "undercurl","160"],
                \ ["SpellRare",     "",          "82",   "233",  "",         ""   ],
                \ ["SpellLocal",    "",          "227",  "234",  "",         ""   ],
                \ ["SpellCap",      "",          "46",   "236",  "",         ""   ],
                \ ["MatchParen",    "bold",      "15",   "22",   "",         ""   ],
                \ ["TabLine",       "",          "253",  "30",   "",         ""   ],
                \ ["TabLineSel",    "bold",      "247",  "16",   "",         ""   ],
                \ ["TabLineFill",   "",          "247",  "16",   "",         ""   ]]

let s:otherColors = [
                \ ["statusColNr",              "NONE",  "233",  "23",      "",         ""   ],
                \ ["statusColNrPowerline",     "NONE",  "23",   "234",     "",         ""   ],
                \ ["statusColNcPowerline",     "NONE",  "23",   "233",     "",         ""   ],
                \ ["statusFileName",           "NONE",  "214",  "234",     "",         ""   ],
                \ ["statusFileType",           "NONE",  "39",   "234",     "",         ""   ],
                \ ["statusBranch",             "NONE",  "202",  "234",     "",         ""   ],
                \ ["statusFlag",               "NONE",  "200",  "234",     "",         ""   ],
                \ ["diffRemoved",              "",      "",     "124",     "",         ""   ],
                \ ["ShowMarksHLl",             "bold",  "18",   "43",      "",         ""   ],
                \ ["ShowMarksHLu",             "bold",  "9",    "1",       "",         ""   ],
                \ ["ShowMarksHLo",             "bold",  "11",   "3",       "",         ""   ],
                \ ["ShowMarksHLm",             "bold",  "2",    "20",      "",         ""   ],
                \ ["cppSTL",                   "",      "130",  "",        "",         ""   ],
                \ ["rubyRegexpEscape",         "",      "162",  "234",     "",         ""   ],
                \ ["rubyStringDelimiter",      "",      "162",  "",        "",         ""   ],
                \ ["diffAdded",                "",      "",     "22",      "",         ""   ],
                \ ["javaScriptTemplateVar",    "",      "172",  "",        "",         ""   ],
                \ ["javaScriptTemplateDelim",  "bold",  "166",  "",        "",         ""   ],
                \ ["javaScriptTemplateString", "",      "162",  "",        "",         ""   ],
                \ ["Sneak",           "underline",      "130",  "237",     "",         ""   ]]

" }}}

" {{{ Convert specific entries from $LS_COLORS (therefore, dircolors)
" into useful highlight strings for netrw
let s:ansi_styles = { 0: 'NONE', 1: 'bold', 4: 'underline', 7: 'reverse' }

" Given a syntax highlighting name and a ASNI format string (like '01;35' or
" '38;5;39'), parse the format string into vim's syntax
function! s:append_ls_color(syntax_name, formatter)
    let styling = []
    let fg_color = ""
    let bg_color = ""

    " Split up the format string
    for color in split(a:formatter, ';')
        let colorn = color + 0 " convert it to a number for easy comparisons

        " Regular ol' 8 colors for foreground and background
        if colorn > 30 && colorn < 38
            let fg_color = colorn - 30
        elseif colorn > 40 && colorn < 48
            let bg_color = colorn - 40

        " Extended range (256) color support. Those are in the format of
        " '38;5;n', where n is 0..256
        elseif colorn == 38
            let fg_color = split(a:formatter, ';')[2]
            break " we stop iterating through the formatter at this point
        elseif colorn == 48
            let bg_color = split(a:formatter, ';')[2]
            break

        " Format numerics <= 9 are styling indiciators. Use the ansi_styles
        " dictionary to convert them into vim keywords
        elseif colorn < 10
            call add(styling, s:ansi_styles[colorn])
        endif
    endfor

    " Append the full suite of formatting information to the otherColors array
    call add(s:otherColors, [a:syntax_name, join(styling, ','), fg_color,  bg_color, "", ""])
endfunction

let s:ls_colors = split($LS_COLORS, ':')
for desc in s:ls_colors
    let s:ls_color_split = split(desc, '=')
    if s:ls_color_split[0] == 'di'
        call s:append_ls_color("Directory", s:ls_color_split[1])
    elseif s:ls_color_split[0] == 'ln'
        call s:append_ls_color("netrwSymlink", s:ls_color_split[1])
    elseif s:ls_color_split[0] == 'ex'
        call s:append_ls_color("netrwExe", s:ls_color_split[1])
    endif
endfor
" }}}

"============================================================
"        * NO NEED * to edit below (unless bugfixing)
"============================================================
"
" {{{ check args helper function
function! s:checkargs(arg)
    if a:arg+0 == 0 && a:arg != "0"  "its a string
        return a:arg
    else
        return s:cmap[a:arg+0]       "get rgb color based on the number
    endif
endfunction
" }}}
" {{{ guisetcolor helper function
"
function! s:guisetcolor(colarg)
    " if gui-style is empty use (c)term-style also for gui
        if a:colarg[4] == ""
            let guival = a:colarg[1]
        else
            let guival = a:colarg[4]
        endif

        let fg = s:checkargs(a:colarg[2])
        let bg = s:checkargs(a:colarg[3])
        let sp = s:checkargs(a:colarg[5])

        exec "hi ".a:colarg[0]." gui=".guival." guifg=".fg." guibg=".bg." guisp=".sp
endfunction
" }}}
    " color-mapping array {{{
    " number of vim colors and #html colors equivalent for gui
    let s:cmap =   [
                \ "#000000", "#800000", "#008000", "#808000",
                \ "#000080", "#800080", "#008080", "#c0c0c0",
                \ "#808080", "#ff0000", "#00ff00", "#ffff00",
                \ "#0000ff", "#ff00ff", "#00ffff", "#ffffff",
                \
                \ "#000000", "#00005f", "#000087", "#0000af", "#0000d7", "#0000ff",
                \ "#005f00", "#005f5f", "#005f87", "#005faf", "#005fd7", "#005fff",
                \ "#008700", "#00875f", "#008787", "#0087af", "#0087d7", "#0087ff",
                \ "#00af00", "#00af5f", "#00af87", "#00afaf", "#00afd7", "#00afff",
                \ "#00d700", "#00d75f", "#00d787", "#00d7af", "#00d7d7", "#00d7ff",
                \ "#00ff00", "#00ff5f", "#00ff87", "#00ffaf", "#00ffd7", "#00ffff",
                \ "#5f0000", "#5f005f", "#5f0087", "#5f00af", "#5f00d7", "#5f00ff",
                \ "#5f5f00", "#5f5f5f", "#5f5f87", "#5f5faf", "#5f5fd7", "#5f5fff",
                \ "#5f8700", "#5f875f", "#5f8787", "#5f87af", "#5f87d7", "#5f87ff",
                \ "#5faf00", "#5faf5f", "#5faf87", "#5fafaf", "#5fafd7", "#5fafff",
                \ "#5fd700", "#5fd75f", "#5fd787", "#5fd7af", "#5fd7d7", "#5fd7ff",
                \ "#5fff00", "#5fff5f", "#5fff87", "#5fffaf", "#5fffd7", "#5fffff",
                \ "#870000", "#87005f", "#870087", "#8700af", "#8700d7", "#8700ff",
                \ "#875f00", "#875f5f", "#875f87", "#875faf", "#875fd7", "#875fff",
                \ "#878700", "#87875f", "#878787", "#8787af", "#8787d7", "#8787ff",
                \ "#87af00", "#87af5f", "#87af87", "#87afaf", "#87afd7", "#87afff",
                \ "#87d700", "#87d75f", "#87d787", "#87d7af", "#87d7d7", "#87d7ff",
                \ "#87ff00", "#87ff5f", "#87ff87", "#87ffaf", "#87ffd7", "#87ffff",
                \ "#af0000", "#af005f", "#af0087", "#af00af", "#af00d7", "#af00ff",
                \ "#af5f00", "#af5f5f", "#af5f87", "#af5faf", "#af5fd7", "#af5fff",
                \ "#af8700", "#af875f", "#af8787", "#af87af", "#af87d7", "#af87ff",
                \ "#afaf00", "#afaf5f", "#afaf87", "#afafaf", "#afafd7", "#afafff",
                \ "#afd700", "#afd75f", "#afd787", "#afd7af", "#afd7d7", "#afd7ff",
                \ "#afff00", "#afff5f", "#afff87", "#afffaf", "#afffd7", "#afffff",
                \ "#d70000", "#d7005f", "#d70087", "#d700af", "#d700d7", "#d700ff",
                \ "#d75f00", "#d75f5f", "#d75f87", "#d75faf", "#d75fd7", "#d75fff",
                \ "#d78700", "#d7875f", "#d78787", "#d787af", "#d787d7", "#d787ff",
                \ "#d7af00", "#d7af5f", "#d7af87", "#d7afaf", "#d7afd7", "#d7afff",
                \ "#d7d700", "#d7d75f", "#d7d787", "#d7d7af", "#d7d7d7", "#d7d7ff",
                \ "#d7ff00", "#d7ff5f", "#d7ff87", "#d7ffaf", "#d7ffd7", "#d7ffff",
                \ "#ff0000", "#ff005f", "#ff0087", "#ff00af", "#ff00d7", "#ff00ff",
                \ "#ff5f00", "#ff5f5f", "#ff5f87", "#ff5faf", "#ff5fd7", "#ff5fff",
                \ "#ff8700", "#ff875f", "#ff8787", "#ff87af", "#ff87d7", "#ff87ff",
                \ "#ffaf00", "#ffaf5f", "#ffaf87", "#ffafaf", "#ffafd7", "#ffafff",
                \ "#ffd700", "#ffd75f", "#ffd787", "#ffd7af", "#ffd7d7", "#ffd7ff",
                \ "#ffff00", "#ffff5f", "#ffff87", "#ffffaf", "#ffffd7", "#ffffff",
                \
                \ "#080808", "#121212", "#1c1c1c", "#262626", "#303030", "#3a3a3a",
                \ "#444444", "#4e4e4e", "#585858", "#606060", "#666666", "#767676",
                \ "#808080", "#8a8a8a", "#949494", "#9e9e9e", "#a8a8a8", "#b2b2b2",
                \ "#bcbcbc", "#c6c6c6", "#d0d0d0", "#dadada", "#e4e4e4", "#eeeeee" ]
    " }}}
" {{{ color loop

" Step one: Highlight normal mode.
exec "hi ".s:standardC[0]." cterm=".s:standardC[1]." ctermfg=".s:standardC[2]." ctermbg=".s:standardC[3]
call s:guisetcolor(s:standardC)

" Step two: Loop through each block of colors...
for s:colorBlock in [s:colors256, s:colorvim7, s:otherColors]
    for s:colorRow in s:colorBlock
        " change empty fields to "NONE", or the normal background/foreground colors.
        for i in  [1, 2, 3, 4, 5]
            if s:colorRow[i] == ""
                " Empty, so pull the value from the Normal highlight.
                let s:colorRow[i] = s:standardC[i]
            endif
        endfor
        " Missing values filled in, do the hilighting.
        exec "hi ".s:colorRow[0]." cterm=".s:colorRow[1]." ctermfg=".s:colorRow[2]." ctermbg=".s:colorRow[3]
        " And do it for the GUI, as well.
        call s:guisetcolor(s:colorRow)
    endfor
endfor
" }}}
let &cpo = s:save_cpo   " restoring &cpo value
" vim: set fdm=marker fileformat=unix nospell:
