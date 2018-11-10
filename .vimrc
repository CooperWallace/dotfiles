" ================ General/ Quality of Life ========
set nocompatible 	" Disable Vi options
set exrc			" Use Settings in current dir

set scrolloff =5
set autoindent
set number
set tabstop=4
set shiftwidth=4
set t_Co=256

syntax enable
filetype plugin on
filetype indent on
set secure
set background=dark
set backspace=indent,eol,start
set laststatus =2 " Status bar

" Persistent undo between sessions
set undofile
set undodir=~/.vim/misc/undo
set directory=$HOME/.vim/misc/swap//

" Remove all tralling whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" ================ Key Mapping ====================
" ================ General/ Quality of Life ========

" Sudo Save
cmap w!! w !sudo tee > /dev/null %

command! Q q " Bind :Q to :q
command! W w " Bind :W to :w

" Navigation Keys
noremap <C-Left> :tabprevious<CR>
noremap <C-Right> :tabnext<CR>
noremap <C-n> :tabnew<CR>

" Move Tabs left/right using Alt
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" Return to normal mode when pressing jj
" Avoid pressing escape which is out of the way
" From 'Learn Vimscript the hard way'.
inoremap jk <esc>

" Change the surrounding LaTeX environment
nmap <leader>lr <plug>(vimtex-env-change)


" ================ Plugins =======================

call plug#begin('~/.vim/plugged')
" Tools
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/Align'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe'
Plug 'tpope/vim-surround'
Plug 'Chiel92/vim-autoformat'
Plug '907th/vim-auto-save'				" Autosave on Insertion change
Plug 'ctrlpvim/ctrlp.vim'

" Language Support
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go'
Plug 'lervag/vimtex'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vivien/vim-linux-coding-style'
Plug 'nathanaelkane/vim-indent-guides'

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


" ================ Notetaking ====================

" Markdown Rendering to file on save
"autocmd BufWritePost *.md !pandoc -H ~/.pandoc/header.tex -o ~/default.pdf "%:p"

" Toggle SoftPencil when opening a markdown file
autocmd	BufNewFile,BufRead *.md SoftPencil

" Enable vimtex usage in Markdown files.
autocmd	BufNewFile,BufRead *.md call vimtex#init()

" F10 opens Goyo, Leaving resets colours
map <F10> :Goyo<CR>:SoftPencil<CR>

" Reset colorscheme when leaving Goyo
autocmd! User GoyoLeave
autocmd  User GoyoLeave nested set background=dark


" ================ Plugin Settings ==============
"
colorscheme gruvbox 					" Use Gruvbox Colour Scheme

" Map openning NERDTree to Ctrl-O
noremap <C-o> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen =1				" Don't close pane after opening file

" Add functionality to vim.surround for LaTeX delimiters.
" https://github.com/tpope/vim-surround/issues/47
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

if !exists("g:go_fmt_command")
	let g:go_fmt_command = "goimports"	" Use goimports instead of gofmt
endif

let Gitv_OpenHorizontal =1 				" Change Vertical to Horizontal Gitv

let g:typescript_indent_disable =1		" Disable autoindent in Typescript


" === YCM / Ultisnippets ====

" Remove Preview window from YCM
set completeopt-=preview

" make YCM compatible with UltiSnips (using supertab), by
" removing the default <tab> binding
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Expand UltiSnippets by using the <tab> key
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" === Vimwiki ===

let g:vimwiki_global_ext =0 " Disable vimwiki in all folders
" Vimwiki is only usable in Google Drive folder.
let g:vimwiki_list = [
			\{'path': '~/grive/vimwiki/personal', 'syntax': 'markdown', 'ext': '.md'},
			\{'path': '~/grive/vimwiki/work', 'syntax': 'markdown', 'ext': '.md'}
			\]


