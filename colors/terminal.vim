" File:    terminal.vim
" Author:  Max Ilsen
" License: MIT
" Using the RGB color palette taken from your terminal

" Initialisation: {{{
" ----------------------------------------------------------------------------

if !exists("g:enable_bold_font")
  let g:enable_bold_font = 0
endif

highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "terminal"

" }}}
" Functions: {{{
" ----------------------------------------------------------------------------

" Function to assign color-values to key-named variables
function! s:AssignVariables(elements)
  for [key,value] in items(a:elements)
    execute "let s:" . key . " = '" . value . "'"
  endfor
endfunction

" Function to execute statements of the form:
" hi! HiGroup ctermfg=0 ctermbg=0 cterm=NONE,bold term=NONE,bold
function! s:Highlight(hi_groups)
  for [hi_group,values] in items(a:hi_groups)
    execute 'hi! ' . hi_group .
          \ ' ctermfg='   . values[0] .
          \ ' ctermbg='   . values[1] .
          \ ' cterm=NONE' . values[2] .
          \ ' term=NONE'  . values[2]
  endfor
endfunction

" }}}
" Highlighting Palettes: {{{
" ----------------------------------------------------------------------------

" Assign terminal colors to background- and foreground-variables
if &bg ==# 'dark'
  let s:elements = {
        \ 'none'        : "NONE" ,
        \ 'bg_strong'   : "0"    ,
        \ 'bg_red'      : "1"    ,
        \ 'bg_green'    : "2"    ,
        \ 'bg_yellow'   : "3"    ,
        \ 'bg_blue'     : "4"    ,
        \ 'bg_magenta'  : "5"    ,
        \ 'bg_cyan'     : "6"    ,
        \ 'fg_weak'     : "7"    ,
        \ 'bg_weak'     : "8"    ,
        \ 'fg_red'      : "9"    ,
        \ 'fg_green'    : "10"   ,
        \ 'fg_yellow'   : "11"   ,
        \ 'fg_blue'     : "12"   ,
        \ 'fg_magenta'  : "13"   ,
        \ 'fg_cyan'     : "14"   ,
        \ 'fg_strong'   : "15"
        \ }
else
  let s:elements = {
        \ 'none'        : "NONE" ,
        \ 'fg_strong'   : "0"    ,
        \ 'fg_red'      : "1"    ,
        \ 'fg_green'    : "2"    ,
        \ 'fg_yellow'   : "3"    ,
        \ 'fg_blue'     : "4"    ,
        \ 'fg_magenta'  : "5"    ,
        \ 'fg_cyan'     : "6"    ,
        \ 'bg_weak'     : "7"    ,
        \ 'fg_weak'     : "8"    ,
        \ 'bg_red'      : "9"    ,
        \ 'bg_green'    : "10"   ,
        \ 'bg_yellow'   : "11"   ,
        \ 'bg_blue'     : "12"   ,
        \ 'bg_magenta'  : "13"   ,
        \ 'bg_cyan'     : "14"   ,
        \ 'bg_strong'   : "15"
        \ }
endif

call s:AssignVariables(s:elements)

" }}}
" Formatting Options: {{{
" ----------------------------------------------------------------------------

let s:format_options = {
      \ 'fmt_none' : "" ,
      \ 'fmt_curl' : ",undercurl" ,
      \ 'fmt_revr' : ",reverse"   ,
      \ 'fmt_stnd' : ",standout"  ,
      \ 'fmt_bold' : ",bold"      ,
      \ 'fmt_undr' : ",underline" ,
      \ 'fmt_ital' : ",italic"
      \ }

call s:AssignVariables(s:format_options)

" Set bold font depending on options
if g:enable_bold_font == 1
  let s:fmt_optb = s:fmt_bold
else
  let s:fmt_optb = s:fmt_none
endif

" }}}
" Vim Highlighting: (see :help highlight-groups) {{{
" ----------------------------------------------------------------------------

" 'HighlightGroup' : [foreground, background, format_option]
let s:vim_hi_groups = {
      \ 'ColorColumn'    : [s:none       , s:bg_weak    , s:fmt_none],
      \ 'Conceal'        : [s:none       , s:none       , s:fmt_none],
      \ 'Cursor'         : [s:none       , s:none       , s:fmt_none],
      \ 'CursorIM'       : [s:none       , s:none       , s:fmt_none],
      \ 'CursorColumn'   : [s:none       , s:bg_weak    , s:fmt_none],
      \ 'CursorLine'     : [s:none       , s:bg_weak    , s:fmt_none],
      \ 'Directory'      : [s:fg_blue    , s:none       , s:fmt_none],
      \ 'DiffAdd'        : [s:fg_green   , s:bg_strong  , s:fmt_revr],
      \ 'DiffChange'     : [s:fg_magenta , s:bg_strong  , s:fmt_revr],
      \ 'DiffDelete'     : [s:fg_red     , s:bg_strong  , s:fmt_revr],
      \ 'DiffText'       : [s:fg_blue    , s:bg_strong  , s:fmt_revr],
      \ 'ErrorMsg'       : [s:fg_strong  , s:bg_red     , s:fmt_bold],
      \ 'VertSplit'      : [s:none       , s:bg_weak    , s:fmt_none],
      \ 'Folded'         : [s:fg_weak    , s:bg_strong  , s:fmt_none],
      \ 'FoldColumn'     : [s:none       , s:bg_strong  , s:fmt_none],
      \ 'SignColumn'     : [s:none       , s:bg_strong  , s:fmt_none],
      \ 'IncSearch'      : [s:fg_cyan    , s:bg_strong  , s:fmt_revr],
      \ 'LineNr'         : [s:bg_weak    , s:none       , s:fmt_none],
      \ 'CursorLineNr'   : [s:fg_yellow  , s:none       , s:fmt_bold],
      \ 'MatchParen'     : [s:fg_magenta , s:bg_strong  , s:fmt_bold],
      \ 'ModeMsg'        : [s:fg_yellow  , s:none       , s:fmt_bold],
      \ 'MoreMsg'        : [s:fg_green   , s:none       , s:fmt_none],
      \ 'NonText'        : [s:bg_weak    , s:none       , s:fmt_none],
      \ 'Normal'         : [s:fg_strong  , s:bg_strong  , s:fmt_none],
      \ 'Pmenu'          : [s:fg_strong  , s:bg_weak    , s:fmt_none],
      \ 'PmenuSel'       : [s:fg_strong  , s:bg_weak    , s:fmt_revr],
      \ 'PmenuSbar'      : [s:none       , s:none       , s:fmt_none],
      \ 'PmenuThumb'     : [s:none       , s:none       , s:fmt_none],
      \ 'Question'       : [s:fg_green   , s:none       , s:fmt_none],
      \ 'Search'         : [s:fg_yellow  , s:bg_strong  , s:fmt_revr],
      \ 'SpecialKey'     : [s:bg_weak    , s:none       , s:fmt_none],
      \ 'SpellCap'       : [s:bg_strong  , s:bg_blue    , s:fmt_undr],
      \ 'SpellLocal'     : [s:bg_strong  , s:bg_cyan    , s:fmt_undr],
      \ 'SpellBad'       : [s:fg_strong  , s:bg_red     , s:fmt_undr],
      \ 'SpellRare'      : [s:bg_strong  , s:bg_magenta , s:fmt_undr],
      \ 'StatusLine'     : [s:fg_strong  , s:bg_strong  , s:fmt_bold],
      \ 'StatusLineNC'   : [s:bg_weak    , s:bg_strong  , s:fmt_none],
      \ 'TabLine'        : [s:fg_strong  , s:bg_strong  , s:fmt_none],
      \ 'TabLineFill'    : [s:none       , s:none       , s:fmt_none],
      \ 'TabLineSel'     : [s:fg_strong  , s:bg_strong  , s:fmt_revr],
      \ 'Title'          : [s:fg_yellow  , s:none       , s:fmt_bold],
      \ 'Visual'         : [s:none       , s:bg_weak    , s:fmt_none],
      \ 'VisualNos'      : [s:none       , s:bg_weak    , s:fmt_none],
      \ 'WarningMsg'     : [s:fg_strong  , s:bg_magenta , s:fmt_bold],
      \ 'WildMenu'       : [s:fg_yellow  , s:bg_strong  , s:fmt_revr]
      \ }

call s:Highlight(s:vim_hi_groups)

" }}}
" Syntax Highlighting: (see :help group-name) {{{
" ----------------------------------------------------------------------------

let s:syntax_hi_groups = {
      \ 'Comment'        : [s:fg_weak    , s:none       , s:fmt_none],
      \
      \ 'Constant'       : [s:fg_magenta , s:none       , s:fmt_none],
      \ 'String'         : [s:fg_green   , s:none       , s:fmt_none],
      \ 'Character'      : [s:fg_magenta , s:none       , s:fmt_none],
      \ 'Number'         : [s:fg_magenta , s:none       , s:fmt_none],
      \ 'Boolean'        : [s:fg_magenta , s:none       , s:fmt_none],
      \ 'Float'          : [s:fg_magenta , s:none       , s:fmt_none],
      \
      \ 'Identifier'     : [s:fg_red     , s:none       , s:fmt_none],
      \ 'Function'       : [s:fg_yellow  , s:none       , s:fmt_optb],
      \
      \ 'Statement'      : [s:fg_blue    , s:none       , s:fmt_optb],
      \ 'Conditional'    : [s:fg_blue    , s:none       , s:fmt_none],
      \ 'Repeat'         : [s:fg_blue    , s:none       , s:fmt_none],
      \ 'Label'          : [s:fg_blue    , s:none       , s:fmt_none],
      \ 'Operator'       : [s:fg_cyan    , s:none       , s:fmt_none],
      \ 'Keyword'        : [s:fg_blue    , s:none       , s:fmt_none],
      \ 'Exception'      : [s:fg_blue    , s:none       , s:fmt_none],
      \
      \ 'PreProc'        : [s:fg_cyan    , s:none       , s:fmt_optb],
      \ 'Include'        : [s:fg_cyan    , s:none       , s:fmt_none],
      \ 'Define'         : [s:fg_cyan    , s:none       , s:fmt_none],
      \ 'Macro'          : [s:fg_cyan    , s:none       , s:fmt_none],
      \ 'PreCondit'      : [s:fg_cyan    , s:none       , s:fmt_none],
      \
      \ 'Type'           : [s:bg_yellow  , s:none       , s:fmt_optb],
      \ 'StorageClass'   : [s:bg_yellow  , s:none       , s:fmt_none],
      \ 'Structure'      : [s:bg_yellow  , s:none       , s:fmt_none],
      \ 'Typedef'        : [s:bg_yellow  , s:none       , s:fmt_none],
      \
      \ 'Special'        : [s:fg_green   , s:none       , s:fmt_none],
      \ 'SpecialChar'    : [s:fg_green   , s:none       , s:fmt_none],
      \ 'Tag'            : [s:fg_green   , s:none       , s:fmt_none],
      \ 'Delimiter'      : [s:fg_green   , s:none       , s:fmt_none],
      \ 'SpecialComment' : [s:fg_green   , s:none       , s:fmt_none],
      \ 'Debug'          : [s:fg_green   , s:none       , s:fmt_none],
      \
      \ 'Underlined'     : [s:fg_blue    , s:none       , s:fmt_undr],
      \
      \ 'Ignore'         : [s:none       , s:none       , s:fmt_none],
      \
      \ 'Error'          : [s:fg_strong  , s:bg_red     , s:fmt_bold],
      \
      \ 'Todo'           : [s:fg_green   , s:bg_strong  , s:fmt_revr],
      \ }

call s:Highlight(s:syntax_hi_groups)

" }}}
