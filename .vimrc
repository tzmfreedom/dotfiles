set nocompatible

set number
set cursorline
set laststatus=2
" set cmdheight=2
set list
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮

" set cursorcolumn
set backspace=2
set confirm
set hidden
set autoread
set nobackup
set noswapfile

set whichwrap=b,s,h,l,<,>,[,],~

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

nnoremap <Leader>l :EvervimNotebookList<CR>
nnoremap <Leader>s :EvervimSearchByQuery<Space>
nnoremap <Leader>c :EvervimCreateNote<CR>
nnoremap <Leader>t :EvervimListTags<CR>

let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
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
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'tpope/vim-endwise'
  
  NeoBundle 'Shougo/neocomplete.vim'
  NeoBundle 'Shougo/neocomplcache.vim'
  NeoBundle 'Shougo/neocomplcache-rsense.vim'
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/neomru.vim'
  
  NeoBundle 'marcus/rsense'
  NeoBundle 'tpope/vim-surround'
  
  NeoBundle 'kakkyz81/evervim'

  NeoBundle 'kannokanno/previm'

  NeoBundle 'mattn/emmet-vim'

  NeoBundle 'terryma/vim-multiple-cursors'
  
  NeoBundle 'tomtom/tcomment_vim'

  " NeoBundle 'nathanaelkane/vim-indent-guides'

  " ログファイルを色づけしてくれる
  NeoBundle 'vim-scripts/AnsiEsc.vim'

  " 行末の半角スペースを可視化
  NeoBundle 'bronson/vim-trailing-whitespace'

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
set tabstop=2
set shiftwidth=2
set softtabstop=2

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


if !exists('g:loaded_matchit')
  runtime macros/matchit.vim
endif

let g:previm_open_cmd = 'open -a "Google Chrome"'
let g:user_emmet_settings = {
      \ 'variables' : {
      \  'lang' : "ja"
      \ }
      \}

" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""
" Unit.vimの設定
""""""""""""""""""""""""""""""
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <C-P> :Unite buffer<CR>
" ファイル一覧
noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <C-Z> :Unite file_mru<CR>
" sourcesを「今開いているファイルのディレクトリ」とする
noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
""""""""""""""""""""""""""""""

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""
