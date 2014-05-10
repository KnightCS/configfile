""********** ********** ********** **********
" VIM增强设置
" Autor:Knight_cs
" DesCRiption:for Linux/Windows, GUI/Console
" LINUX全局版本请见：/usr/share/vim/vimrc
" Version: 1.00
""********** ********** ********** **********
""""""""""""""""""""""""""""""""""""""""
" 1.一般设置  
""""""""""""""""""""""""""""""""""""""""
" 不要使用vi的键盘模式，而是viｍ自己的
" 去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限  
set nocompatible
" 启动的时候不显示那个援助索马里儿童的提示
set shortmess=atl
" 去掉输入错误的提示声音
set noeb
" 左下角的状态
set showmode
"*****~*****~***** 
" 目录、文件
"*****~*****~*****
" 载入文件类型插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on
" 自动切换当前目录为当前文件所在的目录
set autochdir 
" 设置当文件被改动时自动载入
set autoread
" 覆盖文件时不备份
" 禁止生成临时文件
set nobackup
set noswapfile
" 设置备份时的行为为覆盖
"set backupcopy=yes 
" 自动保存
set autowrite
" 代码补全 
set completeopt=preview,menu 
" 在处理未保存或只读文件的时候，弹出确定
set confirm
"*****~*****~*****
"*****~*****~***** 
" 编码相关
"*****~*****~*****
" 内部使用字符编码方式
set encoding=UTF-8
set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
" 屏幕显示编码
set termencoding=UTF-8
" 设定默认解码
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8
set fenc=UTF-8
set fencs=UTF-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936,big5,euc-kr,latin1S
"*****~*****~*****
" history文件中需要记录的行数
set history=1000
" 共享剪贴板
set clipboard+=unnamed
"保存全局变量
set viminfo +=!
" quickfix模式
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>
""""""""""""""""""""""""""""""""""""""""
" 2.显示相关  
""""""""""""""""""""""""""""""""""""""""
"*****~*****~***** 
" 显示中文帮助
"*****~*****~*****
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif
"*****~*****~*****
" 隐藏工具栏
set guioptions-=T
" 隐藏菜单栏     
set guioptions-=m 
"*****~*****~***** 
" 设置魔术 
"*****~*****~*****
" magic(\m)：除了 $ . * ^ 之外其他元字符都要加反斜杠。
" nomagic(\M)：除了 $ ^ 之外其他元字符都要加反斜杠。
set magic
"*****~*****~*****
" 设置主题
"colorscheme monokai
colorscheme desert
" 背景使用黑色
"set background=dark	 
" 设置字体
"set guifont=Courier_New:h10:cANSI
"set guifont=Monaco:h9:cANSI
set guifont=Monaco\ 12
" 显示行号   
set number
"带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-	
" 字符间插入的像素行数目
set linespace=0
" 显示制表符
"set list                       
" 将制表符显示为'>---',将行尾空格显示为'-'
"set listchars = tab:>-,trail:- 
" 将制表符显示为'.   '"
"set listchars=tab:.\ ,trail:.   
"*****~*****~***** 
" 光标
"*****~*****~*****
" 不要闪烁 
set novisualbell
" 光标移动到buffer的顶部和底部时保持3行距离 
set scrolloff=3	
"*****~*****~*****
"*****~*****~***** 
" 折叠
"*****~*****~*****
" 允许折叠 
set foldenable			
" 手动折叠   
"set foldmethod=manual
"set foldmethod=indent  
" 把{{{和}}}之间的内容折叠
set foldmethod=marker
" 折行前空出4字符显示折行标识
set foldcolumn=4  
set foldlevel=3 
"*****~*****~*****
"*****~*****~***** 
" 高亮显示
"*****~*****~*****
" 语法高亮
syntax enable
syntax on
" 突出显示当前行(下划线)
set cursorline
" 用浅色高亮当前行
autocmd InsertEnter * se cul 
autocmd InsertLeave * se nocul 
" 高亮显示匹配的括号 
set showmatch  
" 匹配括号高亮的时间（单位是十分之一秒） 
set matchtime=5 
" 不要高亮被搜索的句子（phrases） 
set nohlsearch 
" 高亮字符，让其不受100列限制 
highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white 
match OverLength '\%101v.*'
" 高亮显示普通txt文件（需要txt.vim脚本）
"au BufRead,BufNewFile *  setfiletype txt
"*****~*****~*****
"*****~*****~*****
" 命令行、状态栏
"*****~*****~*****
" 启动显示状态行(1),总是显示状态行(2) 
set laststatus=2
" 命令行（在状态行下）的高度，默认为1，这里是2 
set cmdheight=2
" 输入的命令显示出来，看的清楚些
set showcmd 
" 打开状态栏标尺
set ruler
" 状态行颜色 
highlight StatusLine guifg=SlateBlue guibg=Yellow 
highlight StatusLineNC guifg=Gray guibg=White
" 状态行显示的内容 
set statusline=%F%r%m%*%=[%{&ff}]%Y\ [%l,%v-%c][%p%%]%{strftime(\"%m/%y-%H:%M\")} 
"set statusline=%F%m%r%h%w%=[POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")} 
"set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\
" 我的状态行显示的内容（包括文件类型和解码）
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\-\ %H:%M\")}
"set statusline=[%F]%y%r%m%*
"*****~*****~*****
"*****~*****~*****
" 搜索和匹配 
"*****~*****~*****
" 搜索逐字符高亮
set hlsearch
set incsearch
" 在搜索的时候忽略大小写 
set ignorecase 
" 在搜索时，输入的词句的逐字符高亮（类似firefox的搜索） 
set incsearch 
" 输入:set list命令是应该显示些啥？ 
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$ 
"*****~*****~*****
"*****~*****~***** 
" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位） 
"*****~*****~*****
set mouse=a 
set selection=exclusive 
set selectmode=mouse,key
"*****~*****~*****
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
""""""""""""""""""""""""""""""""""""""""
" 3.文本格式和排版 
""""""""""""""""""""""""""""""""""""""""
" 检测文件类型
filetype on
" 自动格式化 
set formatoptions=tcrqn 
" 继承前一行的缩进方式，特别适用于多行注释 
set autoindent 
" 使用C样式的缩进 
set cindent 
" 为C程序提供自动缩进 
set smartindent 
" Tab键的宽度4 
set tabstop=4 
" 统一缩进为4 
set softtabstop=4 
set shiftwidth=4 
" 不要用空格代替制表符 
set noexpandtab 
" 不要换行 
set nowrap 
" 在行和段开始处使用制表符 
set smarttab 
" 行内替换
set gdefault
""""""""""""""""""""""""""""""""""""""""
" 4.CTags的设定 
""""""""""""""""""""""""""""""""""""""""
" 按照名称排序 
let Tlist_Sort_Type = "name" 
" 在右侧显示窗口 
let Tlist_Use_Right_Window = 1 
" 压缩方式 
let Tlist_Compart_Format = 1 
" 如果只有一个buffer，kill窗口也kill掉buffer 
let Tlist_Exist_OnlyWindow = 1 
" 不要关闭其他文件的tags 
let Tlist_File_Fold_Auto_Close = 1 
" 不要显示折叠树 
let Tlist_Enable_Fold_Column = 0 
" 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Show_One_File=1
"设置tags  
set tags=tags;/  
"set autochdir 
"autocmd FileType java set tags+=D:\tools\java\tags  
"autocmd FileType h,cpp,cc,c set tags+=D:\tools\cpp\tags  
""""""""""""""""""""""""""""""""""""""""
" 6.自动标题、自动补全
""""""""""""""""""""""""""""""""""""""""
" 打开文件类型检测, 加了这句才可以用智能补全
filetype plugin indent on 
" 关掉智能补全时的预览窗口
set completeopt=longest,menu
" 新建.c,.h,.sh,.java文件，自动插入文件头 
" .c,.cpp文件有c.vim插件进行插入
"let my_autoadd_filetype='*.[ch]pp,*.cc,*.[ch],*.sh,*.java'
autocmd BufNewFile *.[ch]pp,*.cc,*.[ch],*.sh,*.java exec ":call SetTitle()"
"autocmd BufNewFile ($my_autoadd_filetype) exec ":call SetTitle()"
" 新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal 6GA
"autocmd BufNewFile &my_autoadd_filetype normal 6G
"定义函数SetTitle，自动插入文件头 
func SetTitle() 
	if &filetype == 'sh' 
		call setline(1, "\#!/bin/bash") 
        call append(line("."),   "\######## ######## ######## ######## ######## ######## ########") 
		call append(line(".")+1, "\#	File Name:		".expand("%")) 
		call append(line(".")+2, "\#	Author:			Knight_cs") 
		call append(line(".")+3, "\#	Mail:			chenshuo_mailbox@qq.com") 
		call append(line(".")+4, "\#	Created Time:	".strftime("%c"))
		call append(line(".")+5, "\#	Program: ")
		call append(line(".")+6, "\#	") 
        call append(line(".")+7, "\######## ######## ######## ######## ######## ######## ########") 
        call append(line(".")+8, "") 
	else
		call setline(1,          "/*****~*****~*****~*****~*****~*****~*****~*****~*****") 
		call append(line("."),   " *  > File Name:    ".expand("%")) 
		call append(line(".")+1, " *  > Author:       knight_cs (), chenshuomailbox@gmail.com") 
		call append(line(".")+2, " *  > Created Time: ".strftime("%c")) 
		call append(line(".")+3, " *  > Version:      1.0")
		call append(line(".")+4, " *  > Program: ")
		call append(line(".")+5, " *****~*****~*****~*****~*****~*****~*****~*****~*****/") 
		call append(line(".")+6, "")
	endif
endfun
""""""""""""""""""""""""""""""""""""""""
" 7.键盘命令
""""""""""""""""""""""""""""""""""""""""
"增强模式中那个的命令行自动完成操作
set wildmenu
" 使回格键（backspace）正常处理indent, eol, start等 
set backspace=2 
" 允许backspace和光标键跨越行边界
set whichwrap+=<,>,h,l
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
"nmap <leader>w :w!<cr>
"nmap <leader>f :find<cr>
" 映射全选+复制 ctrl+a
"map <C-A> ggVGY
"map! <C-A> <Esc>ggVGY
"map <F12> gg=G
" 选中状态下 Ctrl+c 复制
"vnoremap <C-c> "+y 
"vnoremap <leader>cc "+y
"去空行 
"nnoremap <F2> :g/^\s*$/d<CR> 
"比较文件  
"nnoremap <C-F2> :vert diffsplit 
"新建标签  
"map <M-F2> :tabnew<CR>  
"列出当前目录文件  
"map <F3> :tabnew .<CR>  
"打开树状文件目录  
"map <C-F3> \be  

""""""""""""""""""""""""""""""""""""""""
" 8.Vundle插件管理
""""""""""""""""""""""""""""""""""""""""
"增强模式中那个的命令行自动完成操作
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"let path = '~/some/path/here'
"call vundle#rc(path)
"
" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

""""""""git repo"""""""""""""""
" The following are examples of different formats supported.
" Keep Plugin commands between here and filetype plugin indent on.
" scripts on GitHub repos
Plugin 'tpope/vim-fugitive'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'tpope/vim-rails.git'
Plugin 'Valloric/YouCompleteMe'
	""""""""""""YCM""""""""""""""""""""
	let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
	let g:ycm_collect_identifiers_from_tags_files = 1
	let g:ycm_seed_identifiers_with_syntax = 1
	let g:ycm_confirm_extra_conf = 0
	let g:ycm_allow_changing_updatetime = 0
	set updatetime=100
	" 跳转到定义处
	nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
	nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
	nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
	" jump
	" you can use ctrl+o jump back to where the previous tags you view
	" and you also can use ctral+i jump to the next tags you want to view.
Plugin 'scrooloose/Syntastic'
	""""""""""syntastic""""""""""""
	let g:syntastic_check_on_open = 1
	let g:syntastic_cpp_include_dirs = ['/usr/include/']
	let g:syntastic_cpp_remove_include_errors = 1
	let g:syntastic_cpp_check_header = 1
	let g:syntastic_cpp_compiler = 'clang++'
	let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
	"set error or warning signs
	let g:syntastic_error_symbol = '✗'
	let g:syntastic_warning_symbol = '⚠'
	""whether to show balloons
	let g:syntastic_enable_balloons = 1

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup',{'rtp': 'vim/'}
" scripts from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
Plugin 'FuzzyFinder'
" 自动补全括号、大括号等。
Plugin 'auto-pairs'
" 快速插入代码片段
Bundle 'SirVer/ultisnips'
	let g:UltiSnipsExpandTrigger = "<tab>"
	let g:UltiSnipsJumpForwardTrigger = "<tab>"
	let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
	"	定义存放代码片段的文件夹 .vim/snippets下，使用自定义和默认的，将会的到全局，有冲突的会提示
	let g:UltiSnipsSnippetDirectories=["snippets", "bundle/ultisnips/UltiSnips"]"]"
	let g:solarized_visibility = "high"
	
""""""""vim scripts""""""""""""""""""
Bundle 'taglist.vim'
	""""""""""""""""""""""""""""""""""""""""
	" 5.Tag list (ctags) 
	""""""""""""""""""""""""""""""""""""""""
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
Bundle "Tagbar"
	" auto open when open a c++ file
	autocmd FileType [ch],[ch]pp,cc nested :TagbarOpen
	" set the window's width
	let g:tagbar_width = 20
	let g:tagbar_ctags_bin='/usr/bin/ctags'
	nmap <leader>tb :TagbarToggle<cr>
"Plugin 'c.vim'
Bundle 'grep.vim'
Bundle 'mru.vim'
Bundle 'comments.vim'
" 在头文件以及源文件间跳转
Plugin 'a.vim'
	" a.vim配置
	map av :AV<cr>
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
