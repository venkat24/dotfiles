set nocompatible
filetype off

autocmd VimEnter * echo "Welcome, Venkat!"

call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
"Plug 'ervandew/supertab'
Plug 'morhetz/gruvbox'
Plug 'hzchirs/vim-material'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'joshdick/onedark.vim'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'KeitaNakamura/neodark.vim'
Plug 'yuttie/comfortable-motion.vim'
Plug 'junegunn/limelight.vim'
Plug 'dracula/vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-sleuth'
Plug 'rking/ag.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'dhruvasagar/vim-table-mode'
Plug 'majutsushi/tagbar'
Plug 'justinmk/vim-sneak'
Plug 'kien/rainbow_parentheses.vim'
Plug 'junegunn/vim-emoji'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ryanoasis/vim-devicons'
Plug 'gabrielelana/vim-markdown'
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'altercation/vim-colors-solarized'
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif
call plug#end()

set completefunc=autoprogramming#complete
let b:SuperTabDisabled=1

filetype plugin indent on
syntax on
if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

"let g:gruvbox_contrast_dark = 'medium'
"let g:gruvbox_italic = 1

let g:ycm_autoclose_preview_window_after_completion=1

"let base16colorspace=256
set background=dark
"set t_Co=256

set listchars=tab:âž¢\ ,trail:~,extends:>,precedes:<
set title
set autoindent
set smartindent
set backspace=indent,eol,start
set hlsearch
set ruler
set incsearch
set encoding=UTF-8

set wildmenu
set number
set showmatch
set tabstop=4 shiftwidth=4

set hidden
set splitbelow
set splitright
set nobackup
set nowb
set noswapfile

let mapleader = "\<Space>"

cmap w!! w !sudo tee %

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

let g:table_mode_corner='|'

noremap <silent> <C-up> :call <SID>swap_up()<CR>
noremap <silent> <C-down> :call <SID>swap_down()<CR>

vmap sb "zdi<b><C-R>z</b><Esc>
vmap st "zdi<?= <C-R>z ?><Esc>

nnoremap <A-.> :call MoveToNextTab()<CR>
nnoremap <A-,> :call MoveToPrevTab()<CR>

noremap % v%

:command WQ wq
:command Wq wq
:command W w
:command Q q

:command Set set

nnoremap <CR> :noh<CR><CR>

map <c-o> :NERDTreeToggle<CR>

set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
set ttimeoutlen=0

let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-o>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_exit_from_insert_mode=0
let g:multi_cursor_exit_from_visual_mode=0

let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

map <leader>e :bp<bar>sp<bar>bn<bar>bd<CR>
function DeleteHiddenBuffers() " Vim with the 'hidden' option
    let tpbl=[]
    call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
    for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
        silent execute 'bwipeout' buf
    endfor
endfunction
command! BB call DeleteHiddenBuffers()
nnoremap <Leader>bb :call DeleteHiddenBuffers()<CR>

function FormatFile()
    let l:lines="all"
    pyf /usr/share/clang/clang-format.py
endfunction
nnoremap <Leader>cf :call FormatFile()<CR>

function! s:swap_lines(n1, n2)
    let line1 = getline(a:n1)
    let line2 = getline(a:n2)
    call setline(a:n1, line2)
    call setline(a:n2, line1)
endfunction

function! s:swap_up()
    let n = line('.')
    if n == 1
        return
    endif
    call s:swap_lines(n, n - 1)
    exec n - 1
endfunction

function! s:swap_down()
    let n = line('.')
    if n == line('$')
        return
    endif
    call s:swap_lines(n, n + 1)
    exec n + 1
endfunction

func! WordProcessorMode()
    setlocal formatoptions=1
    setlocal noexpandtab
    map j gj
    map <Down> gj
    map k gk
    map <Up> gk
    setlocal spell spelllang=en_us
    set complete+=s
    set formatprg=par
    setlocal wrap
    setlocal linebreak
endfu
com! WP call WordProcessorMode()

func! DistractionFreeModeEnable()
    WP
    Goyo
    Limelight
endfu
com! DF call DistractionFreeModeEnable()

func! DistractionFreeModeDisable()
    Goyo
    Limelight!
endfu
com! DM call DistractionFreeModeDisable()

func! DayMode()
    color base16-gruvbox-light-hard
    AirlineTheme gotham
    let g:airline_theme='gotham'
endfu
com! Day call DayMode()

func! NightMode()
    color gotham
    AirlineTheme gotham
endfu
com! Night call NightMode()

func! PlaySound()
    silent! exec '!mpv --no-terminal ~/.vim/type/sound1.aiff &'
endfu

func! EnableSound()
    autocmd CursorMovedI * call PlaySound()
endfu
com! ClickOn call EnableSound()

func! DisableSound()
    autocmd! CursorMovedI
endfu
com! ClickOff call DisableSound()

func! Check()
    normal 0lvr€ýcâœ”€ýc0
endfu
nnoremap <Leader>a :call Check()<CR>

func! UnCheck()
    normal 0€krr 0
endfu
nnoremap <Leader>s :call UnCheck()<CR>

nnoremap <Leader>w :bn<CR>
nnoremap <Leader>q :bp<CR>

let g:material_style='oceanic'
colorscheme vim-material
let g:airline_theme='material'
