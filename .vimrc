
set nocompatible

" Disable localized menus for now since only some items are translated (e.g.
" the entire MacVim menu is set up in a nib file which currently only is
" translated to English).
set langmenu=none
syntax on

"---------------------------------------------------------------------------
" 検索の挙動に関する設定:
"
" 検索時に大文字小文字を無視 (noignorecase:無視しない)
set ignorecase
" 大文字小文字の両方が含まれている場合は大文字小文字を区別
set smartcase

"---------------------------------------------------------------------------
"---------------------------------------------------------------------------
" 編集に関する設定:
"

" rbファイルだけ、ソフトタブ
"au BufNewFile,BufRead *.erb    set noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
"au BufNewFile,BufRead *.html    set noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
"au BufNewFile,BufRead *    set noexpandtab tabstop=4 shiftwidth=4 softtabstop=0
"au BufNewFile,BufRead *    set noexpandtab ts=4 sw=4 sts=0
"au BufNewFile,BufRead *.rb    set expandtab ts=2 sw=2 sts=2
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.erb set filetype=html
au BufNewFile,BufRead *    set expandtab ts=2 sw=2 sts=2

" タブの画面上での幅
" ファイル中の<tab>文字が 画面上の見た目で何文字分に展開するか
"set ts=4

" <tab>キーを入力した際に挿入される空白の量。 0の場合は、tsで指定した量
"et sts=0

" vimが挿入する量
"et sw=4

"C-X,C-Aを強制的に10進数認識させる
"set nrformats=
"set nrformats=alpha

" タブをスペースに展開しない (expandtab:展開する)
"et noexpandtab

" 自動的にインデントする (noautoindent:インデントしない)
set autoindent

" バックスペースでインデントや改行を削除できるようにする
set backspace=2

" 検索時にファイルの最後まで行ったら最初に戻る (nowrapscan:戻らない)
set wrapscan
"set nowrapscan

" undoファイル無効
:set noundofile

" 括弧入力時に対応する括弧を表示 (noshowmatch:表示しない)
set showmatch

" コマンドライン補完するときに強化されたものを使う(参照 :help wildmenu)
set wildmenu

" テキスト挿入中の自動折り返しを日本語に対応させる
set formatoptions+=mM

" 日本語整形スクリプト(by. 西岡拓洋さん)用の設定
let format_allow_over_tw = 1	" ぶら下り可能幅
"参考:http://freebsd.g.hatena.ne.jp/py4s-tnk/20080320/1206016678

" スワップファイル作らない
set noswapfile

"---------------------------------------------------------------------------
" GUI固有ではない画面表示の設定:
"
" 行番号を非表示 (number:表示)
""set nonumber
set number
set nu 
" ルーラーを表示 (noruler:非表示)
set ruler
" タブや改行を表示 (list:表示)
set nolist
" どの文字でタブや改行を表示するかを設定
"set listchars=tab:>-,extends:<,trail:-,eol:<
" 長い行を折り返して表示 (nowrap:折り返さない)
set wrap
" 常にステータス行を表示 (詳細は:he laststatus)
set laststatus=2
" コマンドラインの高さ (Windows用gvim使用時はgvimrcを編集すること)
set cmdheight=2
" コマンドをステータス行に表示
set showcmd
" タイトルを表示
set title

"ウインドウサイズは .gvimrcで定義したよ。
"じゃないとサーバでvi開いてもウインドウサイズ変わるしね。
"set lines=50
"set columns=150
"---------------------------------------------------------------------------
" ファイル操作に関する設定:
"
" バックアップファイルを作成しない (次行の先頭の " を削除すれば有効になる)
set nobackup


" git logが文字化けする件
" http://d.hatena.ne.jp/EnnuimaZ/20120619/1340081333
set fileencoding=utf-8
set enc=utf-8
set fenc=utf-8

"---------------------------------------------------------------------------
" ファイル名に大文字小文字の区別がないシステム用の設定:
"   (例: DOS/Windows/MacOS)
"
if filereadable($VIM . '/vimrc') && filereadable($VIM . '/ViMrC')
  " tagsファイルの重複防止
  set tags=./tags,tags
endif

"---------------------------------------------------------------------------
" コンソールでのカラー表示のための設定(暫定的にUNIX専用)
if has('unix') && !has('gui_running') && !has('gui_macvim')
  let uname = system('uname')
  if uname =~? "linux"
    set term=builtin_linux
  elseif uname =~? "freebsd"
    set term=builtin_cons25
  elseif uname =~? "Darwin"
    " macでワーニングが出る
    "set term=beos-ansi
    set term=builtin_xterm
  else
    set term=builtin_xterm
  endif
  unlet uname
endif

"---------------------------------------------------------------------------
" コンソール版で環境変数$DISPLAYが設定されていると起動が遅くなる件へ対応
if !has('gui_running') && has('xterm_clipboard')
  set clipboard=exclude:cons\\\|linux\\\|cygwin\\\|rxvt\\\|screen
endif

"---------------------------------------------------------------------------
" プラットホーム依存の特別な設定

" WinではPATHに$VIMが含まれていないときにexeを見つけ出せないので修正
if has('win32') && $PATH !~? '\(^\|;\)' . escape($VIM, '\\') . '\(;\|$\)'
  let $PATH = $VIM . ';' . $PATH
endif

if has('mac')
  " Macではデフォルトの'iskeyword'がcp932に対応しきれていないので修正
  set iskeyword=@,48-57,_,128-167,224-235
endif

if has('gui_macvim')
  let $PATH = simplify($VIM . '/../../MacOS') . ':' . $PATH
	"------------------vundle setup----------------
	filetype off

	set rtp+=~/.vim/vundle.git/
	call vundle#rc()

  "Bundle 'Shougo/neocomplcache'
	Bundle 'bling/vim-airline'
	Bundle 'hail2u/h2u_colorscheme'

	"Bundle 'vim-ruby/vim-ruby'
  "Bundle 'plasticboy/vim-markdown'
  "Bundle 'mattn/emmet-vim'

	"Bundle 'othree/html5.vim'
	"Bundle "jelera/vim-javascript-syntax"
	"Bundle "hail2u/vim-css3-syntax"

	"Bundle 'skammer/vim-css-color'
	"Bundle 'https://github.com/gorodinskiy/vim-coloresque.git'

	"Bundle 'Lokaltog/vim-easymotion'
	"Bundle 'o24/zencoding-vim'
	

	"Bundle 'suan/vim-instant-markdown'
	"Bundle 'Markdown'
	"Bundle 'msanders/cocoa.vim'
	"Bundle 'vim-scripts/sudo.vim'
	"Bundle 'o24/vim-scala'
	"Bundle 'groenewege/vim-less'
	"Bundle 'vim-scripts/VOoM'

	"Bundle 'o24/gmail.vim'

	"Bundle 'Shougo/unite.vim'
	"Bundle 'o24/actionscript.vim'
	"Bundle 'o24/evervim'
	"Bundle 'cespare/mxml.vim'
	"Bundle 'o24/todo.vim'
	"Bundle 'vim-scripts/JSON.vim'
	"tabが2カラムになるじゃん
	"Bundle 'derekwyatt/vim-scala'

	"Bundle 'nathanaelkane/vim-indent-guides'
	"Bundle 'vim-scripts/ruby-matchit'
	"Bundle 'tpope/vim-endwise'

	" ctags
	"Bundle 'szw/vim-tags'

	"-------- color scheme -------------
	"Bundle 'vim-scripts/newspaper.vim'
	"Bundle 'https://github.com/flazz/vim-colorschemes'
	"Bundle 'altercation/vim-colors-solarized'

	filetype plugin indent on
	"------------------vundle setup----------------
endif

"---------------------------------------------------------------------------
"改行コードの自動判別
set fileformats=unix,dos,mac

" =================== neocomplecache =========================
"let g:neocomplcache_enable_at_startup = 1
"let g:neocomplcache_enable_smart_case = 1
"let g:neocomplcache_enable_camel_case_completion = 1
"let g:neocomplcache_enable_underbar_completion = 1
"
"let g:neocomplcache_min_syntax_length = 2
"let g:NeoComplCache_MinKeywordLength = 1
"
"let g:neocomplcache_auto_completion_start_length = 1
"" 1番目の候補を自動選択
"let g:neocomplcache_enable_auto_select = 1
"
""inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"noremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()
"
"" 補完候補が表示されている場合は確定。そうでない場合は改行
"inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"

set paste
" 他のエディタで更新された場合自動更新する
set autoread

" =================== unite =========================
" 入力モードで開始する
"let g:unite_enable_start_insert=1
"let g:unite_enable_split_vertically = 1 "縦分割で開く
"let g:unite_winwidth = 40 "横幅40で開く

"" バッファ一覧
"nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
"" ファイル一覧
"nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"" 常用セット
"nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
"" 全部乗せ
"nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
"
"nnoremap <silent> ,bo :<C-u>Unite bookmark file<CR>
" 
"" ESCキーを2回押すと終了する
"au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
"au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

"定義通り　ノーマルモードで "hoge" でコマンド実行
" !!!!! これ有効にするとhで移動時にカーソルが１個ズレるよ。
"nnoremap <silent> hoge :<C-u>echo "!!!hogehoge"<CR>
"nnoremap <silent>:<C-u>foo :<C-u>echo "!!!foo"<CR>
"nnoremap <silent>:bar :<C-u>echo "!!!bar"<CR>

"定義通り　ノーマルモードで "_(スペース)w" でコマンド実行
"nnoremap <Space>w :<C-u>pwd<CR>

" ================ evervim ====================
" 初期設定
" let g:evervim_devtoken='S=s19:U=1ff212:E=1448b788249:C=13d33c75649:P=1cd:A=en-devtoken:V=2:H=34a07ea056c2eb760ce8e7856b0260c9'

" ノーマルモードでのバインド
" nnoremap <silent> ,ec :<C-u>EvervimCreateNote<CR>
" nnoremap <silent> ,et :<C-u>EvervimListTags<CR>
" nnoremap <silent> ,en :<C-u>EvervimNotebookList<CR>

" コマンドモードでのバインド
"map! ec EvervimCreateNote
"map! et EvervimListTags
"map! en EvervimNotebookList

" 同時に<>とかって入力すると間にカーソルしてくれる
"inoremap {} {}<Left>
"inoremap [] []<Left>
"inoremap () ()<Left>
"inoremap "" ""<Left>
"inoremap '' ''<Left>
"inoremap <> <><Left>
"

" ================ gmail.vim ====================
"

" ================ vimfiler ====================
" vimfiler を:eで起動
" let g:vimfiler_as_default_explorer = 1

" ================ actionscript,mxml ====================
"autocmd BufNewFile,BufRead *.as set filetype=actionscript
"autocmd BufNewFile,BufRead *.mxml set filetype=mxml
"autocmd BufNewFile,BufRead *.as set filetype=actionscript
"autocmd BufNewFile,BufRead *.mxml set filetype=mxml

" ================ todo ====================
autocmd BufNewFile,BufRead *.todo set filetype=todo


" ================ vim-airline ====================
let g:airline_theme='dark'

" ================ VOom, Marked ====================
"autocmd BufNewFile,BufRead *.md Voom markdown
"autocmd BufNewFile,BufRead *.md set filetype=mkd

" コマンド定義はこの方法(英大文字から始まらないといけない)
":command! Voomd :Voom markdown
":command! Mark :!open -a Marked.app '%:p'

" ================ その他 ====================
" コメントが自動で入るのをoff
autocmd FileType * set formatoptions-=ro

" ================ markdown ====================
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" ================ vim-indent-guides ====================
"" vim立ち上げたときに、自動的にvim-indent-guidesをオンにする
"let g:indent_guides_enable_on_vim_startup=1
"" ガイドをスタートするインデントの量
"let g:indent_guides_start_level=2
"" 自動カラーを無効にする
"let g:indent_guides_auto_colors=0
"" 奇数インデントのカラー
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#C97AD3 ctermbg=gray
"" 偶数インデントのカラー
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#79D1A0 ctermbg=darkgray
"" ハイライト色の変化の幅
"let g:indent_guides_color_change_percent = 30
"" ガイドの幅
"let g:indent_guides_guide_size = 1
"

" ================ vim-tags ====================
"au BufNewFile,BufRead *.rb set tags+=$HOME/ruby.tags
"au BufNewFile,BufRead *.rb let g:vim_tags_project_tags_command = "ctags --languages=ruby --exclude='*.js' -f ~/ruby.tags `pwd` 2>/dev/null &"

" 飛ぶ
nnoremap <C-j> g<C-]>

" 戻る
nnoremap <C-k> <C-t>

" xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx キーバインドの説明 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

" =============== キーバインド ==============="
" 既存のコマンドのalias的な意味合い
" 短いキーが向いている
"
" メリット
"	1. モード別に定義できる
"
" デメリット 
" 	1. ゆっくり入力しているとタイムオーバーになる
" 	2. 補完されない

" ノーマルモードでのバインド
" nnoremap <silent> ,ec :<C-u>EvervimCreateNote<CR>

" コマンドモードでのバインド
"map! en EvervimNotebookList

" インサートモードでのバインド
" inoremap <silent> ,ec :<C-u>EvervimCreateNote<CR>

" =============== ユーザ定義コマンド ==============="
" ユーザ独自でコマンドを定義できる
" メリット
" 	1. 補完してくれる

":command! Voomd :Voom markdown
":command! Mark :!open -a Marked.app '%:p'


" =============== キーバインド(プレフィックス編) ==============="
" プレフィックスを付けてキーバインドを定義できる

"nnoremap [o24]    <Nop>

" ,o を押すとプレフィックス発動
"nmap     ,o [o24]
"nmap     <Space>u [o24]

" ,oa と押すと echo !!!a を実行
"nnoremap <silent> [o24]a :<C-u>echo "!!!a"<CR>
"nnoremap <silent> [o24]b :<C-u>echo "!!!b"<CR>
"nnoremap <silent> [o24]c :<C-u>echo "!!!c"<CR>

" =============== ruby endwise設定 ==============="
"function! s:my_crinsert()
"    return pumvisible() ? neocomplcache#close_popup() : "\<Cr>"
"endfunction
"inoremap <silent> <CR> <C-R>=<SID>my_crinsert()<CR>

" Lokaltog/vim-easymotion
"let g:EasyMotion_keys='hklyuiopnmqwertzxcvbasdgjf'
"let g:EasyMotion_leader_key=";"
"let g:EasyMotion_smartcase = 2
"let g:EasyMotion_startofline = 0
"let g:EasyMotion_use_migemo = 1
"
"nmap f <Plug>(easymotion-s)
"vmap f <Plug>(easymotion-s)
"" surround.vimとかぶるので`z`
" #omap z <Plug>(easymotion-s) 

"------'skammer/vim-css-color'
"let g:cssColorVimDoNotMessMyUpdatetime = 1


"  ruby激重対策
" 原因はsyntax
"let g:ruby_path = "" 
"
""http://d.hatena.ne.jp/gnarl/20120308/1331180615
"autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
"autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
"

"nnoremap <C-n> gt
nnoremap <C-s-tab> gT
nnoremap <C-tab> gt

nnoremap <C-h> gT
nnoremap <C-l> gt

