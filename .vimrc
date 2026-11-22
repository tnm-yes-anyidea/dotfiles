" ========================================================================== "
" 1. NATIVE SETTINGS
" ========================================================================== "
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set cursorline
set splitbelow
set splitright
set scrolloff=8

" ========================================================================== "
" 2. NATIVE SOLARIZED DARK THEME
" ========================================================================== "
if has('termguicolors')
    set termguicolors
endif
set background=dark

highlight Normal guibg=#002b36 guifg=#839496
highlight LineNr guibg=#002b36 guifg=#586e75
highlight CursorLine guibg=#073642
highlight CursorLineNr guibg=#073642 guifg=#b58900 gui=bold
highlight Comment guifg=#586e75 gui=italic
highlight String guifg=#2aa198
highlight Function guifg=#268bd2
highlight Keyword guifg=#859900
highlight Type guifg=#b58900
highlight Constant guifg=#cb4b16
highlight Directory guifg=#268bd2 gui=bold

" ========================================================================== "
" 3. PREMIUM POWERLINE STATUSLINE
" ========================================================================== "
set laststatus=2
set noshowmode

highlight StatusLine guibg=#073642 guifg=#93a1a1
highlight StatusLineNC guibg=#002b36 guifg=#586e75

highlight ModeNormal guibg=#268bd2 guifg=#002b36 gui=bold
highlight ModeInsert guibg=#859900 guifg=#002b36 gui=bold
highlight ModeVisual guibg=#b58900 guifg=#002b36 gui=bold
highlight ModeReplace guibg=#dc322f guifg=#002b36 gui=bold
highlight ModeCommand guibg=#d33682 guifg=#002b36 gui=bold

highlight ModeSepNormal guifg=#268bd2 guibg=#073642
highlight ModeSepInsert guifg=#859900 guibg=#073642
highlight ModeSepVisual guifg=#b58900 guibg=#073642
highlight ModeSepReplace guifg=#dc322f guibg=#073642
highlight ModeSepCommand guifg=#d33682 guibg=#073642

highlight StatusRightInfo guibg=#586e75 guifg=#002b36
highlight StatusArrowRight1 guifg=#586e75 guibg=#073642
highlight StatusRightMain guibg=#93a1a1 guifg=#002b36 gui=bold
highlight StatusArrowRight2 guifg=#93a1a1 guibg=#586e75

function! SolarizedStatusline()
    let l:current_mode = mode()
    let l:mode_text = ' UNKNOWN '
    let l:mode_hl = 'ModeNormal'
    let l:sep_hl = 'ModeSepNormal'

    if l:current_mode ==# 'n'
        let l:mode_text = ' NORMAL '
    elseif l:current_mode ==# 'i'
        let l:mode_text = ' INSERT '
        let l:mode_hl = 'ModeInsert'
        let l:sep_hl = 'ModeSepInsert'
    elseif l:current_mode ==# 'v' || l:current_mode ==# 'V' || l:current_mode ==# "\<C-v>"
        let l:mode_text = ' VISUAL '
        let l:mode_hl = 'ModeVisual'
        let l:sep_hl = 'ModeSepVisual'
    elseif l:current_mode ==# 'R'
        let l:mode_text = ' REPLACE '
        let l:mode_hl = 'ModeReplace'
        let l:sep_hl = 'ModeSepReplace'
    elseif l:current_mode ==# 'c'
        let l:mode_text = ' COMMAND '
        let l:mode_hl = 'ModeCommand'
        let l:sep_hl = 'ModeSepCommand'
    elseif l:current_mode ==# 't'
        let l:mode_text = ' TERMINAL '
        let l:mode_hl = 'ModeInsert'
        let l:sep_hl = 'ModeSepInsert'
    endif
    
    let l:enc = &fileencoding != '' ? &fileencoding : &encoding
    
    let l:left = '%#' . l:mode_hl . '#' . l:mode_text . '%#' . l:sep_hl . '#'
    let l:center = ' %#StatusLine# %t %m%r %='
    let l:right_info = '%#StatusArrowRight1#%#StatusRightInfo# %y  ' . l:enc . ' '
    let l:right_main = '%#StatusArrowRight2#%#StatusRightMain# %p%%  %l:%c '
    
    return l:left . l:center . l:right_info . l:right_main
endfunction

set statusline=%!SolarizedStatusline()

" ========================================================================== "
" 4. VIMSCRIPT F5 RUNNER
" ========================================================================== "
let mapleader = " "

function! CompileAndRun()
    write
    let l:ft = &filetype
    let l:file = expand('%')
    let l:out = expand('%:r')
    
    if l:ft ==# 'python'
        let l:cmd = 'python3 ' . l:file
    elseif l:ft ==# 'c'
        let l:cmd = 'gcc ' . l:file . ' -o ' . l:out . ' && ./' . l:out
    elseif l:ft ==# 'cpp'
        let l:cmd = 'g++ ' . l:file . ' -o ' . l:out . ' && ./' . l:out
    elseif l:ft ==# 'java'
        let l:cmd = 'javac ' . l:file . ' && java ' . l:out
    elseif l:ft ==# 'sh'
        let l:cmd = 'bash ' . l:file
    else
        echohl WarningMsg
        echo "No run command set for filetype: " . l:ft
        echohl None
        return
    endif

    split
    " Note: Vim 8 uses 'term', Neovim uses 'terminal'
    if has('nvim')
        execute 'terminal ' . l:cmd
        startinsert
    else
        execute 'term ' . l:cmd
    endif
endfunction

nnoremap <F5> :call CompileAndRun()<CR>
