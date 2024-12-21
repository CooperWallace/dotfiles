require("config.options")
require("config.mapping")
require("config.lazy")

vim.cmd([[colorscheme gruvbox]])

vim.g.remove_whitespace = 1

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Remove trailing Whitespace on save",
    pattern = "*",
    callback = function()
    if vim.g.remove_whitespace == 1 then
        vim.cmd([[%s/\s\+$//e]])
    end
end
})

local function UseNearestParentTagsFile()
    local path = vim.fn.expand("%:p")
    while path ~= "/" do
        path = vim.fn.fnamemodify(path, ":h")
        local tags_path = path .. "/tags"
        if vim.fn.filereadable(tags_path) == 1 then
            vim.opt.tags = tags_path
            return
        end
    end
    vim.fn.echo("No tags file found in path.", false)
end

vim.cmd("command! -nargs=0 UseNearestParentTagsFile :call UseNearestParentTagsFile()")
vim.api.nvim_set_keymap("n", "<leader>st", "<cmd>UseNearestParentTagsFile<cr>", { noremap = true, silent = true })

vim.cmd([[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

" General {{{

set mouse=

" }}}


" Running older vim
let g:coc_disable_startup_warning = 1

" setting with vim-lsp
if executable('ccls')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'ccls',
      \ 'cmd': {server_info->['ccls']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(
      \   lsp#utils#find_nearest_parent_file_directory(
      \     lsp#utils#get_buffer_path(), ['.ccls', 'compile_commands.json', '.git/']))},
      \ 'initialization_options': {
      \   'highlight': { 'lsRanges' : v:true },
      \   'cache': {'directory': stdpath('cache') . '/ccls' },
      \ },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif

" c++ syntax highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

]])
