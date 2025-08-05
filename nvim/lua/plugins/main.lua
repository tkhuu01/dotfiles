-- Plugin installations
require("lazy").setup({
    spec = {
        { "nvim-lua/plenary.nvim" },


        {
            "akinsho/bufferline.nvim",
            opts = {
                options = {
                    numbers = "buffer_id"
                },
            }
        },
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
            opts = {
                on_highlights = function(hl, colors)
                    hl.WinSeparator = { fg = colors.blue }
                    hl.LineNrAbove = { fg = "#878787" }
                    hl.LineNr = { fg = "#D3D3D3" }
                    hl.LineNrBelow = { fg = "#878787" }
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
                ensure_installed = { "pyright", "ts_ls", "clangd", "lua_ls" }
            },
            dependencies = {
                { "mason-org/mason.nvim", opts = {} },
                "neovim/nvim-lspconfig",
            },
        },
        {
            "nvim-lualine/lualine.nvim",
            opts = {
                options = {
                    component_separators = "",
                    section_separators = "",
                }
            }
        },
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
                ensure_installed = { "lua", "python", "typescript", "tsx", "bash" },
                sync_install = true,
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
            end,
        },
        { "tpope/vim-fugitive" },
        {
            "ThePrimeagen/harpoon",
            branch = "harpoon2",
        },
        { "echasnovski/mini.nvim", version = false },
        {
            "folke/snacks.nvim",
            priority = 1000,
            lazy = false,
            ---@type snacks.Config
            opts = {
                bufdelete = { enabled = true },
                input = { enabled = true },
                lazygit = { enabled = true },
                picker = { enabled = true },
                notifier = {
                    enabled = true,
                    timeout = 3000,
                },
                terminal = { enabled = true },
            },
            matchers = {
                frecency = true,
            },
            keys = {
                { "<leader>lg", function() Snacks.lazygit.open() end, desc = "Open Lazygit" },
                { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
                { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
                { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
                { "<leader>fp", function() Snacks.picker.projects({ dev = {"~/SFP", "~/dotfiles"} }) end, desc = "Projects" },
                { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
                { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
                { "<c-t>", function() Snacks.terminal() end, desc = "Toggle Terminal" },
                { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" }
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
        },
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    { path = "snacks.nvim", words = { "Snacks" } },
                },
            },
        },
        {
            "hrsh7th/nvim-cmp",
            opts = function(_, opts)
                opts.sources = opts.sources or {}
                table.insert(opts.sources, {
                    name = "lazydev",
                    group_index = 0, -- set group index to 0 to skip loading LuaLS completions
                })
            end,
        }
    }
})
vim.cmd.colorscheme("tokyonight-night")
