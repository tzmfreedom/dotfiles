set nocompatible

set number
set cursorline
set laststatus=2
" set cmdheight=2
set list
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮

" set cursorcolumn

set confirm
set hidden
set autoread
set nobackup
set noswapfile

set hlsearch 
set incsearch
set ignorecase
set smartcase
set wrapscan
set gdefault

set mouse=a
set history=10000

set visualbell t_vb=
set noerrorbells 

set clipboard+=unnamed

if has('vim_starting')
   set nocompatible               " Be iMproved

   " Required:
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 " Required:
 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!
 

 "
 " ここに自分が欲しいモジュールを追記します。
 "
 
" ファイルをtree表示してくれる
  NeoBundle 'scrooloose/nerdtree'
  
  NeoBundle 'tpope/vim-rails'
  
  NeoBundle 'tpope/vim-endwise'
  
  
  NeoBundle 'Shougo/neocomplete.vim'
  NeoBundle 'marcus/rsense'
  
  NeoBundle 'Shougo/neocomplcache.vim'
  NeoBundle 'Shougo/neocomplcache-rsense.vim'
  
  NeoBundle 'tpope/vim-surround'
  
  NeoBundle 'kakkyz81/evervim'
  
 call neobundle#end()

 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck

set encoding=utf-8

set fileformats=unix,dos,mac

syntax enable

set expandtab

set autoindent

let g:acp_enableAtStartup = 0

let g:neocomplcache_enable_at_startup = 1

let g:neocomplcache_enable_smart_case = 1

let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1

if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

"rsenseのインストールフォルダがデフォルトと異なるので設定
let g:rsenseHome = expand("/Users/mtajitsu/.rbenv/shims/rsense")
let g:rsenseUseOmniFunc = 1
