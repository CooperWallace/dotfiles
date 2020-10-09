" Taken from Pro Vim book
" Underline mis-spelling or words that need capitalization
" No colors to minimize distraction
fun! SetSpellingColors()
	highlight SpellBad cterm=underline
	highlight SpellCap cterm=underline
endfun

" Pencil with Soft line breaks
" call pencil#init({"wrap" : "soft"})

" Remove autosuggestions to avoid distractions while writing
let b:coc_suggest_disable = 1


set textwidth=80
" Disable item character coneal
setlocal conceallevel=2
" Disable numbers, not needed
setlocal nonumber
setlocal spell spelllang=en_us

call SetSpellingColors()

let g:vimtex_imaps_leader = "'"

" Enable vimtex usage in Markdown files.
call vimtex#init()
call litecorrect#init()
call textobj#sentence#init()
" Great plugin, but slows down load.
" call AutoCorrect()

syntax enable



" Open Goyo and call Notetaking function to fix conceal of listing bullets
map <F10> :Goyo<CR>:call Notetaking()<CR>

augroup GoyoBGFix
	" Reset colorscheme when leaving Goyo
	autocmd! User GoyoLeave
	autocmd  User GoyoLeave nested set background=dark
augroup END



