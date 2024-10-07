" show line numbers
set number

" Status bar
set laststatus=2

set nocompatible


"enable mouse support"
set mouse=a
"nnoremap <LeftMouse> <LeftMouse>i"


" automatically wrap
set nowrap

"  encoding
set encoding=utf-8


" call the .vimrc.plug
if filereadable(expand("~/.vimrc.plug"))
	source ~/.vimrc.plug
endif

filetype plugin indent on
if has("syntax")
	syntax on
endif

"highlight current line"
set cursorline
:highlight Cursorline cterm=bold ctermbg=black

"enable highlight search pattern"
set hlsearch

"case sensitive search"
set ignorecase
set smartcase
set incsearch




set clipboard=unnamedplus






" Mapping Shift + ZZ in insert mode to save and quit
inoremap ZZ <Esc>:wq<CR>

" Mapping Shift + ZZ in visual mode to save and quit
vnoremap ZZ <Esc>:wq<CR>

" Mapping Shift + ZZ in normal mode to save and quit (although ZZ already does this)
nnoremap ZZ :wq<CR>


set history=1000


inoremap jj <esc>

"set popup style completion"
set wildmenu
set wildmode=longest:full,full

colorscheme retrobox

vnoremap <Space> <Esc>i


"fuzzy file finding"
set path+=**

command! MakeTags !ctags -R




vnoremap <C-c> "+y


let g:netrw_banner=0 "disables banner"
let g:netrw_browse_split=4 "open in prior window"
let g:netrw_altv=1 "open splits to the right"
let g:netrw_liststyle=3 "tree view"
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

set noswapfile

set colorcolumn=80
