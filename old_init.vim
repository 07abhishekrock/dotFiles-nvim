syntax on

"set noerrorbells
"set tabstop=2 softtabstop=2
"set shiftwidth=2
"set expandtab
"set smartindent
"set rnu
"set nowrap
"set smartcase
"set noswapfile
"set nobackup
"set incsearch
"set guifont=Cascadia\ Mono\ PL:h18
"set laststatus=2





function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

function! RootDirectoryString()

  let dir = systemlist("git rev-parse --show-toplevel")[0]
  return dir

endfunction

function! RootDirectory()
  let dir = RootDirectoryString()
  let fatal = "fatal"
  let fallback = ""

  if stridx(dir, fatal) == 0 
    return fallback
  else
    return split(dir, '/')[-1]
  endif

endfunction


function! PercentFile()
  let start = line('.')
  let total = line('$')
  return string(float2nr(round((start / ( total * 1.0 )) * 100))) . "%"
endfunction


set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{FugitiveStatusline()}
set statusline+=%#LineNr#
set statusline+=\ %f%m
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{RootDirectory()}
"set statusline+=%{PercentFile()}

set colorcolumn=80
set autochdir
let mapleader = " "
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
highlight ColorColumn ctermbg=0 guibg=lightgrey

set clipboard=unnamed
set clipboard=unnamedplus


call plug#begin(expand('~/.vim/plugged'))

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive',
Plug 'hotoo/jsgf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'peitalin/vim-jsx-typescript'
Plug 'tpope/vim-vinegar'
Plug 'jremmen/vim-ripgrep'
Plug 'jiangmiao/auto-pairs'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-rhubarb'
Plug 'stsewd/fzf-checkout.vim'
Plug 'svermeulen/vim-yoink'
Plug 'lambdalisue/fern.vim'
Plug 'airblade/vim-rooter'
Plug 'shaunsingh/nord.nvim'

 
call plug#end()

colorscheme nord
set background=dark

if executable('rg')
  let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/' , 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_use_caching = 0
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-json', 
  \ 'coc-eslint'
  \ ]

let g:yoinkSavePersistently = 1
let g:yoinkMaxItems = 2

tnoremap <Esc> <C-\><C-n>

nnoremap ˝ :m+<CR>==
nnoremap ˚ :m-2<CR>==
vnoremap ˝ :m'>+<CR>gv=gv
vnoremap ˚ :m-2<CR>gv=gv

noremap <silent> <C-b> :NERDTreeToggle<CR>

nnoremap <leader>h <C-w>h<CR>
nnoremap <leader>l <C-w>l<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>lg :vertical resize 120<CR> 
nnoremap <leader>md :vertical resize 50<CR>
nnoremap <leader>sm :vertical resize 20<CR>
nnoremap <F8> :wincmd v<CR>gf
nnoremap <leader>b <C-^>


command! -bang -nargs=* GGrep
      \ call fzf#vim#files(RootDirectoryString(), <bang>0)

nnoremap <leader><Left> :Gclog -- %<CR>

noremap <leader>x <C-w>s<C-w>j:terminal<CR>:resize 10<CR>
noremap <leader>X :tabnew<CR>:terminal<CR>

nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :wincmd H<bar> :vertical resize 20 <CR>

nnoremap rm :call delete(expand('%')) \| bdelete!<CR>

nnoremap <Leader>ps :Rg<SPACE>


nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> ne <Plug>(coc-diagnostic-next)
nmap <silent> np <Plug>(coc-diagnostic-prev)
nmap <F2> <Plug>(coc-rename)
nmap <leader>c  <Plug>(coc-codeaction)

nmap [y <plug>(YoinkRotateBack)
nmap ]y <plug>(YoinkRotateForward)

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" Also replace the default gp with yoink paste so we can toggle paste in this case too
nmap gp <plug>(YoinkPaste_gp)
nmap gP <plug>(YoinkPaste_gP)

