-- Plugin installations
require("lazy").setup({
    spec = {
        { "nvim-lua/plenary.nvim" },

        { "airblade/vim-rooter" },
        { "akinsho/bufferline.nvim" },
        {
            "folke/tokyonight.nvim",
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
        { "folke/trouble.nvim" },
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            build = "cd app && npm install",
            init = function()
                vim.g.mkdp_filetypes = { "markdown" }
            end,
            ft = { "markdown" },
        },
        { "kyazdani42/nvim-web-devicons" },
        {
            "mason-org/mason-lspconfig.nvim",
            opts = {
                ensure_installed = { "pyright", "ts_ls" }
            },
            dependencies = {
                { "mason-org/mason.nvim", opts = {} },
                "neovim/nvim-lspconfig",
            },
        },
        { "nvim-lualine/lualine.nvim" },
        {
            "nvim-telescope/telescope-project.nvim",
            dependencies = {
                "nvim-telescope/telescope.nvim",
            },
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "python", "typescript", "tsx" },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
            end,
        },
        { "tpope/vim-fugitive" },
        { "ThePrimeagen/harpoon" },

        -- Trying out
        { "echasnovski/mini.nvim", version = false },
        { "folke/snacks.nvim", 
            priority = 1000,
            lazy = false,
            ---@type snacks.Config
            opts = {
                input = { enabled = true },
                lazygit = { enabled = true },
                picker = { enabled = true },
                notifier = {
                    enabled = true,
                    timeout = 3000,
                },
            },
            matchers = {
                frecency = true,
            },
            keys = {
                { "<leader>lg", function() Snacks.lazygit.open() end, desc = "Open Lazygit" },
                { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
                { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
                { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
                { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
                { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
                { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
            }
        },
        {
            "folke/flash.nvim",
            event = "VeryLazy",
            ---@type Flash.Config
            opts = {},
            -- stylua: ignore
            keys = {
                { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
                { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
                { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
                { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
                { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
            }
      }
    }
})
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "tokyonight-night",
    component_separators = "",
    section_separators = "",
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch", "diff", "diagnostics"},
    lualine_c = {"filename"},
    lualine_x = {"encoding", "fileformat", "filetype"},
    lualine_y = {"progress"},
    lualine_z = {"location"}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {"filename"},
    lualine_x = {"location"},
    lualine_y = {},
    lualine_z = {}
  },
  --tabline = {},
  --extensions = {}
})
require("bufferline").setup({
    options = {
        numbers = function(opts)
            return string.format("%s",opts.id)
        end,
    },
})
vim.cmd.colorscheme("tokyonight-night")
