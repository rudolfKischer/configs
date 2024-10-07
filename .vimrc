" Source external vimrc for plugins
if filereadable(expand("~/.vimrc.plug"))
  source ~/.vimrc.plug   " Load additional plugin config from .vimrc.plug
endif

set number              " Enable line numbers
set laststatus=2        " Enable status bar at the bottom
set nocompatible         " Disable Vi compatibility mode
set mouse=a             " Enable mouse support
set nowrap              " Disable automatic line wrapping
set encoding=utf-8      " Set file encoding to UTF-8
set cursorline          " Enable highlighting of the current line
set hlsearch            " Enable highlight search pattern
set ignorecase          " Ignore case while searching
set smartcase           " Override ignorecase if uppercase is used in search
set incsearch           " Incremental search as you type
set clipboard=unnamedplus " Use system clipboard for yank and paste
set history=1000        " Set command history length
set wildmenu            " Enable popup style completion
set wildmode=longest:full,full " Tab completion behavior
set noswapfile          " Disable swap files
set colorcolumn=100      " Highlight column 80 for better readability
set undofile              " Save undo history to a file
set undodir=~/.vim/undodir " Directory to store undo files
set undolevels=1000       " Number of undo levels to store
set undoreload=10000      " Maximum number of lines to reload for undo

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set showmatch


":au VimEnter * hi Normal ctermbg=
colorscheme gruvbox
"set t_Co=256
set background=dark

let g:airline_theme = 'gruvbox'
let g:gruvbox_contrast_dark = 'hard'

" Plugin and filetype-related settings
filetype plugin indent on  " Enable filetype detection, plugins, and indentation
if has("syntax")
  syntax on              " Enable syntax highlighting if supported
endif

" Highlight current line settings
:highlight Cursorline cterm=bold ctermbg=black " Customize cursorline appearance

" auto save on text change
autocmd TextChanged,TextChangedI * silent! write


" Mapping keys
inoremap ZZ <Esc>:wq<CR>      " Mapping Shift + ZZ in insert mode to save and quit
vnoremap ZZ <Esc>:wq<CR>      " Mapping Shift + ZZ in visual mode to save and quit
nnoremap ZZ :wq<CR>           " Mapping Shift + ZZ in normal mode to save and quit

inoremap jj <esc>             " Map 'jj' to escape insert mode
vnoremap <C-c> "+y            " Map Ctrl+C in visual mode to copy to system clipboard
vnoremap <Space> <Esc>i       " Map Space in visual mode to escape and go into insert mode

" Fuzzy file finding and other commands
set path+=**                  " Enable fuzzy file finding
command! MakeTags !ctags -R    " Create ctags for project

" Netrw settings for file browsing
let g:netrw_banner=0          " Disable netrw banner
let g:netrw_browse_split=4     " Open files in previous window
let g:netrw_altv=1            " Open vertical splits to the right
let g:netrw_liststyle=3        " Use tree view in netrw
let g:netrw_list_hide=netrw_gitignore#Hide() " Hide files listed in .gitignore
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+' " Hide hidden files in netrw


" Tab to navigate completion or insert tab if no menu is visible
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Enter to confirm completion or insert a new line if no menu is visible
inoremap <silent><expr> <CR> pumvisible() ? coc#pum#confirm() : "\<CR>"
