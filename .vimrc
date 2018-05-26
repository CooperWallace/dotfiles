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
" Bind Q W to save quit
command! Q q " Bind :Q to :q
command! W w " Bind :W to :w
" Navigation Keys
map <C-Left> :tabprevious<CR>
map <C-Right> :tabnext<CR>
map <C-n> :tabnew<CR>
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

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
" Auto complete with function prototypes
Plug 'Valloric/YouCompleteMe'

" Tool Support
Plug 'tpope/vim-fugitive'                 " Git support
Plug 'gregsexton/gitv', {'on': ['Gitv']}  " Git log support

Plug 'mhinz/vim-startify'

" Language Support
Plug 'leafgarland/typescript-vim'         " Typescript Syntax support
Plug 'fatih/vim-go'                       " Golang development plugin
Plug 'lervag/vimtex'                      " LaTeX plugin
Plug 'abby-walz/bullet_journal'           " Bullet Journal Plugin
Plug 'reedes/vim-pencil'                  " Vim Writing plugin
Plug 'Chiel92/vim-autoformat'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'vimwiki/vimwiki'

" Theme and Color Schemes
Plug 'junegunn/goyo.vim'                  " Distraction free editting
Plug 'dikiaap/minimalist'                 " Minimalist Color Scheme
Plug 'morhetz/gruvbox'
call plug#end()


" ======================
" Theme Specific
" ======================
set background =dark " Needed for Tmux
colorscheme gruvbox

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
"autocmd BufWritePost *.md !pandoc -H ~/.pandoc/header.tex -o ~/default.pdf "%:p"

" Automatically use SoftPencil when opening a markdown file
autocmd	BufNewFile,BufRead *.md SoftPencil

" MIPS
autocmd BufNewFile,BufRead *.s call SetMIPSOptions()

function SetMIPSOptions()
	setlocal filetype=mips
	setlocal tabstop=4
endfunction


" ======================
" Plugin Specific Options
" ======================
" NERD Tree
map <C-o> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen =1

"Better next placeholder
"if !exists("g:UltiSnipsJumpForwardTrigger")
"	let g:UltiSnipsJumpForwardTrigger = "<tab>"
"endif
let g:UltiSnipsExpandTrigger="<c-j>"


" Remove Preview from YCM
set completeopt-=preview

" Golang: Use goimports instead of gofmt
if !exists("g:go_fmt_command")
	let g:go_fmt_command = "goimports"
endif
" Gitv Horizontal display
let Gitv_OpenHorizontal =1 

" Airline
set laststatus =2

" Disable Typescript Vim indent
let g:typescript_indent_disable =1

" vimwiki options for gdrive folder
let g:vimwiki_list = [{'path': '~/grive/vimwiki/personal', 'syntax': 'markdown', 'ext': '.md'}, {'path': '~/grive/vimwiki/work', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext =0
