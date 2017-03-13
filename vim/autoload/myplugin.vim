" File Name   : myplugin.vim
" Author      : KnightCS
" Description : My vim plugin.
"  version 1.0: **
"   create.
"  version 2.0: **
"   add some config and grouping.
"  version 3.0: 2017-01-27
"   reorganize.

" 0. Plugin List
" ==========
" vim-plug: 插件管理
"
" vim-easymotion:快速跳转
"	<leader><leader>w :work
"	<leader><leader>b :back
"	<leader><leader>. :repeat
" ycm:自动补全
"	GoToDeclaration              : <leader>gc
"	GoToDefinition               : <leader>gf
"	GoToDefinitionElseDeclaration: <leader>gg
"	C函数全局补全: <c-space>
" syntastic:语法检查
"	listerr: <Leader>ss
"	nexterr: <Leader>sn
"	preverr: <Leader>sp
" ultisnips:模板补全
"	input:	<c-l>
"	netx:	<c-j>
"	back:	<c-k>
" vim-trailing-whitespace:去掉结尾空格/tab
"	map <leader>q<space> :FixWhitespace<cr>
" nerdtree:文件目录树
"	map <leader>tn :NERDTreeToggle<CR>
" tagbar:tag列表
"	map <leader>tb :TagbarToggle<cr>
" taglist:tag列表
"	map <leader>tl :TlistToggle<cr>
" mru:预览最近打开文件
"	map <leader>th :MRU<cr>
" nerdcommenter:
"	<leader>cc 		:加注释
"	<leader>cu 		:解开注释
"	<leader>c<space>:加/解开注释，智能判断
" vim-easy-align:对齐
"	map <leader>a
"	<leader>a=        对齐等号表达
"	<leader>a:        对齐冒号表达式(json/map等)
"	<leader>a<space>  首个空格对齐
"	<leader>a2<space> 第二个空格对齐
"	<leader>a-<space> 倒数第一个空格对齐
"	<leader>a-2<space>倒数第二个空格对齐
"	<leader>a*<space> 所有空格依次对齐
"	<leader>a<Enter>*<space>	右对齐
" a.vim:打开头文件
"	map <leader>af :AV<cr>
" vim-expand-region:视图模式下可伸缩选中部分
"	vmap v :添加选中区域
"	vmap V :减少选中区域
" map <leader>q<space> :去掉末尾空格

" auto download the plug.vim file
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -s --connect-timeout 5 -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" 1. Enter Function
" ==========
function! myplugin#begin()
    return 0
endfunction

" 2. Plugin
" ==========
call plug#begin('~/.vim/plugged')
" ----------

" 2.1 UI
" ----------
" statusline and tableline
Plug 'itchyny/lightline.vim'
    let g:lightline = {
                \ 'colorscheme': 'solarized',
                \ 'mode_map': { 'c': 'NORMAL' },
                \ 'active': {
                \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
                \ },
                \ 'component_function': {
                \   'modified': 'LightlineModified',
                \   'readonly': 'LightlineReadonly',
                \   'fugitive': 'LightlineFugitive',
                \   'filename': 'LightlineFilename',
                \   'fileformat': 'LightlineFileformat',
                \   'filetype': 'LightlineFiletype',
                \   'fileencoding': 'LightlineFileencoding',
                \   'mode': 'LightlineMode',
                \ },
                \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
                \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
                \ }

    function! LightlineModified()
        return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! LightlineReadonly()
        return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "\ue0a2" : ''
    endfunction

    function! LightlineFilename()
        return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
                    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                    \  &ft == 'unite' ? unite#get_status_string() :
                    \  &ft == 'vimshell' ? vimshell#get_status_string() :
                    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
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

    function! LightlineMode()
        return winwidth(0) > 60 ? lightline#mode() : ''
    endfunction
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    let NERDTreeHighlightCursorline = 1
    let g:NERDTreeDirArrowExpandable = '△'
    let g:NERDTreeDirArrowCollapsible = '▽'
    let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
    let g:netrw_home = '~/.cache/nerdtree'
    "close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    map <leader>tn :NERDTreeToggle<cr>
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
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
" tagbar
Plug "Tagbar"
    " auto open when open a c++ file
    "autocmd FileType [ch],[ch]pp,cc nested :TagbarOpen
    " set the window's width
    let g:tagbar_width = 20
    let g:tagbar_ctags_bin='/usr/bin/ctags'
    nmap <leader>tb :TagbarToggle<cr>

" 2.2 File Type
" ----------
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'rust-lang/rust.vim'

" 2.3 语法检测
" ----------
Plug 'kevinw/pyflakes-vim'
    let g:pyflakes_use_quickfix = 0
if version < 800 && !has('nvim')
    Plug 'scrooloose/Syntastic'
        let g:syntastic_check_on_open = 1
        let g:syntastic_cpp_include_dirs = ['/usr/include/']
        let g:syntastic_cpp_remove_include_errors = 1
        let g:syntastic_cpp_check_header = 1
        let g:syntastic_cpp_compiler = 'clang++'
        let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
        " whether to show balloons
        let g:syntastic_enable_balloons = 1
        "set error or warning signs
        let g:syntastic_error_symbol = '✗'
        let g:syntastic_warning_symbol = '•'
        let g:syntastic_style_error_symbol = '✗'
        let g:syntastic_style_warning_symbol = '•'
        " whether to show balloons
        let g:syntastic_enable_highlighting = 1
        let g:syntastic_enable_balloons = 1
        " 外部插件，检查效率比较高
        let g:syntastic_aggregate_errors = 1
        let g:syntastic_python_checkers=['pyflakes']
        let g:syntastic_javascript_checkers = ['jsl', 'jshint']
        let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
        let g:syntastic_html_checkers=['tidy', 'jshint']
        let g:syntastic_shell_checkers=['shellcheck']
        let g:syntastic_shell_shellcheck_args = "-x"
        " to see error location list
        let g:syntastic_always_populate_loc_list = 0
        let g:syntastic_auto_loc_list = 0
        let g:syntastic_loc_list_height = 5
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
        nnoremap <Leader>sn :lnext<cr>
        nnoremap <Leader>sp :lprevious<cr>
else
    Plug 'w0rp/ale'
        "let g:ale_sign_column_always = 1
        let g:ale_sign_error = '✗'
        let g:ale_sign_warning = '•'
        let g:ale_statusline_format = ['✗ %d', '• %d', '✓']
        let g:ale_linters = {
                    \   'sh' : ['shellcheck'],
                    \   'vim' : ['vint'],
                    \   'html' : ['tidy'],
                    \   'python' : ['pyflakes'],
                    \   'markdown' : ['mdl'],
                    \   'javascript' : ['eslint'],
                    \}
        " Keyword
        nmap <silent> <Leader>sn <Plug>(ale_previous_wrap)
        nmap <silent> <Leader>sp <Plug>(ale_next_wrap)
endif

" 2.4 Unite
" ----------
Plug 'Shougo/unite.vim'
    map <Leader>u :Unite
Plug 'Shougo/neomru.vim'
Plug 'tsukkee/unite-tag'
Plug 'tsukkee/unite-help'
Plug 'h1mesuke/unite-outline'
Plug 'osyo-manga/unite-filetype'
Plug 'Shougo/unite-build'
Plug 'thinca/vim-unite-history'
Plug 'osyo-manga/unite-quickfix'
Plug 'joker1007/unite-pull-request'

" 2.5
" ----------
Plug 'Shougo/echodoc.vim'

" 2.6
" ----------
if has('win32unix') || has('win64unix')
    Plug 'Shougo/neocomplete.vim'
        let g:acp_enableAtStartup = 0
        " Use neocomplete.
        let g:neocomplete#enable_at_startup = 1
        " Use smartcase.
        let g:neocomplete#enable_smart_case = 1
        " Set minimum syntax keyword length.
        let g:neocomplete#sources#syntax#min_keyword_length = 2
        let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

        " Define dictionary.
        let g:neocomplete#sources#dictionary#dictionaries = {
                    \ 'default' : '',
                    \ 'vimshell' : $HOME.'/.vimshell_hist',
                    \ 'scheme' : $HOME.'/.gosh_completions'
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
        " <CR>: close popup and save indent.
        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
            return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
            " For no inserting <CR> key.
            "return pumvisible() ? "\<C-y>" : "\<CR>"
        endfunction
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        " Close popup by <Space>.
        "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

        " AutoComplPop like behavior.
        let g:neocomplete#enable_auto_select = 0

        " Shell like behavior(not recommended).
        "set completeopt+=longest
        "let g:neocomplete#enable_auto_select = 1
        "let g:neocomplete#disable_auto_complete = 1
        "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        " Enable heavy omni completion.
        if !exists('g:neocomplete#sources#omni#input_patterns')
            let g:neocomplete#sources#omni#input_patterns = {}
        endif
        "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

        " For perlomni.vim setting.
        " https://github.com/c9s/perlomni.vim
        let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    Plug 'Shougo/neosnippet'
        " Plugin key-mappings.
        imap <C-l>     <Plug>(neosnippet_expand_or_jump)
        smap <C-l>     <Plug>(neosnippet_expand_or_jump)
        xmap <C-l>     <Plug>(neosnippet_expand_target)

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
        let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

    " 快速插入代码片段 & 代码片段配置
    Plug 'Shougo/neosnippet-snippets' | Plug 'honza/vim-snippets'
else
    "Plug 'Valloric/YouCompleteMe', { 'on': [] }
    Plug 'Valloric/YouCompleteMe'
        let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
        let g:ycm_collect_identifiers_from_tags_files = 1
        let g:ycm_seed_identifiers_with_syntax = 1
        let g:ycm_confirm_extra_conf = 0
        let g:ycm_allow_changing_updatetime = 0
        let g:ycm_use_ultisnips_completer=1
        set updatetime=100
        " 离开插入模式后自动关闭预览窗口
        autocmd InsertLeave * if pumvisible() == 0|pclose|endif
        " 禁止缓存匹配项,每次都重新生成匹配项
        let g:ycm_cache_omnifunc=0
        " 语法关键字补全
        let g:ycm_seed_identifiers_with_syntax=1
        " 在注释输入中也能补全
        let g:ycm_complete_in_comments = 1
        " 在字符串输入中也能补全
        let g:ycm_complete_in_strings = 1
        " 注释和字符串中的文字也会被收入补全
        let g:ycm_collect_identifiers_from_comments_and_strings = 1
        " 设置不启动ycm的文件类型
        let g:ycm_filetype_blacklist = {
              \ 'tagbar' : 1,
              \ 'qf' : 1,
              \ 'notes' : 1,
              \ 'markdown' : 1,
              \ 'unite' : 1,
              \ 'text' : 1,
              \ 'vimwiki' : 1,
              \ 'pandoc' : 1,
              \ 'infolog' : 1,
              \ 'mail' : 1
              \}
        let g:ycm_filetype_specific_completion_to_disable = {
              \ 'gitcommit': 1
              \}
        " set symbol
        let g:ycm_error_symbol = '•'
        let g:ycm_warning_symbol = '•'
        " c函数全局补全
        let g:ycm_key_invoke_completion = '<C-Space>'
        " In this example, the rust source code zip has been extracted to
        " /usr/local/rust/rustc-1.7.0
        "let g:ycm_rust_src_path = '/usr/local/rust/rustc-1.7.0/src'
        "let g:ycm_python_binary_path = '/usr/bin/python3'
        " jump
        " you can use ctrl+o jump back to where the previous tags you view
        " and you also can use ctral+i jump to the next tags you want to view.
        nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
        nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
        nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

    " 快速插入代码片段 & 代码片段配置
    "Plug 'SirVer/ultisnips', { 'on': [] } | Plug 'honza/vim-snippets'
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
        let g:UltiSnipsUsePythonVersion = 3
        let g:UltiSnipsEditSplit = 'vertical'
        let g:UltiSnipsSnippetDirectories = ["UltiSnips", "ultisnips"]
        let g:UltiSnipsSnippetsDir = "$HOME/.vim/plugged/vim-snippets/UltiSnips/"
        let g:UltiSnipsExpandTrigger       = "<c-l>"
        let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
        let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

    " lazy load ultisnips and YouCompleteMe
    augroup load_us_ycm
        autocmd!
        autocmd InsertEnter * call plug#load('ultisnips', 'YouCompleteMe')
                    \| autocmd! load_us_ycm
    augroup END
endif

" 2.7 Code Formatting
" ----------
" 快速对齐
Plug 'junegunn/vim-easy-align'
    vmap <Leader>a <Plug>(EasyAlign)
    nmap <Leader>a <Plug>(EasyAlign)
" 末尾空格
Plug 'bronson/vim-trailing-whitespace'
    " \+空格去掉末尾的空格
    map <Leader>q<space> :FixWhitespace<cr>
" 自动补全成对符号
Plug 'jiangmiao/auto-pairs'
    "let g:AutoPairsFlyMode = 1
" 快速给词加环绕符号
Plug 'tpope/vim-surround'
" 快速注释
Plug 'scrooloose/nerdcommenter'
    let g:NERDSpaceDelims=1

" 2.8 Operating
" ----------
" 快速移动
Plug 'easymotion/vim-easymotion'
    " <Leader>f{char} to move to {char}
    map  <Leader>f <Plug>(easymotion-bd-f)
    nmap <Leader>f <Plug>(easymotion-overwin-f)
    " s{char}{char} to move to {char}{char}
    nmap <Leader>sw <Plug>(easymotion-overwin-f2)
    " Move to line
    map  <Leader>L <Plug>(easymotion-bd-jk)
    nmap <Leader>L <Plug>(easymotion-overwin-line)
    " Move to word
    map  <Leader>w <Plug>(easymotion-bd-w)
    nmap <Leader>w <Plug>(easymotion-overwin-w)
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
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
" 视图模式下伸缩选中部分
Plug 'terryma/vim-expand-region'
    vmap v <Plug>(expand_region_expand)
    vmap V <Plug>(expand_region_shrink)
" 选择窗口
Plug 't9md/vim-choosewin'
    nmap <Leader>wq <Plug>(choosewin)
Plug 'vim-scripts/matchit.zip'

" 2.9 Tools
" ----------
" 2.9.1 git
Plug 'mhinz/vim-signify'

" 2.10 Search
" ----------
" 文件搜索
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" ----------
call plug#end()
" ----------
