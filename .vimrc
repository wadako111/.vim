syntax on
set nocompatible
set autoindent
set expandtab
set list
set number
set showmatch
set smartindent
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
" swapファイルを作成しない
set noswapfile
" タブ幅
set shiftwidth=4
set tabstop=4
" 全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/

" スペースもマッピングされるためコメントは横に記述しません。
" nmap ノーマルモードのキーマップ
" nnoremap ノーマルモードのキーマップ (ただし再帰的にキーマップを追いません)
" imap インサートモードのキーマップ
"
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-h> <Left>
imap <C-l> <Right>
nnoremap j gj
nnoremap k gk

" indentで折りたたみをする
set foldmethod=indent
set foldlevel=100

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'qmarik/vundle'
Bundle 'tpope/vim-rails.git'
Bundle 'Railscasts-Theme-GUIand256color'
colorscheme railscasts
Bundle 'ZenCoding.vim'
Bundle 'EnhCommentify.vim'
Bundle 'Shougo/neocomplcache'
let g:neocomplcache_enable_at_startup = 1
inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"Enable heavy omni completion.
"if !exists('g:neocomplcache_omni_patterns')
"    let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"let g:neocomplcache_enable_smart_case = 1
"let g:neocomplcache_enable_underbar_completion = 1
"let g:neocomplcache_enable_camel_case_completion = 1
"scssでcssの補完を有効にする
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.scss = '^\s\+\w\+\|\w\+[):;]\?\s\+\|[@!]'

Bundle 'scrooloose/nerdtree'
Bundle 'sudo.vim'
Bundle 'surround.vim'
Bundle 'vim-ruby/vim-ruby'
let ruby_space_errors=1
Bundle 'kchmck/vim-coffee-script'
Bundle 'thinca/vim-quickrun.git'
let g:quickrun_config = {}
let g:quickrun_config['coffee'] = {'command' : 'coffee', 'exec' : ['%c -cbp %s']}
Bundle 'tpope/vim-endwise.git'
Bundle 'mru.vim'
Bundle 'othree/html5.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'nathanaelkane/vim-indent-guides.git'
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=233
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=237
let g:indent_guides_enable_on_vim_startup = 1
set ts=2 sw=2 et
Bundle 'briancollins/vim-jst.git'
Bundle 'fholgado/minibufexpl.vim.git'

filetype plugin indent on
filetype on
