vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4

vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 100

vim.opt.wildmode = { 'longest', 'list', 'full' }

vim.opt.mouse:append('a')
vim.opt.visualbell = true

vim.opt.diffopt:append { 'internal', 'algorithm:patience' }

vim.opt.listchars = {
    tab = '> ',
    trail = '-',
    extends = '>',
    precedes = '<',
    nbsp = '+'
}

-- manual folding
vim.keymap.set('n', '<space>', 'za', { noremap = true })

-- delete don't cut
vim.keymap.set('n', '<leader>d', '"_x', { noremap = true })

-- yank to system clipboard
vim.keymap.set('v', '<leader>y', '"*y', { noremap = true })

-- move blocks of code
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })

-- movement between splits
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true })

if vim.fn.exists(':DiffOrig') == 0 then
    vim.api.nvim_create_user_command('DiffOrig', function()
        vim.cmd [[vert new | setlocal buftype=nofile | read # | 0delete_ | diffthis | wincmd p | diffthis]]
    end, {})
    vim.keymap.set('n', ':DO', ':DiffOrig', { noremap = true })
end

-- hybrid numbering for normal and insert mode
local numbertoggle = vim.api.nvim_create_augroup('numbertoggle', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
    group = numbertoggle,
    pattern = '*',
    callback = function()
        vim.opt.relativenumber = true
    end,
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
    group = numbertoggle,
    pattern = '*',
    callback = function()
        vim.opt.relativenumber = false
    end,
})

-- remember cursor when closing file
vim.api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        local line = vim.fn.line
        if line("'\"") > 1 and line("'\"") <= line("$") then
            vim.cmd [[normal! g`"]]
        end
    end,
})

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

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
vim.cmd.colorscheme("tokyonight-night")
