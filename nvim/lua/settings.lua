-- Globals
----------------------------------------------------------------------
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Options
----------------------------------------------------------------------
vim.opt.list = true
vim.opt.number = true
vim.opt.showmatch = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.softtabstop = 4

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 100

vim.opt.wildmode = { "longest", "list", "full" }

vim.opt.mouse:append("a")
vim.opt.visualbell = true

vim.opt.diffopt:append { "internal", "algorithm:patience" }

vim.opt.listchars = {
    tab = "> ",
    trail = "-",
    extends = ">",
    precedes = "<",
    nbsp = "+"
}

-- Mappings
----------------------------------------------------------------------

-- manual folding
vim.keymap.set("n", "<space>", "za")

-- delete don't cut
vim.keymap.set("n", "<leader>d", "'_x")

-- yank to system clipboard
vim.keymap.set("v", "<leader>y", "'*y")

-- move blocks of code
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- movement between splits
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- telescope
--vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
--vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
--vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
--vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

if vim.fn.exists(":DiffOrig") == 0 then
    vim.api.nvim_create_user_command("DiffOrig", function()
        vim.cmd [[vert new | setlocal buftype=nofile | read # | 0delete_ | diffthis | wincmd p | diffthis]]
    end, {})
    vim.keymap.set("n", ":DO", ":DiffOrig", { noremap = true })
end

-- Autocmd
----------------------------------------------------------------------

-- hybrid numbering for normal and insert mode
local numbertoggle = vim.api.nvim_create_augroup("numbertoggle", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
    group = numbertoggle,
    pattern = "*",
    callback = function()
        vim.opt.relativenumber = true
    end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
    group = numbertoggle,
    pattern = "*",
    callback = function()
        vim.opt.relativenumber = false
    end,
})

-- remember cursor when closing file
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local line = vim.fn.line
        if line("'\"") > 1 and line("'\"") <= line("$") then
            vim.cmd [[normal! g`"]]
        end
    end,
})
