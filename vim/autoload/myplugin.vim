" File Name   : myplugin.vim
" Author      : KnightCS
" Description : My vim plugin.
"  version 3.0: 2017-01-27
"   reorganize.
"  version 2.0: **
"   add some configure and grouping.
"  version 1.0: **
"   create.

" 0. Plugin List
" ==========
" {{{
" vim-plug: 插件管理
" ----------
" nerdtree: 文件目录树
"   open/close NERDTree: <leader>nt
" tagbar: tag列表
"   open/close tagbar: <leader>tb
" ----------
" neocomplete: 补全插件
"   (ycm由于不支持cygwin，同时更新时需要重编译，所以去掉了)
" ultisnips:模板补全
"    load: <c-l>
"    netx: <c-j>
"    back: <c-k>
" ----------
" syntastic: 语法检查
"   listerr: <Leader>sl
"   nexterr: <Leader>sn
"   preverr: <Leader>sp
" ale: 语法检查
"   list_err:  <Leader>sl
"   prev_wrap: <Leader>sp
"   next_wrap: <Leader>sn
" ----------
" unite:
"   open unite:  <leader>u
" denite.nvim:
"   open denite: <leader>d
" ----------
" vim-easy-align: 指定对齐
"    对齐: <leader>a
" vim-trailing-whitespace: 去掉末尾空格/缩进
"   delete end of space: <leader>d<space>
" vim-surround: 快速加环绕
"   注：左边符号不带空格，右边符号带空格（[:[a]; ]:[ a ]）
"   cs:  change
"   cst: change tag
"   ds:  delete
"   ysi: add
"   cs:  add
"   yss: add for whole line
"   ySS: add the symbols up and down the whole line
" nerdcommenter: 注释
"   加注释:                <leader>cc
"   解开注释:              <leader>cu
"   加/解开注释，智能判断: <leader>c<space>
" pangu: 中文排版自动规范化插件
"   排版并规范化: <leader>gq
" ----------
" vim-easymotion: 快速跳转
"   move to char: <leader>ec
"   move to {char}{char}: <leader>e2c
"   move to line: <leader>el
"   move to word: <leader>ew
" vim-expand-region: 视图模式下可伸缩选中部分
"   加选中区域: v
"   少选中区域: V
" vim-choosewin: 类型tmux的选择pane
"   显示序号: <c-w>q
" matchit: 匹配跳转
"   跳转: %
" ----------
" }}}

" 1. Enter Function
" ==========
" {{{
function! myplugin#begin()
    " auto download the plug.vim file
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -s --connect-timeout 5 -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endfunction
call plug#begin('~/.vim/plugged')
" }}}

" 2. Plugin
" ==========
" 2.1 UI
" ----------
" 状态栏&标题栏，使用更高效率的 lightline
Plug 'itchyny/lightline.vim'
" {{{
let g:lightline = {
            \ 'colorscheme': 'solarized',
            \ 'mode_map': { 'c': 'NORMAL' },
            \ 'active':   {
            \   'left':   [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
            \   'right':  [ [ 'syntastic', 'lineinfo' ], ['percent'],
            \       [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'inactive': {
            \   'left': [ ['filename'] ],
            \   'right': [  ],
            \ },
            \ 'component_function': {
            \   'mode':         'LightlineMode',
            \   'readonly':     'LightlineReadonly',
            \   'fugitive':     'LightlineFugitive',
            \   'modified':     'LightlineModified',
            \   'filename':     'LightlineFilename',
            \   'syntastic':    'LightlineSyntastic',
            \   'lineinfo':     'LightlineLineInfo',
            \   'percent':      'LightlinePercent',
            \   'fileformat':   'LightlineFileformat',
            \   'fileencoding': 'LightlineFileencoding',
            \   'filetype':     'LightlineFiletype',
            \ },
            \ 'component_expand': {
            \   'syntastic': 'ALEGetStatusLine',
            \ },
            \ 'component_type': {
            \   'syntastic': 'warning',
            \ },
            \ 'separator':    { 'left': "\ue0b0", 'right': "\ue0b2" },
            \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
            \ }

function! LightlineModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
    return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "\ue0a2" : ''
endfunction

function! LightlineFilename()
    let fname = expand('%:t')
      return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
    if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
        let branch = fugitive#head()
        return branch !=# '' ? "\ue0a0 ".branch : ''
    endif
    return ''
endfunction

function! LightlineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightlineLineInfo() abort
    return winwidth(0) > 35 ? printf(" %03d:%-2d", line('.'), col('.')) : ''
endfunction

function! LightlinePercent() abort
    return winwidth(0) > 35 ? (100 * line('.') / line('$')).'%' : ''
endfunction

function! LightlineSyntastic() abort
    return ''
endfunction

function! LightlineMode()
    let fname = expand('%:t')
    return fname == '__Tagbar__' ? 'Tagbar' :
                \ fname == 'ControlP' ? 'CtrlP' :
                \ fname == '__Gundo__' ? 'Gundo' :
                \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
                \ fname =~ 'NERD_tree' ? 'NERDTree' :
                \ &ft == 'unite' ? 'Unite' :
                \ &ft == 'vimfiler' ? 'VimFiler' :
                \ &ft == 'vimshell' ? 'VimShell' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" }}}

Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTree' ] }
" {{{
let NERDTreeAutoCenter            = 1
let NERDTreeMinimalUI             = 1
let NERDTreeShowHidden            = 0
let g:NERDTreeDirArrowExpandable  = '➧'
let g:NERDTreeDirArrowCollapsible = '☇'
let NERDTreeAutoDeleteBuffer      = 1
let NERDTreeWinSize               = 30
let NERDTreeIgnore                = [ '\.pyc$', '\.pyo$', '\.obj$', '\.o$',
            \ '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
let g:netrw_home                  = '~/.cache/nerdtree'

" 自动打开
autocmd VimEnter * if !argc() || isdirectory(argv(0)) | NERDTree | wincmd p | bd | wincmd p

" 快捷键
map <leader>nt :NERDTreeToggle<cr>
" }}}

" nerdtree 增强
Plug 'jistr/vim-nerdtree-tabs', { 'on': [ 'NERDTreeToggle', 'NERDTree' ] }
" {{{
g:nerdtree_tabs_open_on_console_startup = 2
g:nerdtree_tabs_autofind                = 1
" }}}

Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': [ 'NERDTreeToggle', 'NERDTree' ] }
" {{{
let g:NERDTreeShowIgnoredStatus  = 1
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ "Unknown"   : "?"
            \ }
" }}}

" 调用外部命令运行当前文件
Plug 'nerdtree-execute', { 'on': [ 'NERDTreeToggle', 'NERDTree' ] }

" 给 nerdtree 增加搜索功能
Plug 'NERDTree-ack', { 'on': [ 'NERDTreeToggle', 'NERDTree' ] }

" tagbar
Plug 'Tagbar', { 'on': 'TagbarToggle' }
" {{{
" auto open when open a c++ file
"autocmd FileType [ch],[ch]pp,cc nested :TagbarOpen
" set the window's width
let g:tagbar_width = 20
let g:tagbar_ctags_bin='/usr/bin/ctags'
nmap <leader>tb :TagbarToggle<cr>
" }}}

" git插件
Plug 'cohama/agit.vim'
" {{{
let g:agit_no_default_mappings = 1
let g:agit_ignore_spaces       = 0
" }}}

" 显示当前文件跟仓库的差异
Plug 'mhinz/vim-signify'

" 2.2 File Type
" ----------
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" 2.3 complete
" ----------
Plug 'Shougo/neocomplete.vim'
" {{{
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 1
let g:neocomplete#lock_buffer_name_pattern          = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.cache/.vimshell_hist',
            \ 'scheme' : $HOME.'/.cache/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <cr>: close popup and save indent.
inoremap <silent> <cr> <c-r>=<sid>my_cr_function()<cr>
function! s:my_cr_function()
    return (pumvisible() ? "\<c-y>" : "" ) . "\<cr>"
    " For no inserting <cr> key.
    "return pumvisible() ? "\<c-y>" : "\<cr>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<c-n>" : "\<tab>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><c-h> neocomplete#smart_close_popup()."\<c-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<c-h>"
" Close popup by <Space>.
"inoremap <expr><space> pumvisible() ? "\<c-y>" : "\<space>"

" AutoComplPop like behavior.
" No AutoComplPop
let g:neocomplete#enable_auto_select = 0

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php
            \   = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c
            \   = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp
            \   = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl
            \   = '\h\w*->\h\w*\|\h\w*::'
" }}}

" 快速插入代码片段 & 代码片段配置
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
" {{{
" Plugin key-mappings.
imap <C-l> <Plug>(neosnippet_expand_or_jump)
smap <C-l> <Plug>(neosnippet_expand_or_jump)
xmap <C-l> <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB>
            \ pumvisible() ? "\<C-n>" :
            \ neosnippet#expandable_or_jumpable() ?
            \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
if !empty(g:plug_home)
    let g:neosnippet#snippets_directory = g:plug_home.expand('/vim-snippets/snippets')
endif
" }}}

" 显示函数参数
Plug 'Shougo/echodoc.vim'

" 2.4 语法检测
" ----------
if version < 800 && !has('nvim')
    Plug 'scrooloose/Syntastic'
    " {{{
    let g:syntastic_check_on_open             = 1
    let g:syntastic_cpp_include_dirs          = ['/usr/include/']
    let g:syntastic_cpp_remove_include_errors = 1
    let g:syntastic_cpp_check_header          = 1
    let g:syntastic_cpp_compiler              = 'clang++'
    let g:syntastic_cpp_compiler_options      = '-std=c++11 -stdlib=libstdc++'
    " whether to show balloons
    let g:syntastic_enable_balloons = 1
    " set error or warning signs
    let g:syntastic_error_symbol         = '✗'
    let g:syntastic_warning_symbol       = '•'
    let g:syntastic_style_error_symbol   = '✗'
    let g:syntastic_style_warning_symbol = '•'
    " whether to show balloons
    let g:syntastic_enable_highlighting = 1
    let g:syntastic_enable_balloons     = 1
    " 外部插件，检查效率比较高
    let g:syntastic_aggregate_errors      = 1
    let g:syntastic_python_checkers       = ['flake8']
    let g:syntastic_javascript_checkers   = ['jsl', 'jshint']
    let g:syntastic_php_checkers          = ['php', 'phpcs', 'phpmd']
    let g:syntastic_html_checkers         = ['tidy', 'jshint']
    let g:syntastic_shell_checkers        = ['shellcheck']
    let g:syntastic_shell_shellcheck_args = "-x"
    " to see error location list
    let g:syntastic_always_populate_loc_list = 0
    let g:syntastic_auto_loc_list            = 0
    let g:syntastic_loc_list_height          = 5
    function! ToggleErrors()
        let old_last_winnr = winnr('$')
        lclose
        if old_last_winnr == winnr('$')
            " Nothing was closed, open syntastic error location panel
            Errors
        endif
    endfunction
    " Keyword
    nnoremap <Leader>sl :call ToggleErrors()<cr>
    nnoremap <Leader>sp :lprevious<cr>
    nnoremap <Leader>sn :lnext<cr>
    " }}}
else
    Plug 'w0rp/ale'
    " {{{
    let g:ale_sign_column_always   = 1
    let g:ale_lint_on_save         = 1
    let g:ale_sign_open_list       = 1
    let g:ale_sign_error           = '✗'
    let g:ale_sign_warning         = '•'
    let g:ale_statusline_format    = ['✘ %d', '• %d', '✔']
    let g:ale_echo_msg_error_str   = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format      = '[%linter%] %s [%severity%]'
    function! ToggleErrors()
        let old_last_winnr = winnr('$')
        lclose
        if old_last_winnr == winnr('$')
            " Nothing was closed, open ale error location panel
            lopen
            4 wincmd _
            wincmd p
        endif
    endfunction
    function! AutoClose()
        " Auto close location list
        if len(getloclist(0)) == 0
            lclose
        endif
    endfunction
    function! Update_light()
        if exists('*lightline#update')
            call lightline#update()
        elseif exists('*SyntasticCheck')
            call SyntasticCheck()
        endif
    endfunction
    augroup update_after_alelint
        autocmd!
        autocmd User ALELint call AutoClose()
        autocmd User ALELint call Update_light()
    augroup END
    " Keyword
    nmap <silent> <Leader>sl :call ToggleErrors()<cr>
    nmap <silent> <Leader>sp <Plug>(ale_previous_wrap)
    nmap <silent> <Leader>sn <Plug>(ale_next_wrap)
    " }}}
endif

" 2.5 Unite
" ----------
Plug 'Shougo/denite.nvim'
" {{{
map <leader>d :Denite<space>
" }}}

" 2.6 Code Formatting
" ----------
" 快速对齐
Plug 'junegunn/vim-easy-align'
" {{{
vmap <Leader>a <Plug>(EasyAlign)
" }}}

" 末尾空格
Plug 'bronson/vim-trailing-whitespace'
" {{{
map <Leader>d<space> :FixWhitespace<cr>
" }}}

" 自动补全成对符号
Plug 'jiangmiao/auto-pairs'
" {{{
let g:AutoPairsShortcurToggle     = ''
let g:AutoPairsShortcutFastWrap   = ''
let g:AutoPairsShortcutJump       = ''
let g:AutoPairsShortcutBackInsert = ''
let g:AutoPairsCenterLine         = 0
let g:AutoPairsMultilineClose     = 0
let g:AutoPairsMapBS              = 1
let g:AutoPairsMapCh              = 0
let g:AutoPairsMapCR              = 0
let g:AutoPairsCenterLine         = 0
let g:AutoPairsMapSpace           = 0
let g:AutoPairsFlyMode            = 0
let g:AutoPairsMultilineClose     = 0
" }}}

" 快速给词加环绕符号
Plug 'tpope/vim-surround'

" 快速注释
Plug 'scrooloose/nerdcommenter'
" {{{
let g:NERDSpaceDelims = 1
" }}}

" 中文排版自动规范化插件
Plug 'hotoo/pangu.vim', { 'for': ['markdown', 'text', 'wiki', 'cnx'] }
" {{{
" 对文本文档进行自动换行
function! AutoWrapWithText() abort
    if &filetype == 'markdown' || &filetype == 'text'
        " 设置换行
        set textwidth=78
        " 中文字符适应 textwidth 换行
        set formatoptions+=Mm
        " 错误线提到79行
        set colorcolumn=79
        " 添加拼写检查
        set spell
        " 添加快捷键进行排版 + 格式纠错
        nmap <silent> <leader>gq :Pangu<c-r>gggqG2<c-o>
    endif
endfunction
autocmd! BufWinEnter * call AutoWrapWithText()
" }}}

" 2.7 Operating
" ----------
" 快速移动
Plug 'easymotion/vim-easymotion'
" {{{
" <Leader>c{char} to move to {char}
map  <Leader>ec <Plug>(easymotion-bd-f)
nmap <Leader>ec <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
map  <Leader>e2c <Plug>(easymotion-bd-f2)
nmap <Leader>e2c <Plug>(easymotion-overwin-f2)
" Move to line
map  <Leader>el <Plug>(easymotion-bd-jk)
nmap <Leader>el <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>ew <Plug>(easymotion-bd-w)
nmap <Leader>ew <Plug>(easymotion-overwin-w)
" }}}
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
" {{{
" EasyMotion.
function! s:incsearch_config(...) abort
    return incsearch#util#deepextend(deepcopy({
                \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
                \   'keymap': {
                \     "\<CR>": '<Over>(easymotion)'
                \   },
                \   'is_expr': 0
                \ }), get(a:, 1, {}))
endfunction
noremap <silent><expr> /  incsearch#go(<SID>incsearch_config())
noremap <silent><expr> ?  incsearch#go(<SID>incsearch_config({'command': '?'}))
noremap <silent><expr> g/ incsearch#go(<SID>incsearch_config({'is_stay': 1}))

function! s:config_easyfuzzymotion(...) abort
    return extend(copy({
                \   'converters': [incsearch#config#fuzzyword#converter()],
                \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
                \   'keymap': {"\<CR>": '<Over>(easymotion)'},
                \   'is_expr': 0,
                \   'is_stay': 1
                \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
" }}}

" 视图模式下伸缩选中部分
Plug 'terryma/vim-expand-region'
" {{{
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
" }}}

" 选择窗口
Plug 't9md/vim-choosewin'
" {{{
" Like tmux，"perfix + q" to show windows number, vim's prefix is <C-w>
nmap <C-w>q <Plug>(choosewin)
" }}}

" 2.8 Other tools
" ----------
" 文件搜索
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" 3. END
" ==========
call plug#end()
