" Search recursively downward from CWD; provides TAB completion for filenames
" e.g., `:find vim* <TAB>`
set path+=**

" reload files changed outside of Vim not currently modified in Vim (needs below)
set autoread

au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w

" use Unicode
set encoding=utf-8

" errors flash instead of making beeb
set visualbell

" don't create `filename-` backups
set nobackup

" don't create temp files
set noswapfile

" line numbers and distances
set relativenumber
set number

" number of lines offset when scrolling
set scrolloff=5

" setting some tab stuff
set autoindent
set shiftwidth=4
set tabstop=4
set smarttab

" highlight matching parens, braces, brackets etc.
set showmatch

" http://vim.wikia.com/wiki/Searching
set hlsearch incsearch ignorecase smartcase

" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
set autochdir

" lightline shows mode instead
set noshowmode

" removing line numbers from the terminal
autocmd TermOpen * setlocal nonumber norelativenumber

call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'codota/tabnine-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'itchyny/lightline.vim' 

call plug#end()

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

