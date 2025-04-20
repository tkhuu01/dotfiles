
call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
Plug 'airblade/vim-rooter'
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'shaunsingh/nord.nvim',  { 'tag': '78f5f001709b5b321a35dcdc44549ef93185e024' }
Plug 'kyazdani42/nvim-web-devicons' " Recommended (for coloured icons)
Plug 'folke/trouble.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'ThePrimeagen/harpoon'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()
set nocompatible
filetype off

filetype plugin indent on

syntax on
set termguicolors
lua << EOF
require'lspconfig'.pyright.setup{
    cmd = { "pyright-langserver", "--stdio" },
    filetypes = { "python" },
    --root_dir = function(startpath)
    --    return M.search_ancestors(startpath, matcher)
    --end,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
          include = { "/home/tkhuu/miniconda3/bin" }
        }
      }
    },
    single_file_support = true
}
require'lspconfig'.eslint.setup{
    cmd = { "vscode-eslint-language-server", "--stdio" },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    settings = {
        codeAction = {
            disableRuleComment = {
                enable = true,
                location = "separateLine"
            },
            showDocumentation = {
                enable = true
            }
        },
        codeActionOnSave = {
            enable = false,
            mode = "all"
        },
        format = true,
        nodePath = "",
        onIgnoredFiles = "off",
        packageManager = "npm",
        quiet = false,
        rulesCustomizations = {},
        run = "onType",
        useESLintClass = false,
        validate = "on",
        workingDirectory = {
            mode = "location"
        }
    }
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'everforest',
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
  tabline = {},
  extensions = {}
}
require("bufferline").setup{
    options = {
        numbers = function(opts)
            return string.format('%s',opts.id)
        end,
    },
}
require'nvim-web-devicons'.get_icons()
vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = false
vim.g.nord_italic = false
require("trouble").setup {}

require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all"
  ensure_installed = { "typescript", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    --disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  }
}

-- Load the colorscheme
require('nord').set()


EOF
let mapleader=","

colorscheme nord

set list
set nu
set showcmd
set showmatch

set tabstop=4
set smarttab
set expandtab
set shiftwidth=4
set softtabstop=4

set autoindent
set smartindent

set foldmethod=indent
set foldlevel=100
nnoremap <space> za

set wildchar=<Tab>
set wildmode=longest,list,full
set wildmenu

set incsearch
set hlsearch

"set colorcolumn=85

set noshowmode
set laststatus=2
set mouse=a

set visualbell
set t_vb=

if has("patch-8.1.0360")
      set diffopt+=internal,algorithm:patience
endif


" Better display of whitespaces
if &listchars ==# 'eol:$'
      set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				    \ | wincmd p | diffthis
    nnoremap :DO :DiffOrig
endif


" Hybrid numbering depending on if you are in insert or normal mode
if exists('+relativenumber')
    set number relativenumber
    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
        autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    augroup END
endif

" Remember where cursor is when closing file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 &&
                      \ line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript
augroup END

" ------------------------------------------------------------------------------

" -----------------
" Other remaps
" -----------------

" For moving blocks of code
vnoremap < <gv
vnoremap > >gv

" Easier movement between splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" -------------
" Plugin remaps
" -------------
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

let g:rooter_paterns = ['.git']

