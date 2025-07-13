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
                on_highlights = function(hl, colors)
                    hl.WinSeparator = { fg = colors.red }
                    hl.LineNrAbove = { fg = colors.white, bold = true }
                    hl.LineNr = { fg = colors.white, bold = true }
                    hl.LineNrBelow = { fg = colors.white, bold = true }
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
        { 'echasnovski/mini.nvim', version = false },
        { 'folke/snacks.nvim', 
            priority = 1000,
            lazy = false,
            ---@type snacks.Config
            opts = {
                input = { enabled = true },
                lazygit = { enabled = true },
                picker = { enabled = true },
            },
            matchers = {
                frecency = true,
            },
            keys = {
                { '<leader>lg', function() Snacks.lazygit.open() end, desc = 'Open Lazygit' },
                { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
                { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status' },
                { '<leader>fp', function() Snacks.picker.projects() end, desc = 'Projects' },
                { '<leader>sB', function() Snacks.picker.grep_buffers() end, desc = 'Grep Open Buffers' },
                { '<leader>/', function() Snacks.picker.grep() end, desc = 'Grep' },
            }
        }
    }
})
require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'tokyonight-night',
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  --tabline = {},
  --extensions = {}
})
require('bufferline').setup({
    options = {
        numbers = function(opts)
            return string.format('%s',opts.id)
        end,
    },
})
vim.cmd.colorscheme('tokyonight-night')
