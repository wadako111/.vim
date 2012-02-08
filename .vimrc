syntax on
set autoindent
set expandtab
set list
set number
set showmatch
set smartindent
colorscheme railscasts
set nocompatible
filetype indent plugin on
set hidden
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase
set nostartofline
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set mouse=a
set cmdheight=2
set notimeout ttimeout ttimeoutlen=200
set listchars=tab:»-,trail:-,eol:↲
set t_Co=256
set backspace=indent,eol,start
set tabstop=4

setlocal omnifunc=syntaxcomplete#Complete

"ruby補完
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

"autocomplpopを無効
let g:acp_enableAtStartup = 0

"neocompcacheを有効
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
