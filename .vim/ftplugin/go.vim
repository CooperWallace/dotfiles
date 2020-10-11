" vim: set fdm=marker:
"

" Syntax Highlighting {{{
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" }}}

" Key Mappings {{{

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
nmap <leader>r  <Plug>(go-run)
nmap <leader>rn <Plug>(coc-rename)

" Error checking

nnoremap <leader>a :cclose<CR>
"}}}
