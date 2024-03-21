" vim: set fdm=marker:
" General/ Quality of Life {{{
call has('python3')
set nocompatible 	" Disable Vi options
set exrc			" Use Settings in current dir

set scrolloff =5
set autoindent
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set t_Co=256

set mouse=

set foldcolumn=0

set tw=80 " Line width

set scrolloff=5		" Always show 5 lines

syntax on
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

" Fix paste bug triggered by the above inoremaps
" https://github.com/johndgiese/dotvim/issues/4
set t_BE=

" Stop command window from popping u
map q: :q

" simple pasting from the system clipboard
" http://tilvim.com/2014/03/18/a-better-paste.html
map <Leader>p :set paste<CR>o<esc>:r!xclip -o<cr>:set nopaste<cr>


" Enable Shift + Arrow keys in TMUX windows
if &term =~ '^screen'
	" tmux will send xterm-style keys when its xterm-keys option is on
	execute "set <xUp>=\e[1;*A"
	execute "set <xDown>=\e[1;*B"
	execute "set <xRight>=\e[1;*C"
	execute "set <xLeft>=\e[1;*D"
endif


set expandtab
" Causes issues with cscope / fzf
" set autochdir

" }}}
" Key Mapping {{{

" Disable Mode
nnoremap Q <nop>
nmap <F1> <nop>

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

" Change the surrounding LaTeX environment
nmap <leader>lr <plug>(vimtex-env-change)

" On the fly rc editing, and sourcing
nnoremap <leader>ev :tabnew $MYVIMRC<cr>:vsplit ~/.vimrc<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>:source ~/.vimrc<cr>
nnoremap <leader>es :UltiSnipsEdit<cr>
nnoremap <leader>ss :call UltiSnips#RefreshSnippets()<cr>

" Operation-Pending Mappings
" http://learnvimscriptthehardway.stevelosh.com/chapters/15.html

" Inside next parentheses
onoremap in( :<c-u>normal! f(vi)<cr>

" Fix next spelling correction
nnoremap <leader>sc ]s1z=

" Map $ binds to m
nnoremap dm O\[<ESC>j>>o<BS>\]<ESC>k
nmap csm cs$
nmap dsm ds$
nmap dam da$
nmap dim di$
nmap cim ci$
nmap cam ca$
nmap vim vi$
nmap vam va$


nnoremap <silent> <F8> :TlistToggle<CR>


" }}}
" Plugins {{{

call plug#begin('~/.vim/plugged')
" Tools
Plug 'junegunn/vim-easy-align'
Plug 'honza/vim-snippets'
Plug 'sankhesh/gitv'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'

Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

Plug 'neovim/nvim-lspconfig'

Plug 'github/copilot.vim'

" Language Support
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'bfrg/vim-cpp-modern'

" Code Navigation
Plug 'hari-rangarajan/CCTree'
Plug 'vim-scripts/taglist.vim'
Plug 'antiagainst/cscope-macros.vim'
Plug 'tpope/vim-surround'
Plug 'preservim/tagbar'

" Git Support
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'airblade/vim-gitgutter'

Plug 'nathanaelkane/vim-indent-guides'

Plug 'junegunn/fzf', {'do': {-> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Prose related
Plug 'vimwiki/vimwiki'					" Personal Wiki
Plug 'reedes/vim-litecorrect'			" Fix common typos
Plug 'panozzaj/vim-autocorrect'			" Larger Typo corrections
Plug 'kana/vim-textobj-user'			" textobj-sentence dep
Plug 'reedes/vim-textobj-sentence'		" Treat senteces as text objects

" Color Schemes
Plug 'flazz/vim-colorschemes' 			" One color scheme plugin to rule them all
call plug#end()

" }}}
" Custom Functions {{{

" Remove all tralling whitespace on save.
" Check if "g:remove_whitespace" is set as a way to disable when needed

let g:remove_whitespace = 1

func! IsWhitespace()
	if exists("g:remove_whitespace") &&  g:remove_whitespace == 1
			%s/\s\+$//e
	endif
endfunc


autocmd BufWritePre * call IsWhitespace()


function! UseNearestParentTagsFile()
  let l:path = "%:p"
  while expand(l:path) != "/"
    let l:path = l:path . ":h"
    if filereadable(expand(l:path) . "/tags")
      exe "set tags=" . expand(l:path) . "/tags"
      return
    endif
  endwhile
  echom "No tags file found in path."
endfunction
command! UseNearestParentTagsFile call UseNearestParentTagsFile()
nnoremap <leader>st :UseNearestParentTagsFile<cr>



" }}}
" Plugin Settings {{{1
augroup my_colours
  autocmd!
  autocmd ColorScheme gruvbox hi SpellBad cterm=reverse ctermfg=red
augroup END
colorscheme gruvbox 					" Use Gruvbox Colour Scheme

" vimtex{{{2
let g:tex_flavor = 'latex'
" }}}2

" Telescope File Browser {{{2
" Map openning NERDTree to Ctrl-O
noremap <leader>o :Telescope file_browser<CR>
noremap <leader>O :Telescope file_browser path=%:p:h select_buffer=true<CR>

" }}}2

" Vim-Surround {{{2
" Add functionality to vim.surround for LaTeX delimiters.
" https://github.com/tpope/vim-surround/issues/47
	let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

	let b:surround_{char2nr("e")} = "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"

" markdown bold **word**
	let g:surround_{char2nr('o')} = "**\r**"
" Bolded and Underlined. Sub title
	let g:surround_{char2nr('t')} = "**\\underline{\r}**"
" Underline
	let g:surround_{char2nr('u')} = "\\underline{\r}"
	let b:surround_{char2nr('U')} = "\\underbrace{\r}"
" }}}2

" Go Format {{{2
if !exists("g:go_fmt_command")
	let g:go_fmt_command = "goimports"	" Use goimports instead of gofmt
endif
" }}}2

" vim-go {{{2
"let g:go_def_mapping_enabled = 0

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
" }}}2

" Typescript {{{2
let g:typescript_indent_disable =1		" Disable autoindent in Typescript
" }}}2

" {{{2 Pandoc
" Use hard break for writing, and 80 char limit
let g:pandoc#formatting#mode="h"
let g:pandoc#formatting#textwidth=80

" Better folds
" let g:pandoc#folding#fold_yaml = 1
let g:pandoc#folding#mode = "relative"

" Disable fold column for pandoc
let g:pandoc#folding#fdc = 0
" }}}2

" coc.nvim and extensions {{{2

nmap <leader>rn <Plug>(coc-rename)
" Load on cpp filetype
autocmd FileType cpp nnoremap <leader>lh :CocCommand clangd.switchSourceHeader<CR>


" coc.snippets {{{3
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
let g:coc_disable_startup_warning = 1

imap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#rpc#request('doKeymap', 'snippets-expand')

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" To make completion works like VSCode
inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'
"}}}3


" }}}2

" Vimwiki {{{2

let g:vimwiki_global_ext =0 " Disable vimwiki in all folders
" Vimwiki is only usable in Google Drive folder.
let g:vimwiki_list = [
			\{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md', 'diary_frequency': 'weekly'}
			\]

" let g:vimwiki_folding = 'custom'

" }}}2

" Bullets.vim {{{2

" Disable indent changiindent changing bullet type
let g:bullets_outline_levels=['ROM', 'ABC', 'num', 'abc', 'rom', 'std-']
" }}}2


" fzf.vim {{{2

nmap <leader>ff :FZF -i <enter>
nmap <leader>rg :RG<enter>
nmap <leader>fh :History<enter>
nnoremap <silent> <Leader>ft :Tags <C-R><C-W><CR>
nnoremap <silent> <Leader>Rg :RG <C-R><C-W><CR>
nnoremap <silent> <Leader>ag :Ag<CR>
nnoremap <silent> <Leader>Ag :Ag <C-R><C-W><CR>


" }}}2

" }}}1

" vimwiki
function! VimwikiFoldLevelCustom(lnum)
	let pounds = strlen(matchstr(getline(a:lnum), '^#\+'))
	if (pounds)
		return '>' . pounds  " start a fold level
	endif
	if getline(a:lnum) =~? '\v^\s*$'
		if (strlen(matchstr(getline(a:lnum + 1), '^#\+')))
			return '-1' " don't fold last blank line before header
		endif
	endif
	return '=' " return previous fold level
endfunction


augroup VimrcAuGroup
	autocmd FileType vimwiki set foldexpr=VimwikiFoldLevelCustom(v:lnum)
	autocmd FileType vimwiki setlocal foldmethod=expr
augroup END

autocmd FileType gitcommit setlocal spell
