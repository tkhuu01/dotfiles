" Thomas Khuu
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'roman/golden-ratio'
Plugin 'tpope/vim-fugitive'
Plugin 'benmills/vimux'
Plugin 'terryma/vim-multiple-cursors'
call vundle#end()
filetype plugin indent on

syntax on

let mapleader=","

colorscheme desert

set nu
set showmatch
set list

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
set wildmenu
set wildmode=list

set incsearch
set hlsearch

"set guifont=

" Better display of whitespaces
if &listchars ==# 'eol:$'
      set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				    \ | wincmd p | diffthis
    nnoremap :DO :DiffOrig
endif

" Don't go past 90 columns
match ColorColumn '\%>90v.\+'

" Hybrid numbering depending on if you are in insert or normal mode
if exists('+relativenumber')
    set number relativenumber
    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
        autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    augroup END
endif

" Remember where cursor is left when closing file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 &&
                      \ line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" -----------------
" Plugins
" -----------------

" Syntastic
let g:syntastic_mode_map = {"mode": "passive", "passive_filetypes": ["python"]}
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height=5
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs = 0

nnoremap :SC :SyntasticCheck

" NERDTree
let NERDTreeMinimalUI=1

nnoremap :nt :NERDTree
nnoremap :ntb :NERDTreeFromBookmark

" Vimux
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>

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

autocmd FileType python call PYshortcuts()
function PYshortcuts()
    
endfunction
