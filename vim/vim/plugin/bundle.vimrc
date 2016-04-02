""**********
" VIM Bundle Plugin Setting
" Autor:Knight_cs
" DesCRiption:for Linux, GUI/Console
" LINUX全局版本请见：/usr/share/vim/vimrc
" Version: 2.00

" 快捷键使用记录
" quickfix模式:
"	autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
" ycm:
"	noremap <leader>gc :YcmCompleter GoToDeclaration<CR>
"	nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
"	nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
" ultisnips:
"	let g:UltiSnipsExpandTrigger="<c-j>"
"	let g:UltiSnipsJumpForwardTrigger="<c-l>"
"	let g:UltiSnipsJumpBackwardTrigger="<c-h>"
" vim-trailing-whitespace:
"	map <leader>q<space> :FixWhitespace<cr>
" nerdtree:
"	map <leader>tn :NERDTreeToggle<CR>
" tagbar:
"	nmap <leader>tb :TagbarToggle<cr>
" a.vim:
"	map av :AV<cr>

""**********
" Vundle插件管理
"
"增强模式中那个的命令行自动完成操作
filetype plugin indent on
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"let path = '~/some/path/here'
"call vundle#rc(path)
"
" let Vundle manage Vundle, required

""**********
" 0. 插件管理
Plugin 'gmarik/vundle'

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
	let g:ycm_filetype_blacklist = {
				\ 'tagbar' : 1,
				\ 'qf' : 1,
				\ 'notes' : 1,
				\ 'markdown' : 1,
				\ 'unite' : 1,
				\ 'text' : 1,
				\ 'vimwiki' : 1,
				\ 'gitcommit' : 1,
				\}
	" c函数全局补全
	let g:ycm_key_invoke_completion = '<C-Space>'
	" In this example, the rust source code zip has been extracted to
	" /usr/local/rust/rustc-1.5.0
	let g:ycm_rust_src_path = '/usr/local/rust/rustc-1.7.0/src'
	let g:ycm_python_binary_path = '/usr/bin/python3'
	" jump
	" you can use ctrl+o jump back to where the previous tags you view
	" and you also can use ctral+i jump to the next tags you want to view.
	nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
	nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
	nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>

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
" 装逼的状态栏
Plugin 'bling/vim-airline'
	set t_Co=256
	let g:airline_powerline_fonts=0
	"theme:serene\simple\luna\jellybeans\sol\
"Plugin 'Lokaltog/vim-powerline'
	"set guifont=PowerlineSymbols\ for\ Powerline
	"set nocompatible
	"set t_Co=256
	"let g:Powerline_symbols = 'fancy'
	"let g:Powerline_symbols = 'unicode'
	"let Powerline_symbols='compatible'

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

""vim scripts
""**********
" Unknown
Bundle 'mru.vim'
Bundle 'comments.vim'

""**********
" 对齐文字
Bundle 'Align'

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

" scripts not on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" ...

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.
" Put your stuff after this line
