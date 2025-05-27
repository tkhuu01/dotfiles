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
            opts = {},
        },
        { 'folke/trouble.nvim' },
        {
            'iamcco/markdown-preview.nvim',
            cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
            ft = { 'markdown' },
            build = function()
                vim.fn['mkdp#util#install']()
            end
        },
        { 'kyazdani42/nvim-web-devicons' },
        {
            'mason-org/mason-lspconfig.nvim',
            opts = {},
            dependencies = {
                { 'mason-org/mason.nvim', opts = {} },
                'neovim/nvim-lspconfig',
            },
        },
        { 'nvim-lualine/lualine.nvim' },
        { 'nvim-telescope/telescope.nvim' },
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
require('tokyonight').setup({
    style = 'night',           -- Options: 'storm', 'moon', 'night', 'day'
    transparent = false,       -- Enable/disable background
    terminal_colors = true,    -- Set terminal colors
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = 'dark',     -- 'dark', 'transparent', 'normal'
        floats = 'dark',
    },
    sidebars = { 'qf', 'help' }, -- Set sidebar windows
    on_colors = function(colors) end,
    on_highlights = function(highlights, colors) end,
})
vim.cmd.colorscheme('tokyonight-night')
