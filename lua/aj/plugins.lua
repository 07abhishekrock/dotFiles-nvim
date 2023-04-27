local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug 'tpope/vim-fugitive'
Plug 'hotoo/jsgf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'peitalin/vim-jsx-typescript'
Plug 'tpope/vim-vinegar'
Plug 'jremmen/vim-ripgrep'
Plug 'jiangmiao/auto-pairs'
Plug 'NLKNguyen/papercolor-theme'
Plug('ibhagwan/fzf-lua', {branch= 'main'})
Plug 'tpope/vim-rhubarb'
Plug 'stsewd/fzf-checkout.vim'
Plug 'svermeulen/vim-yoink'
Plug 'lambdalisue/fern.vim'
Plug 'shaunsingh/nord.nvim'
Plug 'tpope/vim-commentary'
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'lukas-reineke/lsp-format.nvim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-surround'
Plug 'kyazdani42/nvim-web-devicons'
-- Plug 'vim-airline/vim-airline'
Plug 'nvim-lualine/lualine.nvim'
Plug 'vim-airline/vim-airline-themes'
Plug 'Shatur/neovim-session-manager'
Plug 'goolord/alpha-nvim'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('pineapplegiant/spaceduck', { branch = 'main' })
Plug 'sheerun/vim-polyglot'
Plug 'ThePrimeagen/harpoon'
Plug 'haishanh/night-owl.vim'
Plug ('glepnir/lspsaga.nvim', {['branch'] = 'main' })
Plug 'natecraddock/sessions.nvim'
Plug 'vijaymarupudi/nvim-fzf'
Plug 'skywind3000/asyncrun.vim'
Plug 'stevearc/dressing.nvim'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'
Plug 'windwp/nvim-ts-autotag'
-- Plug 'akinsho/flutter-tools.nvim'
Plug 'lervag/wiki-ft.vim'
Plug 'lervag/wiki.vim'
Plug 'pwntester/octo.nvim'
Plug 'arzg/vim-substrata'
Plug 'ap/vim-css-color'
Plug 'ms-jpq/coq_nvim'
Plug "kkharji/sqlite.lua"
Plug 'mrjones2014/legendary.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'airblade/vim-rooter'
Plug 'tjdevries/express_line.nvim'
Plug ('iamcco/markdown-preview.nvim', { ["do"] = 'cd app && yarn install' })
vim.call('plug#end')

vim.cmd('set termguicolors')
vim.cmd('colorscheme nord')
vim.opt.background = 'dark'

vim.cmd[[

let g:yoinkSavePersistently = 1
let g:yoinkMaxItems = 2

if executable('rg')
  let g:rg_derive_root='true'
endif

function! RootDirectoryString()

  let dir = systemlist("git rev-parse --show-toplevel")[0]
  return dir

endfunction


function! RootDirectory()

  let dir = RootDirectoryString() 
  let fatal = "fatal"
  let fallback = "."

  if stridx(dir, fatal) == 0
    return fallback
  else
    return dir
  endif

endfunction


if (has("termguicolors"))
 set termguicolors
endif

let g:fern#renderer = "nerdfont"
let g:fern#default_hidden = 1
let g:fern#default_exclude = '^\.DS_Store$'

let g:airline_theme = "nord_minimal"

let g:rooter_patterns = [ '.git', 'pnpm-lock.yaml', 'package-lock.json' ]

]]

require('session_manager').setup({
  path_replacer = '__', -- The character to which the path separator will be replaced for session files.
  colon_replacer = '++', -- The character to which the colon symbol will be replaced for session files.
  autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
  autosave_last_session = true, -- Automatically save last session on exit and on session switch.
  autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
  autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
    'gitcommit'
  },
  autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
  max_path_length = 80,  -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
})

-- airline customization

vim.cmd[[
  
  let g:airline_section_x = '%y'
  let g:airline_section_y = ''
  let g:airline_section_z = ''

]]


--wiki customization
vim.cmd[[
  let g:wiki_root = '~/vimwiki'
]]

--vimwiki customization
vim.cmd[[
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
]]

--fugitive vars
vim.cmd[[ let g:fugitive_pty = 0 ]]
