"-------------------------------------------------------------------------------
" コマンド       ノーマルモード 挿入モード コマンドラインモード ビジュアルモード
" map/noremap           @            -              -                  @
" nmap/nnoremap         @            -              -                  -
" imap/inoremap         -            @              -                  -
" cmap/cnoremap         -            -              @                  -
" vmap/vnoremap         -            -              -                  @
" map!/noremap!         -            @              @                  -
"---------------------------------------------------------------------------
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
set mouse=""
set cmdheight=2
set notimeout ttimeout ttimeoutlen=200
set listchars=tab:»-,trail:-,eol:↲
set t_Co=256
set backspace=indent,eol,start
set autoread
"set relativenumber
"set cursorline
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
"imap <C-h> <Left>
"imap <C-l> <Right>
"nnoremap j gj
"nnoremap k gk

"custom statusline
"set statusline=%<%f\
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}
set stl+=[%{&ff}]             " show fileformat
set stl+=%y%m%r%=
set stl+=%-14.(%l,%c%V%)\ %P

" scroll offset
set scrolloff=10

" jump to same indent line
"nn <C-k> :call search ("^". matchstr (getline (line (".")+ 1), '\(\s*\)') ."\\S", 'b')<CR>^
"nn <C-j> :call search ("^". matchstr (getline (line (".")), '\(\s*\)') ."\\S")<CR>^
nnoremap <silent> g{ :call <SID>search_top()<CR>^
nnoremap <silent> g} :call search ('^\s\{,' . (col('.') - 1). '}\S')<CR>^
function! s:search_top()
  let spaces = col('.')
  execute line(".") - 1
  call search ('^\s\{,' . (spaces - 1). '}\S', 'b')
endfunction

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i) " 1 -> 1, 2 -> 8, 3 -> 4 ????
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    " Use gettabvar().
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
"let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2

" <C-t>: Tab pages
"nnoremap <silent><expr> <C-t>
"      \ ":\<C-u>Unite -select=".(tabpagenr()-1)." tab\<CR>"

" t: tags-and-searches "{{{
" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
"}}}

map <silent> [Tag]c :tablast <bar> tabnew<CR>
map <silent> [Tag]x :tabclose<CR>
map <silent> [Tag]n :tabnext<CR>
map <silent> [Tag]p :tabprevious<CR>

" crusorline
augroup vimrc-auto-cursorline
  autocmd!
  autocmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
  autocmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
  autocmd WinEnter * call s:auto_cursorline('WinEnter')
  autocmd WinLeave * call s:auto_cursorline('WinLeave')

  let s:cursorline_lock = 0
  function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
      setlocal cursorline
      let s:cursorline_lock = 2
    elseif a:event ==# 'WinLeave'
      setlocal nocursorline
    elseif a:event ==# 'CursorMoved'
      if s:cursorline_lock
        if 1 < s:cursorline_lock
          let s:cursorline_lock = 1
        else
          setlocal nocursorline
          let s:cursorline_lock = 0
        endif
      endif
    elseif a:event ==# 'CursorHold'
      setlocal cursorline
      let s:cursorline_lock = 1
    endif
  endfunction
augroup END

" easy escape
inoremap jj <ESC>
onoremap jj <ESC>
inoremap j<Space> j
onoremap j<Space> j

" a>, i], etc... "{{{
" <angle>
onoremap aa  a>
xnoremap aa  a>
onoremap ia  i>
xnoremap ia  i>

" [rectangle]
onoremap ar  a]
xnoremap ar  a]
onoremap ir  i]
xnoremap ir  i]

" 'quote'
onoremap aq  a'
xnoremap aq  a'
onoremap iq  i'
xnoremap iq  i'

" "double quote"
onoremap ad  a"
xnoremap ad  a"
onoremap id  i"
xnoremap id  i"
"}}}

" Clear highlight.
nnoremap <ESC><ESC> :nohlsearch<CR>

" Command-line mode keymappings:"{{{
" <C-a>, A: move to head.
cnoremap <C-a>          <Home>
" <C-b>: previous char.
cnoremap <C-b>          <Left>
" <C-d>: delete char.
cnoremap <C-d>          <Del>
" <C-e>, E: move to end.
cnoremap <C-e>          <End>
" <C-f>: next char.
cnoremap <C-f>          <Right>
" <C-n>: next history.
cnoremap <C-n>          <Down>
" <C-p>: previous history.
cnoremap <C-p>          <Up>
" <C-k>, K: delete to end.
cnoremap <C-k> <C-\>e getcmdpos() == 1 ?
      \ '' : getcmdline()[:getcmdpos()-2]<CR>
" <C-y>: paste.
cnoremap <C-y>          <C-r>*
"}}}

" Command line buffer."{{{
nnoremap <SID>(command-line-enter) q:
xnoremap <SID>(command-line-enter) q:
nnoremap <SID>(command-line-norange) q:<C-u>

" [Space]: Other useful commands "{{{
" Smart space mapping.
" Notice: when starting other <Space> mappings in noremap, disappeared
" [Space].
nmap  <Space>   [Space]
xmap  <Space>   [Space]
nnoremap  [Space]   <Nop>
xnoremap  [Space]   <Nop>

" Toggle relativenumber.
nnoremap <silent> [Space].
      \ :<C-u>call ToggleOption('relativenumber')<CR>
nnoremap <silent> [Space]p
      \ :<C-u>call ToggleOption('paste')<CR>:set mouse=<CR>
" Toggle highlight.
nnoremap <silent> [Space]/
      \ :<C-u>call ToggleOption('hlsearch')<CR>
" Toggle cursorline.
nnoremap <silent> [Space]cl
      \ :<C-u>call ToggleOption('cursorline')<CR>
" Set autoread.
nnoremap [Space]ar
      \ :<C-u>setlocal autoread<CR>
" Output encoding information.
nnoremap <silent> [Space]en
      \ :<C-u>setlocal encoding? termencoding? fenc? fencs?<CR>
" Set spell check.
nnoremap [Space]sp
      \ :<C-u>call ToggleOption('spell')<CR>
nnoremap [Space]w
      \ :<C-u>call ToggleOption('wrap')<CR>
" Echo syntax name.
nnoremap [Space]sy
      \ :<C-u>echo synIDattr(synID(line('.'), col('.'), 1), "name")<CR>

" Easily edit .vimrc and .gvimrc "{{{
nnoremap <silent> [Space]ev  :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> [Space]eg  :<C-u>edit $MYGVIMRC<CR>
" Load .gvimrc after .vimrc edited at GVim.
nnoremap <silent> [Space]rv :<C-u>source $MYVIMRC \|
      \ if has('gui_running') \|
      \   source $MYGVIMRC \|
      \ endif \| echo "source $MYVIMRC"<CR>
nnoremap <silent> [Space]rg
      \ :<C-u>source $MYGVIMRC \|
      \ echo "source $MYGVIMRC"<CR>
"}}}
" Easily syntax change.
nnoremap <silent> [Space]ft :<C-u>Unite -start-insert filetype<CR>
" for folding
noremap [Space]j zj
noremap [Space]k zk
noremap [Space]h zc
noremap [Space]l zo
noremap [Space]i zMzv
noremap [Space]rr zR
noremap [Space]m zM

" Toggle options. "{{{
function! ToggleOption(option_name)
  execute 'setlocal' a:option_name.'!'
  execute 'setlocal' a:option_name.'?'
endfunction  "}}}
" Toggle variables. "{{{
function! ToggleVariable(variable_name)
  if eval(a:variable_name)
    execute 'let' a:variable_name.' = 0'
  else
    execute 'let' a:variable_name.' = 1'
  endif
  echo printf('%s = %s', a:variable_name, eval(a:variable_name))
endfunction  "}}}

set re=1

filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'tpope/vim-rails.git'
NeoBundleLazy 'ZenCoding.vim', 'abdc4cf2062e546dab80ea53d2feb4118d00c5d8', { 'autoload' : {
    \ 'filetypes' : ['eruby', 'scss', 'css', 'html', 'scss.css']
    \ }}

NeoBundle 'EnhCommentify.vim'
NeoBundle 'Shougo/neocomplcache'
let g:neocomplcache_enable_at_startup = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
"Enable heavy omni completion.
"if !exists('g:neocomplcache_omni_patterns')
"    let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_enable_smart_case = 0
let g:neocomplcache_enable_underbar_completion = 0
let g:neocomplcache_enable_camel_case_completion = 0
"scssでcssの補完を有効にする
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.scss = '^\s\+\w\+\|\w\+[):;]\?\s\+\|[@!]'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'sudo.vim'
NeoBundle 'surround.vim'
"NeoBundleLazy 'vim-ruby/vim-ruby', { 'autoload' : {
"    \ 'filetypes' : 'ruby'
"    \ }}
let ruby_space_errors=1
NeoBundleLazy 'wadako111/vim-coffee-script', { 'autoload' : {
    \ 'filetypes' : ['coffee', 'eco']
    \ }}

NeoBundle 'thinca/vim-quickrun.git'
let g:quickrun_config = {}
let g:quickrun_config['coffee'] = {'command' : 'coffee', 'exec' : ['%c -cbp %s']}
NeoBundle 'tpope/vim-endwise.git'
"NeoBundle 'mru.vim'
NeoBundle 'othree/html5.vim'
NeoBundleLazy 'pangloss/vim-javascript', { 'autoload' : {
    \ 'filetypes' : 'javascript'
    \ }}

"NeoBundle 'nathanaelkane/vim-indent-guides.git'
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=233
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=237
"let g:indent_guides_enable_on_vim_startup = 1
set ts=2 sw=2 et
NeoBundleLazy 'briancollins/vim-jst.git', { 'autoload': {
    \ 'filetypes' : 'eco'
    \ }}
NeoBundle 'wadako111/say.vim'
NeoBundle 'Shougo/unite.vim'
let g:unite_enable_start_insert = 1
let g:unite_enable_split_vertically = 0
let g:unite_winwidth = 40
call unite#custom_source('file_rec', 'ignore_pattern', 'vendor/\|tmp/\|log/')
call unite#custom_source('file_rec/async', 'ignore_pattern', 'vendor/\|tmp/\|log/')
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ut :<C-u>Unite -buffer-name=files buffer file_mru file_rec/async file/new  <CR>
nnoremap <silent> ,um :<C-u>Unite  file_mru <CR>
nnoremap <silent> ,ug :<C-u>Unite grep:%:-iHRn<CR>
nnoremap <silent> ,uc :<C-u>Unite file_rec/async:config/ <CR><C-u>
nnoremap <silent> ,uj :<C-u>Unite file_rec/async:app/assets/javascripts/ <CR>
nnoremap <silent> ,urc :<C-u>Unite file_rec/async:app/controllers/ <CR>
nnoremap <silent> ,urm :<C-u>Unite file_rec/async:app/models/ <CR>
nnoremap <silent> ,urv :<C-u>Unite file_rec/async:app/views/ <CR>
nnoremap <silent> ,urs :<C-u>Unite file_rec/async:app/assets/stylesheets/ <CR>
nnoremap <silent> ,uri :<C-u>Unite file_rec/async:config/initializers/ <CR>

NeoBundle 'tpope/vim-fugitive'

NeoBundle 'Shougo/vimshell'
let g:vimshell_prompt_expr = 'getcwd()." > "'
let g:vimshell_prompt_pattern = '^\f\+ > '
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }

NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
" rsense in neocomplcache
"let g:neocomplcache#sources#rsense#home_directory = '/home/wadako/rsense-0.3'
"NeoBundle 'Shougo/neocomplcache-rsense', {
"            \ 'depends' : 'Shougo/neocomplcache',
"            \ 'autoload' : { 'filetypes' : 'ruby' }
"          \ }
"let g:rsenseUseOmniFunc = 1
NeoBundle 'yanktmp.vim'
map <silent> sy :call YanktmpYank()<CR>
map <silent> sp :call YanktmpPaste_p()<CR>
map <silent> sP :call YanktmpPaste_P()<CR>

NeoBundle 'yuratomo/w3m.vim'
"NeoBundle "basyura/unite-rails"

"NeoBundleLazy 'cakebaker/scss-syntax.vim', {'autoload' : {'filetypes' : ['scss', 'scss.css'] }}

"haskell
NeoBundleLazy "dag/vim2hs",                  {"autoload" : { "filetypes" : ["haskell"] }}
NeoBundleLazy "eagletmt/ghcmod-vim",         {"autoload" : { "filetypes" : ["haskell"] }}
NeoBundleLazy "eagletmt/unite-haddock",      {"autoload" : { "filetypes" : ["haskell"] }}
NeoBundleLazy "ujihisa/neco-ghc",            {"autoload" : { "filetypes" : ["haskell"] }}
NeoBundleLazy "ujihisa/unite-haskellimport", {"autoload" : { "filetypes" : ["haskell"] }}
autocmd BufWritePost *.hs GhcModCheckAndLintAsync

" textobj
" http://d.hatena.ne.jp/osyo-manga/20130717/1374069987
" textobj まとめ
NeoBundle 'kana/vim-textobj-user'
" snake_case 上の word
" a,w, i,w
NeoBundle 'h1mesuke/textobj-wiw'
NeoBundle 'rhysd/vim-textobj-ruby'
NeoBundle "kana/vim-textobj-indent"

let g:neosnippet#snippets_directory='~/.vim/snippets'
NeoBundle 'Shougo/neosnippet'
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
inoremap <expr><C-e> neocomplcache#cancel_popup()
inoremap <expr><C-y> neocomplcache#close_popup()
imap <silent><C-S>     <Plug>(neosnippet_start_unite_snippet)

" twitter
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'basyura/TweetVim'
nnoremap <leader>s :TweetVimCommandSay<CR>
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/livestyle-vim'
" color scheme
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'vim-scripts/twilight'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/rdark'
NeoBundle 'Zenburn'
NeoBundle 'desert.vim'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'Railscasts-Theme-GUIand256color'
colorscheme railscasts
set background=dark
"let g:solarized_termcolors=256
" jk
NeoBundleLazy 'rhysd/accelerated-jk', { 'autoload' : {
      \ 'mappings' : ['<Plug>(accelerated_jk_gj)',
      \               '<Plug>(accelerated_jk_gk)'],
      \ }}
if neobundle#is_installed('accelerated-jk')
  " accelerated-jk
  nmap <silent>j <Plug>(accelerated_jk_gj)
  nmap gj j
  nmap <silent>k <Plug>(accelerated_jk_gk)
  nmap gk k
endif
let g:accelerated_jk_acceleration_limit = 300

NeoBundleLazy 'osyo-manga/unite-filetype', { 'autoload' : {
      \ 'unite_sources' : 'filetype',
      \ }}
NeoBundle 'mattn/gist-vim'

NeoBundle 'scrooloose/syntastic'

NeoBundle 'LeafCage/foldCC'
set foldmethod=indent
set foldlevel=1
set foldnestmax=2
set foldtext=FoldCCtext()
hi Folded gui=bold term=standout ctermbg=233 ctermfg=244
hi FoldColumn gui=bold term=standout ctermbg=LightGrey ctermfg=DarkBlue



filetype plugin indent on
filetype on
NeoBundleCheck
