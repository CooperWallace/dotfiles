" ======================
" General/ Quality of Life
" ======================

set scrolloff =5
set autoindent
set number
set t_Co=256
syntax enable
set nocompatible
set backspace=indent,eol,start
set exrc
set tabstop=4
set shiftwidth=4
filetype plugin on
filetype indent on
set secure
set background=dark

set undofile
set undodir=~/.vim/misc/undo
set directory=$HOME/.vim/misc/swap//

" Remove all tralling whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" ======================
" Key Mapping
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

nmap <leader>lr <plug>(vimtex-env-change)

" ======================
" Plugins
" ======================

call plug#begin('~/.vim/plugged')
" Tools
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/Align'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-surround'
Plug 'Chiel92/vim-autoformat'

" Language Support
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go'
Plug 'lervag/vimtex'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Prose related
Plug 'abby-walz/bullet_journal'
Plug 'reedes/vim-pencil'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vimwiki/vimwiki'
Plug 'mattn/calendar-vim'

" Look and Feel
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'junegunn/goyo.vim'
Plug 'mikewest/vimroom'

" Color Schemes
Plug 'dikiaap/minimalist'                 " Minimalist Color Scheme
Plug 'morhetz/gruvbox'
call plug#end()

" ======================
" Prose / Notetaking
" ======================

" Markdown Rendering to file on save
"autocmd BufWritePost *.md !pandoc -H ~/.pandoc/header.tex -o ~/default.pdf "%:p"
" Automatically use SoftPencil when opening a markdown file
autocmd	BufNewFile,BufRead *.md SoftPencil

" =====================
" Functions
" =====================

function! SetMIPSOptions()
	setlocal filetype=mips
	setlocal tabstop=4
endfunction

autocmd BufNewFile,BufRead *.s call SetMIPSOptions()
" ======================
" Plugin Specific Options
" ======================

colorscheme gruvbox

map <C-o> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen =1

" Ctrl-J Expand snippets
let g:UltiSnipsExpandTrigger="<c-j>"

" F10 opens Goyo, Leaving resets colours
map <F10> :Goyo<CR>:SoftPencil<CR>
autocmd! User GoyoLeave
autocmd  User GoyoLeave nested set background=dark

" Add functionality to vim.surround for LaTeX delimiters.
" https://github.com/tpope/vim-surround/issues/47
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

" Remove Preview from YCM
set completeopt-=preview

" Use goimports instead of gofmt
if !exists("g:go_fmt_command")
	let g:go_fmt_command = "goimports"
endif

" Change Vertical to Horizontal Gitv
let Gitv_OpenHorizontal =1

" Status bar
set laststatus =2

let g:typescript_indent_disable =1

" Vimwiki is only usable in Google Drive folder.
let g:vimwiki_list = [{'path': '~/grive/vimwiki/personal', 'syntax': 'markdown', 'ext': '.md'}, {'path': '~/grive/vimwiki/work', 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext =0


