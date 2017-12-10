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
Plug 'vim-scripts/Align'                  " Alignment plugin
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'jiangmiao/auto-pairs'				  " Auto close pairs of brackets

" Ultisnips and the snippet files
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Tool Support
Plug 'tpope/vim-fugitive'                 " Git support
Plug 'gregsexton/gitv', {'on': ['Gitv']}  " Git log support

" Language Support
Plug 'leafgarland/typescript-vim'         " Typescript Syntax support
Plug 'fatih/vim-go'                       " Golang development plugin
Plug 'lervag/vimtex'                      " LaTeX plugin
Plug 'abby-walz/bullet_journal'           " Bullet Journal Plugin
Plug 'reedes/vim-pencil'                  " Vim Writing plugin

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Theme and Color Schemes
Plug 'junegunn/goyo.vim'                  " Distraction free editting
Plug 'dikiaap/minimalist'                 " Minimalist Color Scheme
Plug 'morhetz/gruvbox'
call plug#end()


" ======================
" Theme Specific
" ======================
set background =dark " Needed for Tmux

" Goyo Background workaround
" Without the light theme will be applied on exit
autocmd! User GoyoLeave
autocmd  User GoyoLeave nested set background=dark


" ======================
" Notetaking Options
" ======================

" Markdown Rendering to file on save
" 	Output to a default file, so that we don't have a bunch of pdf files
" 	everywhere (~/default.pdf)
autocmd BufWritePost *.md !pandoc -o ~/default.pdf "%:p"

" Automatically use SoftPencil when opening a markdown file
autocmd	BufNewFile,BufRead *.md SoftPencil


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
