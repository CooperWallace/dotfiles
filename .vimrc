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

" Compile single file C Program
map <F8> :w <CR> :!clear <CR>:!gcc -Wall -ansi % -o %< && ./%<<CR>


" ======================
" Begin loading Plugins
" ======================
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'                " File Browser
Plug 'vim-airline/vim-airline'            " Airline
Plug 'vim-scripts/Align'                  " Alignment plugin

" Tool Support
Plug 'tpope/vim-fugitive'                 " Git support
Plug 'gregsexton/gitv', {'on': ['Gitv']}  " Git log support

" Language Support
Plug 'leafgarland/typescript-vim'         " Typescript Syntax support
Plug 'fatih/vim-go'                       " Golang development plugin
Plug 'lervag/vimtex'                      " LaTeX plugin

" Theme and Color Schemes
Plug 'junegunn/goyo.vim'                  " Distraction free editting
Plug 'dikiaap/minimalist'                 " Minimalist Color Scheme
Plug 'morhetz/gruvbox'
call plug#end()


" ======================
" Theme Specific
" ======================
set background =dark " Needed for Tmux


" ======================
" Plugin Specific Options
" ======================
" NERD Tree
map <C-o> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen =1

" Gitv Horizontal display
let Gitv_OpenHorizontal =1 

" Airline
set laststatus =2

" Disable Typescript Vim indent
let g:typescript_indent_disable =1
