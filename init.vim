"        _____       _____
"        |   |       /   /
"        |   |      /   /
"        |   |     /   /
"        |   |    /   /
"        |   |   /   /
"        |   |  /   _
"        |   | /   |_|
"    _ _ |   |/   /___ _ _  __
"   | '_ \       / | || '_ ` _ \
"   | | | |     /  | || | | | | |
"   |_| |_|____/   |_||_| |_| |_|

" ---- Vim Plug ------------------------

call plug#begin('~/.config/nvim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'

call plug#end()

" ---- Functions -----------------------

function! ToggleSpell()
  if &spell
    set nospell
  else
    setlocal spell! spelllang=en_us
  endif
endfunction

function! StripTrailingWhitespaces()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

" ---- General Config ------------------

set secure
set showmode
set noswapfile
set number
set relativenumber
set nocursorline
set linebreak
set mouse=a
set colorcolumn=0
set updatetime=1000
set conceallevel=0
set showbreak=↳
set nowrap
set path=**
set listchars=tab:>-,trail:·
set fillchars+=vert:│
set list
set encoding=utf-8
set signcolumn=yes

" ---- Clipboard -----------------------

let g:clipboard = {
      \   'name': 'xclip-xfce4-clipman',
      \   'copy': {
      \      '+': 'xclip -selection clipboard',
      \      '*': 'xclip -selection clipboard',
      \    },
      \   'paste': {
      \      '+': 'xclip -selection clipboard -o',
      \      '*': 'xclip -selection clipboard -o',
      \   },
      \   'cache_enabled': 1,
      \ }

" ---- Indentation ---------------------

set cinoptions=g0,l1,i0
set smarttab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab

" ---- Autocommand ---------------------

au FileType make setlocal noexpandtab
au TermOpen * setlocal nonumber norelativenumber

" ---- Completion ----------------------

set wildmode=full
set wildignore=*.o,*.obj,*~
set wildignore+=*.swp,*.tmp
set wildignore+=*.mp3,*.mp4,*mkv
set wildignore+=*.bmp,*.gif,*ico,*.jpg,*.png
set wildignore+=*.pdf,*.doc,*.docx,*.ppt,*.pptx
set wildignore+=*.rar,*.zip,*.tar,*.tar.gz,*.tar.xz

" ---- Key Mapping ---------------------

" map leader
let mapleader=" "

" general
inoremap jj <Esc>
nnoremap Y y$
nnoremap gUiw mzgUiw`z
nnoremap guiw mzguiw`z
nnoremap <leader>r :so $MYVIMRC<CR>
nnoremap <silent> <F12> :call StripTrailingWhitespaces()<CR>

" window management
nnoremap <C-w>z :tab split<CR>
nnoremap <C-w>b <C-w>s

" toggle
nnoremap <silent> <leader>tm :let &mouse=strlen(&mouse)?'':'a'<CR>
nnoremap <silent> <leader>ts :call ToggleSpell()<CR>
nnoremap <leader>tt :term<CR>

" fzf
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fl :Buffers<CR>
nnoremap <leader>fc :Commands<CR>

" fugitive
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>

" terminal window navigation
tnoremap <Esc> <C-\><C-N>
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

" no arrow keys
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>
vnoremap <up>    <nop>
vnoremap <down>  <nop>
vnoremap <left>  <nop>
vnoremap <right> <nop>

" ---- Search --------------------------

set nohlsearch
set ignorecase
set smartcase

" ---- Folding -------------------------

set foldmethod=indent
set foldlevel=10
set foldcolumn=0

" ---- Colorscheme ---------------------

syntax on
set background=dark
set termguicolors
colo onedark

hi Normal       gui=NONE guibg=NONE
hi Folded       gui=NONE guibg=NONE      guifg=gray
hi LineNr       gui=NONE guibg=NONE      guifg=gray
hi CursorLineNr gui=NONE guibg=NONE      guifg=white
hi StatusLine   gui=NONE guibg=gray      guifg=black
hi StatusLineNC gui=NONE guibg=gray      guifg=black
hi TabLineFill  gui=NONE guibg=gray      guifg=black
hi TabLine      gui=NONE guibg=gray      guifg=black
hi TabLineSel   gui=NONE guibg=lightgray guifg=black
hi WildMenu     gui=NONE guibg=lightgray guifg=black
hi ColorColumn  gui=NONE guibg=#33373f   guifg=NONE
hi Visual       gui=NONE guibg=#3e4452   guifg=NONE
hi Whitespace   gui=NONE guibg=NONE      guifg=gray
hi EndOfBuffer  gui=NONE guibg=NONE      guifg=gray
hi VertSplit    gui=NONE guibg=NONE      guifg=gray
hi ModeMsg      gui=NONE guibg=NONE      guifg=lightgreen
hi WarningMsg   gui=NONE guibg=NONE      guifg=#E53935
hi MatchParen   gui=NONE guibg=NONE      guifg=lightred

let g:lisp_rainbow = 1
if &bg == "dark"
  hi def hlLevel0 ctermfg=red         guifg=springgreen1
  hi def hlLevel1 ctermfg=yellow      guifg=yellow1
  hi def hlLevel2 ctermfg=green       guifg=orange1
  hi def hlLevel3 ctermfg=cyan        guifg=greenyellow
  hi def hlLevel4 ctermfg=magenta     guifg=cyan1
  hi def hlLevel5 ctermfg=red         guifg=springgreen1
  hi def hlLevel6 ctermfg=yellow      guifg=yellow1
  hi def hlLevel7 ctermfg=green       guifg=orange1
  hi def hlLevel8 ctermfg=cyan        guifg=greenyellow
  hi def hlLevel9 ctermfg=magenta     guifg=cyan1
endif

" ---- Tabline ----------------------

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    let tabnr = i + 1 " range() starts at 0
    let winnr = tabpagewinnr(tabnr)
    let buflist = tabpagebuflist(tabnr)
    let bufnr = buflist[winnr - 1]
    let bufname = fnamemodify(bufname(bufnr), ':t')
    let s .= '%' . tabnr . 'T'
    let s .= (tabnr == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
    let s .= ' ' . tabnr . ' '
    let s .= empty(bufname) ? ' [No Name] ' : ' ' . bufname . ' '
    let bufmodified = getbufvar(bufnr, "&mod")
    if bufmodified | let s .= '[+] ' | endif
  endfor
  let s .= '%#TabLineFill#%=%999X'.' Tabs '
  return s
endfunction
set showtabline=1
set tabline=%!MyTabLine()

" ---- Statusline ----------------------
"

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '': printf(
    \   ' %d  %d',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

set laststatus=2
set statusline=%{&paste?'\ \ paste\ ':''}
set statusline+=\ %{expand('%:~:.')!=#''?expand('%:~:.'):'[No\ Name]'}
set statusline+=%{&readonly?'\ \ ':!&modifiable?'\ \ ':''}\ 
set statusline+=%{fugitive#head()!=#''?'\ \ '.fugitive#head().'\ ':''}
set statusline+=%=
set statusline+=%{&modified?'\ \ [+]':''}
set statusline+=%=
set statusline+=%{LinterStatus()!=#''?'\ '.LinterStatus().'\ ':''}
set statusline+=%<\ %{&filetype!=#''?&filetype:'none'}
set statusline+=\ %6(\ %p%%\ %)

" ---- Netrw ---------------------------

let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_browse_split=0
let g:netrw_liststyle=0
let g:netrw_sort_by='name'
let g:netrw_sort_direction='normal'
let g:netrw_winsize=25
let g:netrw_list_hide = '^\./$,^\../$,^\.git/$'
let g:netrw_hide = 1
let g:netrw_cursor=0

" ---- Ultisnips -----------------------

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-j>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir='~/.vim/bundle/vim-snippets/UltiSnips/'

" ---- Gitgutter -----------------------

set updatetime=250
let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='┃'
let g:gitgutter_sign_removed_first_line='┃'
let g:gitgutter_sign_modified_removed='┃'

" ---- Ale Linter ----------------------

let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_set_highlights = 0
let g:ale_sign_warning = ''
let g:ale_sign_error = ''

exec 'hi ALEErrorSign guifg=#EC5f67 ctermfg=red' .
      \' guibg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'gui') .
      \' ctermbg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'cterm')
exec 'hi ALEWarningSign guifg=yellow ctermfg=yellow' .
      \' guibg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'gui') .
      \' ctermbg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'cterm')
