" ======================
" General/ Quality of Life
" ======================
set scrolloff =5
set autoindent
set number
set t_Co=256
syntax enable 

set tabstop =4
set shiftwidth =4

filetype plugin on
filetype indent on

" Maintain undo history between sessions
set undofile
set undodir=~/.vim/misc/undo

" Move swap files to a seperate directory for
" cleaner working directories
set directory=$HOME/.vim/misc/swap//


" ======================
" Set Key Bindings
" ======================

" Sudo Save
cmap w!! w !sudo tee > /dev/null %

" Navigation Keys
map <C-Left> :tabprevious<CR>
map <C-Right> :tabnext<CR>
map <C-n> :tabnew<CR>


" ======================
" Begin loading Plugins
" ======================
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/leafgarland/typescript-vim.git' "TS Syntax
Plug 'https://github.com/scrooloose/nerdtree' " File Browser
Plug 'https://github.com/tpope/vim-fugitive' " Git support
Plug 'vim-airline/vim-airline' " Airline

Plug 'gregsexton/gitv', {'on': ['Gitv']} " Git log support

Plug 'fatih/vim-go'

Plug 'lervag/vimtex'

" Theme Specific
Plug 'https://github.com/junegunn/goyo.vim'

" Custom Color Schemes
Plug 'dikiaap/minimalist' " Minimalist Color Scheme
Plug 'morhetz/gruvbox'
call plug#end()


" ======================
" Theme Specific
" ======================
set background =dark " Needed for Tmux

" ======================
" Plugin Specific Options
" ======================
map <C-o> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen =1
"Gitv Horizontal display
let Gitv_OpenHorizontal =1 

" Airline status bar
set laststatus =2

"Disable Typescript Vim indent
let g:typescript_indent_disable =1
