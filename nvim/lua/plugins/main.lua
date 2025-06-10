-- Plugin installations
require('lazy').setup({
    spec = {
        { 'nvim-lua/plenary.nvim' },

        { 'airblade/vim-rooter' },
        { 'akinsho/bufferline.nvim' },
        {
            'folke/tokyonight.nvim',
            lazy = false,
            priority = 1000,
            opts = {
                on_highlights = function(hl, c)
                    hl.WinSeparator = { fg = c.red }
                end,
            },
        },
        { 'folke/trouble.nvim' },
        {
            'iamcco/markdown-preview.nvim',
            cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
            build = 'cd app && npm install',
            init = function()
                vim.g.mkdp_filetypes = { 'markdown' }
            end,
            ft = { 'markdown' },
        },
        { 'kyazdani42/nvim-web-devicons' },
        {
            'mason-org/mason-lspconfig.nvim',
            opts = {
                ensure_installed = { 'pyright', 'ts_ls' }
            },
            dependencies = {
                { 'mason-org/mason.nvim', opts = {} },
                'neovim/nvim-lspconfig',
            },
        },
        { 'nvim-lualine/lualine.nvim' },
        {
            'nvim-telescope/telescope-project.nvim',
            dependencies = {
                'nvim-telescope/telescope.nvim',
            },
        },
        {
            'nvim-treesitter/nvim-treesitter',
            opts = {
                build = ':TSUpdate',
                ensure_installed = { 'lua', 'python', 'typescript' }
            }
        },
        { 'tpope/vim-fugitive' },
        { 'ThePrimeagen/harpoon' },

        -- Trying out
        { 'echasnovski/mini.nvim', version = false }
    },
})
vim.cmd.colorscheme('tokyonight-night')
