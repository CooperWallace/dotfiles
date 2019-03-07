" vim: set fdm=marker:
" General/ Quality of Life {{{
set nocompatible 	" Disable Vi options
set exrc			" Use Settings in current dir

set scrolloff =5
set autoindent
set number
set tabstop=4
set shiftwidth=4
set t_Co=256

set tw=80 " Line width

set scrolloff=5		" Always show 5 lines

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

" }}}
" Key Mapping {{{

" Sudo Save
cmap w!! w !sudo tee > /dev/null %

command! Q q " Bind :Q to :q
command! W w " Bind :W to :w

" Navigation Keys
noremap <C-Left> :tabprevious<CR>
noremap <C-Right> :tabnext<CR>
noremap <C-n> :tabnew<CR>

" Navigation to beginning / end of lines
noremap H 0 
noremap L $

" Move Tabs left/right using Alt
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>

" Return to normal mode when pressing jj
" Avoid pressing escape which is out of the way
" From 'Learn Vimscript the hard way'.
inoremap jk <esc>
inoremap JK <esc>

" Fix paste bug triggered by the above inoremaps
" https://github.com/johndgiese/dotvim/issues/4
set t_BE=

" Change the surrounding LaTeX environment
nmap <leader>lr <plug>(vimtex-env-change)

" On the fly rc editing, and sourcing
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ss :call UltiSnips#RefreshSnippets()<cr>

" Operation-Pending Mappings
" http://learnvimscriptthehardway.stevelosh.com/chapters/15.html

" Inside next parentheses
onoremap in( :<c-u>normal! f(vi)<cr>

" Fix next spelling correction
nnoremap <leader>sc ]s1z=

" }}}
" Plugins {{{

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
"Plug 'leafgarland/typescript-vim'
"Plug 'fatih/vim-go'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vivien/vim-linux-coding-style'
Plug 'nathanaelkane/vim-indent-guides'

" Prose related
Plug 'reedes/vim-pencil'				" Wrap line properly, Writing in VIM
Plug 'vim-pandoc/vim-pandoc'			" Pandoc Options
Plug 'vimwiki/vimwiki'					" Personal Wiki
Plug 'lervag/vimtex'					" LaTeX extension
Plug 'reedes/vim-litecorrect'			" Fix common typos
Plug 'panozzaj/vim-autocorrect'			" Larger Typo corrections
Plug 'kana/vim-textobj-user'			" textobj-sentence dep
Plug 'reedes/vim-textobj-sentence'		" Treat senteces as text objects

" Look and Feel
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'junegunn/goyo.vim'
Plug 'mikewest/vimroom'

" Color Schemes
Plug 'dikiaap/minimalist'                 " Minimalist Color Scheme
Plug 'morhetz/gruvbox'
call plug#end()

" }}}
" Notetaking {{{

" Markdown Rendering to file on save
"autocmd BufWritePost *.md !pandoc -H ~/.pandoc/header.tex -o ~/default.pdf "%:p"

function! Notetaking()
	" Pencil with Soft line breaks
	call pencil#init({"wrap" : "soft"})

	" Disable item character coneal
	setlocal conceallevel=2
	" Disable numbers, not needed
	setlocal nonumber
	setlocal spell spelllang=en_us

	" Enable vimtex usage in Markdown files.
	call vimtex#init()
	call litecorrect#init()
	call textobj#sentence#init()
	" Great plugin, but slows down load.
	" call AutoCorrect()
endfunction

autocmd BufNewFile,BufRead *.md call Notetaking()

" Open Goyo and call Notetaking function to fix conceal of listing bullets
map <F10> :Goyo<CR>:call Notetaking()<CR>

augroup GoyoBGFix
	" Reset colorscheme when leaving Goyo
	autocmd! User GoyoLeave
	autocmd  User GoyoLeave nested set background=dark
augroup END

" }}}
" Plugin Settings {{{1
colorscheme gruvbox 					" Use Gruvbox Colour Scheme

" NERD Tree {{{2
" Map openning NERDTree to Ctrl-O
noremap <C-o> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen =1				" Don't close pane after opening file
" }}}2

" Vim-Surround {{{2
" Add functionality to vim.surround for LaTeX delimiters.
" https://github.com/tpope/vim-surround/issues/47
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

" Add surround for markdown bold **word**
let g:surround_{char2nr('o')} = "**\r**"
" }}}2

" Go Format {{{2
if !exists("g:go_fmt_command")
	let g:go_fmt_command = "goimports"	" Use goimports instead of gofmt
endif
" }}}2

"Gitv {{{2
let Gitv_OpenHorizontal =1 				" Change Vertical to Horizontal Gitv
"}}} 2

" Typescript {{{2
let g:typescript_indent_disable =1		" Disable autoindent in Typescript
" }}}2

" {{{2 Pandoc
" Use hard break for writing, and 80 char limit
let g:pandoc#formatting#mode="h"
let g:pandoc#formatting#textwidth=80
" }}}2

" YCM / Ultisnippets {{{2

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

let g:UltiSnipsSnippetDirectories=["~/.vim/UltiSnips/", "UltiSnips"]
" }}}2

" Vimwiki {{{2

let g:vimwiki_global_ext =0 " Disable vimwiki in all folders
" Vimwiki is only usable in Google Drive folder.
let g:vimwiki_list = [
			\{'path': '~/grive/vimwiki/personal', 'syntax': 'markdown', 'ext': '.md'},
			\{'path': '~/grive/vimwiki/work', 'syntax': 'markdown', 'ext': '.md'}
			\]

" }}}2
" }}}1
