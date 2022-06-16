" Search recursively downward from CWD; provides TAB completion for filenames
" e.g., `:find vim* <TAB>`
set path+=**

" reload files changed outside of Vim not currently modified in Vim (needs below)
set autoread

au FocusGained,BufEnter * :silent! !
au FocusLost,WinLeave * :silent! w

" use Unicode
set encoding=utf-8

" fixing clipboard
set clipboard+=unnamedplus

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

" setting autocompletion stuff
set completeopt=menu,menuone,noselect

" open new split panes to right and below
set splitright
set splitbelow

call plug#begin()

Plug 'dracula/vim'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'itchyny/lightline.vim' 

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'williamboman/nvim-lsp-installer'
Plug 'williamboman/nvim-lsp-installer'
Plug 'williamboman/nvim-lsp-installer'

call plug#end()

" making nerdtree show hidden files
let NERDTreeShowHidden=1

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" color schemes
 if (has("termguicolors"))
 set termguicolors
 endif
 syntax enable
 " colorscheme evening
colorscheme dracula

" Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" setting up hooks for nvim-lsp-installer
lua <<EOF
	require('nvim-lsp-installer').setup {}
EOF

" Setting up nvim-cmp
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  
  -- Python
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
 
  -- GoLang
  require('lspconfig')['gopls'].setup {
    cmd = {'gopls'},
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      gopls = {
        experimentalPostfixCompletions = true,
        analyses = {
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
      },
   },
    init_options = {
      usePlaceholders = true,
    }
  }

  -- Javascript and Typescript 
  require('lspconfig')['eslint'].setup {
    capabilities = capabilities
  }

  -- CSS 
  require('lspconfig')['cssls'].setup {
    capabilities = capabilities
  }


  -- HTML 
  require('lspconfig')['html'].setup {
    capabilities = capabilities
  }

  -- Emmet
  require('lspconfig')['emmet_ls'].setup {
    capabilities = capabilities
  }

  -- Lua
  require('lspconfig')['sumneko_lua'].setup {
    capabilities = capabilities
  }

  -- Vimscipt
  require('lspconfig')['vimls'].setup {
    capabilities = capabilities
  }
EOF


