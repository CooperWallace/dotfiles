return {
    'nvim-telescope/telescope.nvim',
    dependencies = {'nvim-treesitter/nvim-treesitter'},
    config = function()
        require('telescope').setup({
        defaults = {
            -- theme
            color_devicons = true,
            layout_strategy = "vertical",
            layout_config = {
                vertical = {
                    preview_cutoff = 0,
                    preview_height = 0.69,
                    results_height = 0.2,
                    width = 0.8,
                    height = 0.99,
                },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        }
        })

        vim.keymap.set('n', '<leader>o', ':Telescope file_browser<CR>', { noremap = true })
        vim.keymap.set('n', '<leader>o', ':Telescope file_browser path=%:p:h select_buffer=true<CR>', { noremap = true })
        vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true })
        vim.keymap.set('n', '<leader>fw', ':Telescope grep_string<CR>', { noremap = true })
        vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true })

        require('telescope').load_extension('fzf')
    end
}
