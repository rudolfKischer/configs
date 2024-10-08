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
set spelllang=en_us
set spell
set signcolumn=yes


":au VimEnter * hi Normal ctermbg=
colorscheme gruvbox
set t_Co=256
set background=dark

let g:airline_theme = 'gruvbox'
let g:gruvbox_contrast_dark = 'hard'
let g:airline#extensions#gitgutter#enabled = 1
let g:airline#extensions#branch#enabled = 1

autocmd User StartifyReady setlocal textwidth=0
autocmd User StartifyReady setlocal wrap
autocmd User StartifyReady setlocal winwidth=9999
let g:startify_fortune_use_unicode = 0
let g:startify_lists = [
  \ { 'type': 'files',     'header': ['   Recently used files'] },
  \ { 'type': 'dir',       'header': ['   Files in current directory '. getcwd()] },
  \ { 'type': 'sessions',  'header': ['   Sessions'] },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks'] },
  \ ]
let g:startify_session_persistence = 1

let g:gitgutter_signs = 1  " Ensure signs are displayed
let g:gitgutter_override_sign_column_highlight = 0  " Keep it consistent with your theme

function! StartifyHelloWorld()
    let l:fonts = ['Blocks', 'Bloody', 'Roman', '3d', 'Rebel', 'Electronic', 'Elite', 'Knob', 'Sub-Zero', 'THIS', 'Slant', 'Twisted', 'doom', 'epic', 'flowerpower', 'halfiwi', 'rounded']
    let l:random_font = l:fonts[rand() % len(l:fonts)]
    let l:splashtext = readfile(expand('~/.configs/.splashtext'))
    let l:text = empty(l:splashtext) ? 'No splash text available' : l:splashtext[rand() % len(l:splashtext)]
    let l:termwidth = winwidth(0)
    let l:padding = repeat('=', (l:termwidth - len(l:text) - 2) / 2)
    let l:centered_text = l:padding . ' ' . l:text . ' ' . l:padding
    let l:figlet_output = system('figlet -w ' . l:termwidth . ' -f ' . shellescape(l:random_font) . ' "Welcome Home" | lolcat -F 0.08 -a -d 1')
    let l:combined_output = l:figlet_output . "\n\n" . l:centered_text
    return split(l:combined_output, "\n")
endfunction

" Highlight the splash text with bold style
autocmd User StartifyReady highlight StartifyFooter guifg=White guibg=NONE cterm=bold

autocmd VimResized * call StartifyRedraw()

function! StartifyRedraw()
    if &filetype == 'startify'
        Startify
    endif
endfunction

" Set the custom header for vim-startify
let g:startify_custom_header = 'StartifyHelloWorld()'






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



nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>
