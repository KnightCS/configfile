""**********
" VIM Bundle Plugin Setting
" Autor:Knight_cs
" DesCRiption:for Linux, GUI/Console
" LINUX全局版本请见：/usr/share/vim/vimrc
" Version: 2.00

""**********
" 快捷键使用记录
" 注：<leader>为“\”键
"
" ycm:自动补全
"	GoToDeclaration: <leader>gc
"	GoToDefinition : <leader>gf
"	GoToDefinitionElseDeclaration: <leader>gg
"	C函数全局补全: <c-space>
" ultisnips:模板补全
"	input:	<c-j>
"	netx:	<c-l>
"	back:	<c-h>
" vim-trailing-whitespace:去掉结尾空格/tab
"	map <leader>q<space> :FixWhitespace<cr>
" nerdtree:文件目录树
"	map  <leader>tn :NERDTreeToggle<CR>
" tagbar:tag列表
"	nmap <leader>tb :TagbarToggle<cr>
" taglist:tag列表
"	map  <leader>tl :TlistToggle<cr>
" nerdcommenter:
"	<leader>cc :加注释
"	<leader>cu :解开注释
"	<leader>c<space> :加/解开注释，智能判断
" vim-easy-align:对齐
"	map <leader>a
" a.vim:打开头文件
"	map av :AV<cr>
" vim-expand-region:视图模式下可伸缩选中部分
"	vmap v :添加选中区域
"	vmap V :减少选中区域

""**********
" Vundle插件管理
"
"增强模式中那个的命令行自动完成操作
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

""**********
" 0. 插件管理
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

""**********
" The following are examples of different formats supported.
" Keep Plugin commands between here and filetype plugin indent on.
" scripts on GitHub repos
""**********

""**********
" Unknown
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-rails.git'

""**********
" 自动补全
Plugin 'Valloric/YouCompleteMe'
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
				\ 'tagbar':    1,
				\ 'qf':        1,
				\ 'notes':     1,
				\ 'markdown':  1,
				\ 'pandoc':    1,
				\ 'unite':     1,
				\ 'text':      1,
				\ 'vimwiki':   1,
				\ 'gitcommit': 1,
				\}
	" c函数全局补全
	let g:ycm_key_invoke_completion = '<C-Space>'
	" In this example, the rust source code zip has been extracted to
	" /usr/local/rust/rustc-1.7.0
	let g:ycm_rust_src_path = '/usr/local/rust/rustc-1.7.0/src'
	let g:ycm_python_binary_path = '/usr/bin/python3'
	" jump
	" you can use ctrl+o jump back to where the previous tags you view
	" and you also can use ctral+i jump to the next tags you want to view.
	nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
	nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
	nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

"Bundle 'OmniCppComplete'
"Bundle 'winmanager'
"Bundle 'SuperTab'

""**********
" 语法检测
Plugin 'scrooloose/Syntastic'
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
	let g:syntastic_warning_symbol = '⚠'
	" whether to show balloons
	let g:syntastic_enable_highlighting = 1
	let g:syntastic_enable_balloons = 1
	let g:syntastic_python_checkers=['pyflakes']

""**********
" 快速插入代码片段
"Plugin 'vim-scripts/UltiSnips'
Bundle 'SirVer/ultisnips'
	autocmd FileType [ch],[ch]pp,cc nested :UltiSnipsAddFiletypes c
	autocmd FileType python nested :UltiSnipsAddFiletypes python
	" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
	let g:UltiSnipsSnippetDirectories=['UltiSnips']
	let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
	let g:UltiSnipsExpandTrigger="<c-j>"
	let g:UltiSnipsJumpForwardTrigger="<c-l>"
	let g:UltiSnipsJumpBackwardTrigger="<c-h>"
	" If you want :UltiSnipsEdit to split your window.
	let g:UltiSnipsEditSplit="vertical"

""**********
" 代码片段配置
Plugin 'honza/vim-snippets'

""**********
" rust支持
Plugin 'rust-lang/rust.vim'

""**********
" 装逼的状态栏
"Plugin 'bling/vim-airline'
"	set t_Co=256
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
	let g:airline_powerline_fonts=1
	" 是否打开tabline
	let g:airline#extensions#tabline#enabled = 1
	"let g:airline#extensions#tabline#left_sep = ' '
	"let g:airline#extensions#tabline#left_alt_sep = '|'
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
	let g:airline_left_sep = ''
	let g:airline_left_alt_sep = ''
	let g:airline_right_sep = ''
	let g:airline_right_alt_sep = ''
	let g:airline_symbols.branch = ''
	let g:airline_symbols.readonly = ''
	let g:airline_symbols.linenr = ''

""**********
" 文件目录树
Plugin 'scrooloose/nerdtree'
	map <leader>tn :NERDTreeToggle<CR>
	let NERDTreeHighlightCursorline=1
	let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
	let g:netrw_home='~/bak'
	"close vim if the only window left open is a NERDTree
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

""**********
" for show no user whitespaces
Bundle 'bronson/vim-trailing-whitespace'
	" \+空格去掉末尾的空格
	map <leader>q<space> :FixWhitespace<cr>

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.

Plugin 'rstacruz/sparkup',{'rtp': 'vim/'}
" scripts from http://vim-scripts.org/vim/scripts.html

""**********
" 文件查找
Plugin 'L9'
Plugin 'FuzzyFinder'

""**********
" 自动补全括号、大括号等
Plugin 'jiangmiao/auto-pairs'
	"let g:AutoPairsFlyMode = 1

""**********
" 快速注释
Plugin 'scrooloose/nerdcommenter'
	let g:NERDSpaceDelims=1

""vim scripts
""**********
" Unknown
Bundle 'mru.vim'
Bundle 'comments.vim'

""**********
" 视图模式下可伸缩选中部分
Bundle 'terryma/vim-expand-region'
	vmap v <Plug>(expand_region_expand)
	vmap V <Plug>(expand_region_shrink)


""**********
" 对齐文字
Bundle 'junegunn/vim-easy-align'
	vmap <Leader>a <Plug>(EasyAlign)
	nmap <Leader>a <Plug>(EasyAlign)
	if !exists('g:easy_align_delimiters')
		let g:easy_align_delimiters = {}
	endif
	let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }

""**********
" taglist
Bundle 'taglist.vim'
	" 默认不打开Taglist
	let Tlist_Auto_Open=0
	let Tlist_Ctags_Cmd = '/usr/bin/ctags'
	" 不同时显示多个文件的tag，只显示当前文件的
	let Tlist_Show_One_File = 1
	" 如果taglist窗口是最后一个窗口，则退出vim
	let Tlist_Exit_OnlyWindow = 1
	" 在左侧窗口中显示taglist窗口
	let Tlist_Use_Right_Window = 0
	" 函数列表开关
	map <silent> <leader>tl :TlistToggle<cr>

""**********
" tagbar
Bundle "Tagbar"
	" auto open when open a c++ file
	"autocmd FileType [ch],[ch]pp,cc nested :TagbarOpen
	" set the window's width
	let g:tagbar_width = 20
	let g:tagbar_ctags_bin='/usr/bin/ctags'
	nmap <leader>tb :TagbarToggle<cr>

""**********
" 文件搜索
Bundle 'grep.vim'

""**********
" 在头文件以及源文件间跳转
Plugin 'a.vim'
	" a.vim配置
	map av :AV<cr>

""**********
" 文件头&函数注释
Plugin 'DoxygenToolkit.vim'
"doxauthor,dox,doxblock
	let g:DoxygenToolkit_briefTag_pre="@Synopsis:  "
	let g:DoxygenToolkit_paramTag_pre="@Param: "
	let g:DoxygenToolkit_returnTag="@Returns:   "
	let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
	let g:DoxygenToolkit_blockFooter="--------------------------------------------------------------------------"
	let g:DoxygenToolkit_authorName="KnightCS,chenshuomailbox@gmail.com"
	let s:licenseTag="Copyright(C)\<enter>"
	let s:licenseTag=s:licenseTag."For free\<enter>"
	let s:licenseTag=s:licenseTag."All right recerved\<enter>"
	let g:DoxygenToolkit_licenseTag=s:licenseTag
	let g:DoxygenToolkit_briefTag_funcName="yes"
	let g:Doxygen_enhanced_color=1

""**********
" python实时语法检查
Plugin 'pyflakes.vim'

" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
