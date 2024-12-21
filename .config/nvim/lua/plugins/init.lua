return {

{'hands-free-vim/talon.nvim' },
-- { 'hands-free-vim/cursorless.nvim' },

-- --  Tools
{ 'junegunn/vim-easy-align' },
{ 'honza/vim-snippets' },
{ 'sankhesh/gitv' },

{ 'm4xshen/autoclose.nvim' },

{ 'nvim-lua/plenary.nvim' },
{ "junegunn/fzf", build = "./install --bin" },
{ "junegunn/fzf.vim" },

{ 'nvim-telescope/telescope-file-browser.nvim' },
{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

{ 'shortcuts/no-neck-pain.nvim' },
--  Language Support
{ 'jackguo380/vim-lsp-cxx-highlight' },
{ 'bfrg/vim-cpp-modern' },
--  Code Navigation
{ 'hari-rangarajan/CCTree' },
{ 'vim-scripts/taglist.vim' },
{ 'antiagainst/cscope-macros.vim' },
{ 'tpope/vim-surround' },
{ 'tpope/vim-commentary' },
{ 'preservim/tagbar' },
--  Git Support
{ 'tpope/vim-fugitive' },
{ 'junegunn/gv.vim' },
{ 'junegunn/goyo.vim' },
{ 'nathanaelkane/vim-indent-guides' },

{ 'folke/which-key.nvim' },
{ 'NeogitOrg/neogit' },


--  Prose related
{ 'vimwiki/vimwiki',
    init = function()
        vim.g.vimwiki_global_ext = 0
        vim.g.vimwiki_list = {
        {path= '~/vimwiki', syntax='markdown', ext='.md'}
        }
    end },
{ 'reedes/vim-litecorrect' },			--  Fix common typos
{ 'panozzaj/vim-autocorrect' },			--  Larger Typo corrections
{ 'kana/vim-textobj-user' },			--  textobj-sentence dep
{ 'reedes/vim-textobj-sentence' },		--  Treat senteces as text objects

--  Color Schemes
{ "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, lazy=false},
}
