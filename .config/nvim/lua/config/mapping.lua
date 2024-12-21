--  Disable Mode
vim.keymap.set('n', 'Q', '', { noremap = true, silent = true })
vim.keymap.set('n', '<F1>', '')

-- " Sudo Save
vim.keymap.set('c', 'w!!', 'w !sudo tee > /dev/null %')

-- command! Q q " Bind :Q to :q
-- command! W w " Bind :W to :w

vim.keymap.set('n', '<C-n>', ':tabnew<CR>')
vim.keymap.set('n', 'H', '0')
vim.keymap.set('n', 'L', '$')

-- [ " Return to normal mode when pressing jj
-- " Avoid pressing escape which is out of the way
-- " From 'Learn Vimscript the hard way'.
-- ]

vim.keymap.set('i', 'jk', '<esc>', { noremap = true })
vim.keymap.set('i', 'JK', '<esc>', { noremap = true })

vim.keymap.set('n', '<leader>lr', '<plug>(vimtex-env-change)')

-- Specific to TeX
-- " Map $ binds to m
vim.keymap.set('n', 'dm', "O[<ESC>j>>o<BS>]<ESC>k")
vim.keymap.set('n', 'csm', 'cs$')
vim.keymap.set('n', 'dsm', 'ds$')
vim.keymap.set('n', 'dam', 'da$')
vim.keymap.set('n', 'dim', 'di$')
vim.keymap.set('n', 'cim', 'ci$')
vim.keymap.set('n', 'cam', 'ca$')
vim.keymap.set('n', 'vim', 'vi$')
vim.keymap.set('n', 'vam', 'va$')


vim.keymap.set('n', "<leader>tn", "<cmd>tne<cr>", {noremap = true})
vim.keymap.set('n', "<leader>tl", "<cmd>tselect<cr>", {noremap = true})
vim.keymap.set('n', "<leader>tp", "<cmd>tprevious<cr>", {noremap = true})
