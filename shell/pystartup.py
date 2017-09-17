#!/usr/bin/python
#-*- coding: UTF-8 -*-
# >FileName    : pystartup.py
# >Author      : KnightCS
# >Description :
# > version 1.0: 2016-06-23 23:47:26
#   用于初始化python
#       1. python命令行tab自动补全
#       2. 记录python命令行历史

import readline
import rlcompleter
import atexit
import os

# tab completion
readline.parse_and_bind('tab: complete')

# history file
histfile = os.path.join(os.environ['HOME'], '.pythonhistory')
try:
    readline.read_history_file(histfile)
except IOError:
    pass
atexit.register(readline.write_history_file, histfile)

del os, histfile, readline, rlcompleter
