call plug#begin('~/.config/nvim/plugged')

" THEMES
Plug 'ellisonleao/gruvbox.nvim'
Plug 'luisiacc/gruvbox-baby', {'branch': 'main'}

" AutoCompletion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip' 
Plug 'rafamadriz/friendly-snippets' 
Plug 'onsails/lspkind-nvim'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
                                              
" Snippets
"Plug 'hrsh7th/vim-vsnip'
"Plug 'hrsh7th/vim-vsnip-integ'
"Plug 'honza/vim-snippets'

" LSP
Plug 'neovim/nvim-lspconfig'
"Plug 'onsails/diaglist.nvim'

" Treesitter NEW UPDATE HAVE BUG CAUSE CRACH
"Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
"Plug 'p00f/nvim-ts-rainbow'
"Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" DART/FLUTTER
Plug 'dart-lang/dart-vim-plugin'  " highlight the syntax

" UTILS
"Plug 'lukas-reineke/indent-blankline.nvim'
"Plug 'windwp/nvim-autopairs'
"Plug 'norcalli/nvim-colorizer.lua'


" Flutter tools
Plug 'nvim-lua/plenary.nvim'
Plug 'akinsho/flutter-tools.nvim'

call plug#end()

 

lua require('ace')


set nowildmenu
"set completeopt=menu,menuone,noselect
"set completeopt=noinsert,menuone,noselect,preview,menu
"set nolist 
set termguicolors
"set background=dark
set mouse=a
"set cursorline
set nowrap
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
		  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
		  \,sm:block-blinkwait175-blinkoff150-blinkon175
"set number
set smartcase
set ignorecase
set incsearch
set hlsearch
set noswapfile
"set spell
set history=10000
"set clipboard=unnamedplus
set title
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab
set autoindent
set smartindent
"set showtabline=2	  " Show tab bar
set laststatus=2
set statusline=
set statusline+=\ %-15(%l,%c%V%)\ %F\ %h%m%r%w%q\ %=%P\ 
set splitbelow
set splitright
set backspace=indent,eol,start
set laststatus=3 
"set undofile
"setlocal colorcolumn=80 " not show up cuz i changed color in gruv theme

" NETRW 
let g:netrw_banner=0
"let g:netrw_browse_split=3
"let g:netrw_altv=1
"let g:netrw_list_hide=netrw_gitignore#Hide()
"let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\$\+'
let g:netrw_liststyle=3
"let g:netrw_winsize=13

" theme 
let g:gruvbox_contrast_dark = "hard"
colorscheme gruvbox

filetype plugin indent on
syntax on 

" dart configs
let g:dart_style_guide = 2
"let g:dart_format_on_save = 1

" auto pair             
  inoremap ( ()<left>
  inoremap [ []<left>
  inoremap { {}<left>
  inoremap {<CR> {<CR>}<ESC>O
  inoremap {;<CR> {<CR>};<ESC>O
  inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
  inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
  inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
  inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
  inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"

" KEYBINDS 
" REMAPS
"   let mapleader = ' '   " leader is space
"
"   nnoremap <leader>h :wincmd h<Cr>
"   nnoremap <leader>j :wincmd j<Cr>
"   nnoremap <leader>k :wincmd k<Cr>
"   nnoremap <leader>l :wincmd l<Cr>

"To use `ALT+{h,j,k,l}` to navigate windows from any mode:
    :tnoremap <A-h> <C-\><C-N><C-w>h
    :tnoremap <A-j> <C-\><C-N><C-w>j
    :tnoremap <A-k> <C-\><C-N><C-w>k
    :tnoremap <A-l> <C-\><C-N><C-w>l

    :inoremap <A-h> <C-\><C-N><C-w>h
    :inoremap <A-j> <C-\><C-N><C-w>j
    :inoremap <A-k> <C-\><C-N><C-w>k
    :inoremap <A-l> <C-\><C-N><C-w>l

    :nnoremap <A-h> <C-w>h
    :nnoremap <A-j> <C-w>j
    :nnoremap <A-k> <C-w>k
    :nnoremap <A-l> <C-w>l

" buffer back/next
    :nnoremap bb :bp<CR>
    :nnoremap bn :bn<CR>
" buffer delete
    :nnoremap bd :bd<CR>


"nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
"nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>

"nnoremap <C-q> :q!<CR>
"nnoremap <F4> :bd<CR>
 
" Cut/Copy/Paste
" it is delete into register +
    nnoremap <C-x> "+dd
    vnoremap <C-c> "+y
    nmap <C-S-v> "+p

" Tabs
"nnoremap <S-Tab> gT
"nnoremap <c-tab> :tabnext<CR> 
"nnoremap <silent> <S-t> :tabnew<CR>
":command FZ FZF
"nnoremap <C-j> :Texplore<CR>  

" disable wildmenu keys
   inoremap <C-n> <nop>
   inoremap <C-p> <nop>
   ""inoremap <Tab> <nop>
" key binding for moving line up and down
    map <S-Up> :m-2 <CR>
    map <S-Down> :m+1 <CR>

" Terminal keymaps
    tnoremap <Esc> <C-\><C-n>

