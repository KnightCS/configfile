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
" ZoomWin: 最大化当前窗口
"   最大化/复原: <c-o>
" ----------
" neocomplete: 补全插件
"   (ycm由于不支持cygwin，同时更新时需要重编译，所以去掉了)
" ultisnips:模板补全
"    load: <c-l>
"    netx: <c-j>
"    back: <c-k>
" ----------
" syntastic: 语法检查
"   listerr: <leader>sl
"   nexterr: <leader>sn
"   preverr: <leader>sp
" ale: 语法检查
"   list_err:  <leader>sl
"   prev_wrap: <leader>sp
"   next_wrap: <leader>sn
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
" gina: git 增强插件
"   查看 git 状态: <leader>gs
"   提交 git 修改: <leader>gm
" }}}

" 1. Enter Function
" ==========
" {{{
function! myplugin#begin()
    " auto download the plug.vim file
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -s --connect-timeout 5 -fLo ~/.vim/autoload/plug.vim --create-dirs
                    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
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
Plug 'mgee/lightline-bufferline'
" {{{
let g:lightline = {
            \ 'colorscheme': 'solarized',
            \ 'tabline': {
            \   'left':  [ ['buffers'] ],
            \   'right': [ ['close'] ],
            \ },
            \ 'mode_map': { 'c': 'NORMAL' },
            \ 'active':   {
            \   'left':   [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
            \   'right':  [ [ 'syntastic', 'lineinfo' ], ['percent'],
            \       [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ },
            \ 'inactive': {
            \   'left': [ ['filename'] ],
            \   'right': [ ['path'] ],
            \ },
            \ 'component_function': {
            \   'mode':         'LightlineMode',
            \   'readonly':     'LightlineReadonly',
            \   'fugitive':     'LightlineFugitive',
            \   'modified':     'LightlineModified',
            \   'path':         'LightlinePath',
            \   'filename':     'LightlineFilename',
            \   'syntastic':    'LightlineSyntastic',
            \   'lineinfo':     'LightlineLineInfo',
            \   'percent':      'LightlinePercent',
            \   'fileformat':   'LightlineFileformat',
            \   'fileencoding': 'LightlineFileencoding',
            \   'filetype':     'LightlineFiletype',
            \ },
            \ 'component_expand': {
            \ 'buffers':   'lightline#bufferline#buffers',
            \ 'syntastic': 'ALEGetStatusLine',
            \ },
            \ 'component_type': {
            \   'buffers':   'tabsel',
            \   'syntastic': 'warning',
            \ },
            \ 'separator':    { 'left': "\ue0b0", 'right': "\ue0b2" },
            \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
            \ }

function! LightlineModified()
    return &filetype =~? 'help\|vimfiler\|gundo' ?
                \ '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
    return &filetype !~? 'help\|vimfiler\|gundo' && &readonly ?
                \ "\ue0a2" : ''
endfunction

function! LightlineFilename()
    let l:fname = expand('%:t')
    return l:fname =~? 'ControlP' && has_key(g:lightline, 'ctrlp_item') ?
                \   g:lightline.ctrlp_item :
                \ l:fname =~? '__Tagbar__' ? has_key(g:lightline, 'fname') ?
                \   g:lightline.fname : 'Tagbar' :
                \ l:fname =~? '__Gundo\|NERD_tree' ? '' :
                \ &filetype ==? 'vimfiler' ? vimfiler#get_status_string():
                \ &filetype ==? 'unite'    ? unite#get_status_string():
                \ &filetype ==? 'vimshell' ? vimshell#get_status_string():
                \ ('' !=# LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
                \ ('' !=# l:fname ? l:fname : '[No Name]') .
                \ ('' !=# LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlinePath() abort
    return winwidth(0) > 60 ? expand('%:p:h') : ''
endfunction

function! LightlineFugitive()
    if &filetype !~? 'vimfiler\|gundo' && exists('*fugitive#head')
        let l:branch = fugitive#head()
        return l:branch !=# '' ? "\ue0a0 ".l:branch : ''
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
    return winwidth(0) > 70 ? (&fileencoding !=# '' ?
                \ &fileencoding : &encoding) : ''
endfunction

function! LightlineLineInfo() abort
    return winwidth(0) > 35 ? printf(' %03d:%-2d', line('.'), col('.')) : ''
endfunction

function! LightlinePercent() abort
    return winwidth(0) > 35 ? (100 * line('.') / line('$')).'%' : ''
endfunction

function! LightlineSyntastic() abort
    return ''
endfunction

function! LightlineMode()
    let l:fname = expand('%:t')
    return l:fname =~# '__Tagbar__' ? 'Tagbar' :
                \ l:fname =~# 'ControlP' ? 'CtrlP' :
                \ l:fname =~# '__Gundo__' ? 'Gundo' :
                \ l:fname =~# '__Gundo_Preview__' ? 'Gundo Preview' :
                \ l:fname =~# 'NERD_tree' ? 'NERDTree' :
                \ &filetype ==? 'unite' ? 'Unite' :
                \ &filetype ==? 'vimfiler' ? 'VimFiler' :
                \ &filetype ==? 'vimshell' ? 'VimShell' :
                \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" lightline-bufferline
let g:lightline#bufferline#show_number = 2
" Add buffer map in enter.
for s:i in range(1,bufnr('$'))
    call AddNewBufferGoMap(s:i)
endfor
function! AddNewBufferGoMap(bufnr) abort
    if !empty(&buftype)
        return
    endif
    let l:bufnr = a:bufnr ? a:bufnr : -1
    if l:bufnr == -1
        let l:bufname = (lightline#bufferline#buffers())[1]
        if empty(l:bufname)
            return
        endif
        let l:bufnr = substitute(l:bufname[0], '^\([0-9]*\) .*', '\1', 'g')
    endif
    exec 'nmap <silent> <SID>(buffer-'.l:bufnr.') '.
                \' <Plug>lightline#bufferline#go('.l:bufnr.')'
    exec 'nmap <leader>b'.l:bufnr.' <SID>(buffer-'.l:bufnr.')'
endfunction
augroup au_bufmap
    autocmd!
    autocmd BufNewFile,BufReadPost * call AddNewBufferGoMap(0)
augroup end
" }}}

" height light cursorword
Plug 'itchyny/vim-cursorword'

" leader guide
Plug 'hecal3/vim-leader-guide'
" {{{
let g:lmap = {}
" Buffer map
let g:lmap.b = { 'name': '+Buffer' }
" buffer option
nnoremap <silent> <SID>(buffer-delete)   :bd<CR>
nnoremap <silent> <SID>(buffer-next)     :bn<CR>
nnoremap <silent> <SID>(buffer-previous) :bp<CR>
nmap <leader>bd <SID>(buffer-delete)
nmap <leader>bn <SID>(buffer-next)
nmap <leader>bp <SID>(buffer-previous)
" Windows map
let g:lmap.w = { 'name': '+Windows' }
" split windows
nnoremap <silent> <SID>(windows-split-right)   :vs +enew<CR><C-W><C-X><C-W><C-P>
nnoremap <silent> <SID>(windows-split-left)    :vs +enew<CR>
nnoremap <silent> <SID>(windows-vsplit-bottom) :sp +enew<CR><C-W><C-X><C-W><C-P>
nnoremap <silent> <SID>(windows-vsplit-top)    :sp +enew<CR>
nmap <leader>w\ <SID>(windows-split-right)
nmap <leader>w\| <SID>(windows-split-left)
nmap <leader>w- <SID>(windows-vsplit-top)
nmap <leader>w_ <SID>(windows-vsplit-bottom)
" fresh windows
nnoremap <silent> <SID>(windows-fresh) :redrew!<CR>
nmap <leader>wf <SID>(windows-fresh)

let g:topdict = {}
exec 'let g:topdict["'.g:mapleader.'"] = g:lmap'
exec 'let g:topdict["'.g:mapleader.'"]["name"] = "<leader>"'
exec 'let g:topdict["'.g:maplocalleader.'"] = g:llmap'
exec 'let g:topdict["'.g:maplocalleader.'"]["name"] = "<localleader>"'

call leaderGuide#register_prefix_descriptions('', 'g:topd')
exec 'nnoremap <silent> <leader> :<c-u>LeaderGuide "'.
            \ g:mapleader.'"<CR>'
exec 'vnoremap <silent> <leader> :<c-u>LeaderGuideVisual "'.
            \ g:mapleader.'"<CR>'
exec 'nnoremap <localsilent> <leader> :<c-u>LeaderGuide "'.
            \ g:maplocalleader.'"<CR>'
exec 'vnoremap <localsilent> <leader> :<c-u>LeaderGuideVisual "'.
            \ g:maplocalleader.'"<CR>'
nmap <leader>. <Plug>leaderguide-global
nmap <localleader>. <Plug>leaderguide-buffer

function! s:my_displayfunc()
    let g:leaderGuide#displayname =
                \ substitute(g:leaderGuide#displayname, '\c<cr>$', '', '')
    let g:leaderGuide#displayname =
                \ substitute(g:leaderGuide#displayname, '^<Plug>', '', '')
    let g:leaderGuide#displayname =
                \ substitute(g:leaderGuide#displayname, '^<SID>', '', '')
    let g:leaderGuide#displayname =
                \ substitute(g:leaderGuide#displayname, '^:call', '', '')
    let g:leaderGuide#displayname =
                \ substitute(g:leaderGuide#displayname, '^(\(.*\))$', '\1', 'g')
    let g:leaderGuide#displayname =
                \ substitute(g:leaderGuide#displayname, '-', ' ', 'g')
endfunction
let g:leaderGuide_displayfunc = [function('s:my_displayfunc')]
" }}}

" 有趣的开始导航
Plug 'mhinz/vim-startify', { 'on': 'Startify' }
" {{{
let g:startify_custom_header = [
            \ '@@@@   @@@@',
            \ ' @@   @@@   @@    @@@@a.a@@a.a@@.',
            \ ' @@  @@@           @@@@@@@@@@@@@@',
            \ ' @@ @@@    `@@     @@   @@   @@@',
            \ ' @@a@@      @@   ,@@  ,@@  ,@@@',
            \ ' @@@`      @@@@  @@@  @@@  @@@@@'
            \ ]
function! s:filter_header(lines) abort
    let l:longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
    let l:winwidth       = winwidth('$')
    let l:centered_lines = map(copy(a:lines),
                \ 'repeat(" ", (&columns / 2) - l:longest_line ) . v:val')
    return l:centered_lines
endfunction
let g:startify_custom_header = s:filter_header(g:startify_custom_header)
" }}}

" 文件夹导航
Plug 'scrooloose/nerdtree', { 'on': [ 'NERDTreeToggle', 'NERDTree' ] }
Plug 'jistr/vim-nerdtree-tabs', { 'on': [ 'NERDTreeToggle', 'NERDTree' ] }
Plug 'vim-scripts/nerdtree-ack', { 'on': [ 'NERDTreeToggle', 'NERDTree' ] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': [ 'NERDTreeToggle', 'NERDTree' ] }
Plug 'vim-scripts/nerdtree-execute', { 'on': [ 'NERDTreeToggle', 'NERDTree' ] }
" {{{
let g:NERDTreeAutoCenter          = 1
let g:NERDTreeMinimalUI           = 1
let g:NERDTreeShowHidden          = 0
let g:NERDTreeDirArrowExpandable  = '➧'
let g:NERDTreeDirArrowCollapsible = '☇'
let g:NERDTreeAutoDeleteBuffer    = 1
let g:NERDTreeWinSize             = 30
let g:netrw_home                  = '~/.cache/nerdtree'
let g:NERDTreeIgnore              = [ '\.pyc$', '\.pyo$', '\.obj$', '\.o$',
            \ '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]

" nerdtree-ack
" 给 nerdtree 增加搜索功能

" vim-nerdtree-tabs
let g:nerdtree_tabs_open_on_console_startup = 2

" nerdtree-git-plugin
let g:NERDTreeShowIgnoredStatus  = 1
let g:NERDTreeIndicatorMapCustom = {
            \ 'Modified'  : '✹',
            \ 'Staged'    : '✚',
            \ 'Untracked' : '✭',
            \ 'Renamed'   : '➜',
            \ 'Unmerged'  : '═',
            \ 'Deleted'   : '✖',
            \ 'Dirty'     : '✗',
            \ 'Clean'     : '✔︎',
            \ 'Unknown'   : '?'
            \ }

" nerdtree-execute
" 调用外部命令运行当前文件
" }}}

" tagbar
Plug 'majutsushi/tagbar', { 'on': ['TagbarToggle', 'TagbarOpen'] }
" {{{
call GetExternalBinary('ctags')
if exists('g:ctags_bin')
    let g:tagbar_ctags_bin = g:ctags_bin
endif

let g:tagbar_width     = 30
let g:tagbar_left      = 1
let g:tagbar_compact   = 1
let g:tagbar_iconchars = ['➧', '☇']
" 设置 ctags 对哪些代码标识符生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
         \ 'c:classes:0:1',
         \ 'd:macros:0:1',
         \ 'e:enumerators:0:0',
         \ 'f:functions:0:1',
         \ 'g:enumeration:0:1',
         \ 'l:local:0:1',
         \ 'm:members:0:1',
         \ 'n:namespaces:0:1',
         \ 'p:functions_prototypes:0:1',
         \ 's:structs:0:1',
         \ 't:typedefs:0:1',
         \ 'u:unions:0:1',
         \ 'v:global:0:1',
         \ 'x:external:0:1'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }
" }}}

" 显示当前文件跟仓库的差异
Plug 'mhinz/vim-signify'
" {{{
let g:signify_vcs_cmds = {
            \   'git': 'git diff --no-color --no-ext-diff -U0 HEAD -- %f',
            \ }
" }}}

" Zoom Windows
Plug 'troydm/zoomwintab.vim', { 'on': ['ZoomWinTabIn', 'ZoomWinTabOut', 'ZoomWinTabToggle'] }
" {{{
let g:zoomwintab_remap      = 0
let g:zoomwintab_hidetabbar = 0
nnoremap <silent> <SID>(maximize-windows)    :ZoomWinTabIn<CR>
nnoremap <silent> <SID>(recovery-windows)    :ZoomWinTabOut<CR>
nnoremap <silent> <SID>(zoom-toogle-windows) :ZoomWinTabToggle<CR>
nmap <leader>wm <SID>(maximize-windows)
nmap <leader>wr <SID>(recovery-windows)
nmap <leader>wz <SID>(zoom-toggle-windows)
" }}}

" Start vim ui
" -----
" 启动 vim 时启用的插件 {{{
function! BGStart_NERDTree(timer) abort
    if !empty(glob(g:plug_home.'/nerdtree'))
        NERDTree
        setlocal nocursorline
        wincmd p
        ene
    endif
endfunction
function! BGStart_Startify(timer) abort
    if !empty(glob(g:plug_home.'/vim-startify'))
        Startify
        nnoremap <buffer> q :qa<cr>
    endif
endfunction
function! VimEnterDealArgument() abort
    if !argc() || isdirectory(argv()[0])
        if !has('timers')
            call BGStart_NERDTree('')
            call BGStart_Startify('')
            return
        endif
        let l:t = timer_start(0, 'BGStart_NERDTree')
        let l:t = timer_start(25, 'BGStart_Startify')
    endif
endfunction
augroup au_vimstart
    autocmd!
    autocmd VimEnter * :call VimEnterDealArgument()
augroup END
"}}}

" Deal with NERDTree and Tagbar {{{
" +-----------+-------------+
" | Tagbar    |             |
" | contents  |             |
" +-----------+    File     |
" | NERDTree  |             |
" | contents  |             |
" +-----------+-------------+
function! ToggleNERDTreeAndTagbar(plugin) abort
    let s:plugin        = a:plugin
    let s:height        = &lines
    let s:nerdtree_open = (bufwinnr('NERD_tree')  != -1)
    let s:tagbar_open   = (bufwinnr('__Tagbar__') != -1)
    if s:plugin ==# 'nerdtree' && exists(':NERDTree')
        if !s:nerdtree_open && s:tagbar_open
            let s:plugin = 'tagbar'
            TagbarClose
        endif
        NERDTreeToggle
        let s:nerdtree_open = 1
    endif
    if s:plugin ==# 'tagbar' && exists(':TagbarToggle')
        if s:nerdtree_open
            let g:tagbar_vertical = s:height * 4 / 10
            NERDTreeFocus
        endif
        TagbarToggle
        if s:nerdtree_open
            let g:tagbar_vertical = 0
            NERDTreeFocusToggle
        endif
    endif
endfunction
" Toggle Tagbar
nnoremap <silent> <SID>(toggle-tagbar)
            \ :call ToggleNERDTreeAndTagbar('tagbar')<CR>
nmap <leader>wt <SID>(toggle-tagbar)
" Toggle NERDTree
nnoremap <silent> <SID>(toggle-nerdtree)
            \ :call ToggleNERDTreeAndTagbar('nerdtree')<CR>
nmap <leader>wn <SID>(toggle-nerdtree)
" }}}

" 2.2 File Type
" ----------
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Plantuml
Plug 'aklt/plantuml-syntax', { 'for': ['pu', 'uml', 'plantuml'] }
" {{{
let g:plantuml_path = ''
function! Uml2png() abort
    call system('java -version')
    if v:shell_error != 0
        echohl ErrorMsg | echom 'No java execute found!' | echohl NONE
        return
    endif

    if empty(g:plantuml_path) && !empty(glob(g:plug_home.'/vim-slumlord'))
        let g:plantuml_path = g:plug_home.'/vim-slumlord/plantuml.jar'
    else
        echohl ErrorMsg | echom 'No plantuml.jar found!' | echohl NONE
        return
    endif

    let l:file_name = expand('%:p')
    let l:jar_path  = g:plantuml_path
    if has('win32unix') || has('win64unix')
        let l:file_name = substitute(system('cygpath -aw "'.l:file_name.'"'),
                    \ '\n', '', '')
        let l:jar_path  = substitute(system('cygpath -aw "'.l:jar_path.'"'),
                    \ '\n', '', '')
    endif

    let l:cmd = 'java -jar "'.l:jar_path.'" -charset utf-8 "'.l:file_name.'"'
    if has('job')
        call job_start(l:cmd,
                    \ {'in_io': 'null', 'out_io': 'null', 'err_io': 'null'})
    else
        call system(l:cmd)
    endif
endfunction
nnoremap <silent> <SID>(create-png-from-uml) :call Uml2png()<CR>
nmap <leader>fp <SID>(create-png-from-uml)
" }}}

Plug 'scrooloose/vim-slumlord', { 'for': ['pu', 'uml', 'plantuml'] }
" {{{
let g:slumlord_au_created = 0
function! Uml2txt() abort
    if has('job')
        call slumlord#updatePreview({})
    endif
    call slumlord#updatePreview({'write': 1})
endfunction
nnoremap <silent> <SID>(create-txt-pic-from-uml) :call Uml2txt()<CR>
nmap <leader>ft <SID>(create-txt-pic-from-uml)
" }}}

" H 文件
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp', 'cc'] }

" 2.3 complete
" ----------
"Plug 'Shougo/neocomplete.vim'
"" {{{
"let g:acp_enableAtStartup = 0
"" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 1
"let g:neocomplete#lock_buffer_name_pattern          = '\*ku\*'
"let g:neocomplete#sources#tags#cache_limit_size     = 50000000
"
"" Define dictionary.
"let g:neocomplete#sources#dictionary#dictionaries = {
"            \ 'default' : '',
"            \ 'vimshell' : $HOME.'/.cache/.vimshell_hist',
"            \ 'scheme' : $HOME.'/.cache/.gosh_completions'
"            \ }
"
"" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
"" Plugin key-mappings.
""inoremap <expr><C-g>     neocomplete#undo_completion()
""inoremap <expr><C-l>     neocomplete#complete_common_string()
"
"" Recommended key-mappings.
"" <cr>: close popup and save indent.
"inoremap <silent> <cr> <c-r>=<sid>my_cr_function()<cr>
"function! s:my_cr_function()
"    "return (pumvisible() ? "\<c-y>" : "" ) . "\<cr>"
"    " For no inserting <cr> key.
"    return pumvisible() ? "\<c-y>" : "\<cr>"
"endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>   pumvisible() ? "\<c-n>" : "\<tab>"
"inoremap <expr><S-TAB> pumvisible() ? "\<c-p>" : "\<s-tab>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><c-h> neocomplete#smart_close_popup()."\<c-h>"
"inoremap <expr><BS>  neocomplete#smart_close_popup()."\<c-h>"
"" Close popup by <Space>.
"inoremap <expr><space> pumvisible() ? "\<c-y>" : "\<space>"
"
"" AutoComplPop like behavior.
"" No AutoComplPop
"let g:neocomplete#enable_auto_select = 0
"
"" Shell like behavior(not recommended).
""set completeopt+=longest
""let g:neocomplete#enable_auto_select = 1
""let g:neocomplete#disable_auto_complete = 1
""inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"
"" Enable omni completion.
"autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags
"
"" Enable heavy omni completion.
"if !exists('g:neocomplete#sources#omni#input_patterns')
"    let g:neocomplete#sources#omni#input_patterns = {}
"endif
"let g:neocomplete#sources#omni#input_patterns.php
"            \   = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c
"            \   = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp
"            \   = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.perl
"            \   = '\h\w*->\h\w*\|\h\w*::'
"" }}}

Plug 'maralla/completor.vim'
" {{{
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" c/c++
call GetExternalBinary('clang')
if exists('g:clang_bin')
    let g:completor_clang_binary = g:clang_bin
endif

" Python
let g:completor_python_binary = '/usr/lib/python3.4/site-packages/jedi'
" }}}

" 快速插入代码片段 & 代码片段配置
Plug 'maralla/completor-neosnippet'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'
" {{{
" neosnippet key-mappings.
imap <expr><cr>
            \ pumvisible() ?
            \ (neosnippet#expandable() ?
            \   neosnippet#mappings#expand_impl() : "\<c-y>") :
            \ (neosnippet#expandable() ?
            \   neosnippet#mappings#expand_impl() : "\<cr>")
smap <expr><cr>
            \ neosnippet#expandable() ?
            \   neosnippet#mappings#expand_impl() : "\<cr>"
xmap <expr><cr>
            \ neosnippet#expandable() ?
            \   neosnippet#mappings#expand_impl() : "\<cr>"
imap <expr><TAB>
            \ pumvisible() ? "\<C-n>" :
            \ neosnippet#expandable_or_jumpable() ?
            \   "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB>
            \ neosnippet#expandable_or_jumpable() ?
            \   "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
if !empty(g:plug_home)
    let g:neosnippet#snippets_directory =
                \ g:plug_home.expand('/vim-snippets/snippets')
endif

" Define which files will disable the neosnippet-snippets plugin
autocmd! BufWinEnter *.sh let g:neosnippet#disable_runtime_snippets = {'_': 1,}
" }}}

" 2.4 语法检测
" ----------
" Lint {{{
if !(has('timers') && exists('*job_start') && exists('*ch_close_in')) " Vim8
            \  && !(has('nvim') && has('timers')) " NeoVim >= 0.1.5
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
    let g:syntastic_shell_shellcheck_args = '-x'
    " to see error location list
    let g:syntastic_always_populate_loc_list = 0
    let g:syntastic_auto_loc_list            = 0
    let g:syntastic_loc_list_height          = 5
    function! ToggleErrors()
        let l:old_last_winnr = winnr('$')
        lclose
        if l:old_last_winnr == winnr('$')
            " Nothing was closed, open syntastic error location panel
            Errors
        endif
    endfunction
    " Keyword
    nmap <silent> <SID>(lint-toggle-error) :call ToggleErrors()<CR>
    nmap <silent> <SID>(lint-previous)     :lprevious<CR>
    nmap <silent> <SID>(lint-next)         :lnext<CR>
    " }}}
else
    Plug 'w0rp/ale', { 'on': [ 'ALELint' ] }
    " {{{
    let g:ale_sign_column_always   = 1
    let g:ale_lint_on_enter        = 0
    let g:ale_lint_enter_delay     = 5000
    let g:ale_lint_on_save         = 1
    let g:ale_sign_open_list       = 1
    let g:ale_lint_delay           = 200
    let g:ale_sign_error           = '✗'
    let g:ale_sign_warning         = '•'
    let g:ale_statusline_format    = ['✘ %d', '• %d', '✔']
    let g:ale_echo_msg_error_str   = 'E'
    let g:ale_echo_msg_warning_str = 'W'
    let g:ale_echo_msg_format      = '[%linter%] %s [%severity%]'
    " Some linter option
    let g:ale_linters_sh_shellcheck_exclusions = '-x'
    let g:ale_error_location_hight = 5
    function! ToggleErrors()
        let l:old_last_winnr = winnr('$')
        lclose
        if l:old_last_winnr == winnr('$')
            " Nothing was closed, open ale error location panel
            silent! lopen
            if len(getloclist(0)) == 0
                echohl ErrorMsg | echom 'No warning or error' | echohl NONE
                return
            endif
            exec 'resize '.g:ale_error_location_hight
            wincmd p
            ALENext
        endif
    endfunction
    function! AutoClose()
        " Auto close location list
        if len(getloclist(0)) == 0
            lclose
        endif
        if tabpagenr() == 1 && winnr('$') == 1 && &buftype ==# 'quickfix'
            q
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
        autocmd WinEnter   * call AutoClose()
        autocmd User ALELint call Update_light()
    augroup END

    " 延迟加载 ALE
    function! AleStartDelay(timer) abort
        if empty(glob(g:plug_home.'/ale'))
            return
        endif
        ALELint
    endfunction
    let s:ale_start_timer = timer_start(g:ale_lint_enter_delay, 'AleStartDelay')
    " Keyword
    nmap <silent> <SID>(lint-toggle-error) :call ToggleErrors()<CR>
    nmap <silent> <SID>(lint-previous)     <Plug>(ale_previous_wrap)
    nmap <silent> <SID>(lint-next)         <Plug>(ale_next_wrap)
    " }}}
endif
nmap <leader>le <SID>(lint-toggle-error)
nmap <leader>lp <SID>(lint-previous)
nmap <leader>ln <SID>(lint-next)
" }}}

" 2.5 Unite
" ----------
Plug 'Shougo/denite.nvim', { 'on': 'Denite' }
" {{{
nnoremap <SID>(denite-file) :Denite file<CR>
nmap <leader>df <SID>(denite-file)
nnoremap <SID>(denite-buffer) :Denite buffer<CR>
nmap <leader>db <SID>(denite-buffer)
nnoremap <SID>(denite-register) :Denite register<CR>
nmap <leader>dg <SID>(denite-register)
" }}}

" 2.6 Code Formatting
" ----------
" 快速对齐
Plug 'junegunn/vim-easy-align'
" {{{
vmap <leader>ga <Plug>(EasyAlign)
xmap <leader>ga <Plug>(EasyAlign)
nmap <leader>ga <Plug>(EasyAlign)
" }}}

" 末尾空格
Plug 'bronson/vim-trailing-whitespace'
" {{{
nnoremap <silent> <SID>(fix-white-space) :FixWhitespace<CR>
nmap <leader>d<space> <SID>(fix-white-space)
" }}}

" 自动补全成对符号
Plug 'jiangmiao/auto-pairs'
" {{{
let g:AutoPairsFlyMode = 0
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
    if &filetype ==# 'markdown' || &filetype ==# 'text'
"        if &filetype == 'markdown'
"            setlocal comments=fb:*,fb:-,fb:+,n:>
"            setlocal commentstring=<!--%s-->
"            setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+\\\|^\\[^\\ze[^\\]]\\+\\]:
"        endif
        " 中文字符适应 textwidth 换行
        setlocal formatoptions+=tcqlnMm
        setlocal formatoptions-=ro
        " 设置换行
        setlocal textwidth=78
        " 79行有错误提示
        setlocal colorcolumn=79
        " 添加拼写检查
        setlocal spell
        " 添加快捷键进行排版 + 格式纠错
        nnoremap <silent> <SID>(format-and-fix) :Pangu<cr>gggqG2<c-o>
        nmap <leader>gq <SID>(format-and-fix)
    endif
endfunction
autocmd! BufWinEnter * :call AutoWrapWithText()
" }}}

" 2.7 Operating
" ----------
" 快速移动
Plug 'easymotion/vim-easymotion'
" {{{
" <leader>c{char} to move to {char}
map  <leader>ec <Plug>(easymotion-bd-f)
nmap <leader>ec <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
map  <leader>e2c <Plug>(easymotion-bd-f2)
nmap <leader>e2c <Plug>(easymotion-overwin-f2)
" Move to line
map  <leader>el <Plug>(easymotion-bd-jk)
nmap <leader>el <Plug>(easymotion-overwin-line)
" Move to word
map  <leader>ew <Plug>(easymotion-bd-w)
nmap <leader>ew <Plug>(easymotion-overwin-w)
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

nmap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())
" }}}

" 替换可视化 & tab 自动选择
Plug 'osyo-manga/vim-over', { 'on': 'OverCommandLine' }
" {{{
nnoremap <SID>(over-command-line) :OverCommandLine<CR>
nmap <leader>cl <SID>(over-command-line)
nnoremap <SID>(over-command-line-replace) :OverCommandLine<CR>:%s/
nmap <leader>cr <SID>(over-command-line-replace)
" }}}

" 重复操作
Plug 'tpope/vim-repeat'

" 视图模式下伸缩选中部分
Plug 'terryma/vim-expand-region'
" {{{
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)
" }}}

" 选择窗口
Plug 't9md/vim-choosewin', { 'on': 'ChooseWin' }
" {{{
nnoremap <silent> <SID>(choose-win) :ChooseWin<CR>
nmap <TAB> <SID>(choose-win)
" }}}

" 2.8 Other tools
" ----------
" vimproc
Plug 'Shougo/vimproc.vim', { 'do': 'make' }

" Git Plugin
" -----
Plug 'cohama/agit.vim', { 'on': ['Agit'] }
" {{{
let g:agit_no_default_mappings = 1
let g:agit_ignore_spaces       = 0
nnoremap <silent> <SID>(git-log) :Agit<CR>
nmap <leader>gl <SID>(git-log)
" }}}
Plug 'lambdalisue/gina.vim', { 'on': ['Gina'] }
" {{{
nnoremap <silent> <SID>(git-status) :Gina<space>status<CR>
nmap <leader>gs <SID>(git-status)
nnoremap <silent> <SID>(git-commit) :Gina<space>commit<CR>
nmap <leader>gc <SID>(git-commit)
" }}}

" 关键词搜索
Plug 'dyng/ctrlsf.vim', { 'on': ['<Plug>CtrlSFPrompt', '<Plug>CtrlSFVwordPath', 'CtrlSF'] }
" {{{
"let g:ctrlsf_default_root = 'project'
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_position      = 'bottom'
let g:ctrlsf_winsize       = '40%'
let g:ctrlsf_mapping       = {
    \ 'next': 'n',
    \ 'prev': 'N',
   \ }
" 搜索当前词
nnoremap <SID>(search-word) :CtrlSF<space>
nmap <leader>sw <SID>(search-word)
nnoremap <SID>(search-cursor-word) :CtrlSF<space><c-r>=expand("<cword>")<CR>
nmap <leader>sc <SID>(search-cursor-word)
" }}}

" Man 手册，:Man Keyword 触发 {{{
Plug 'idbrii/vim-man', { 'on': 'Man' }
nnoremap <silent> <SID>(man-word) :Man
nmap <leader>mw <SID>(man-word)
nnoremap <silent> <SID>(man-cursor-word) :Man <c-r>=expand("<cword>")<CR>
nmap <leader>mw <SID>(man-cursor-word)
" }}}

" 3. END
" ==========
call plug#end()
