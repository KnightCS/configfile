#*****~*****~*****~*****~*****~*****~*****~*****~*****
# >File Name:    .pythonstartup.py
# >Author:       Knight_cs (chenshuo_mailbox@gmail.com)
# >Created Time: 2014年06月02日 星期一 23时29分15秒
# >Program:python启动脚本
# 2014_06_02:增加python shell的tab功能
#*****~*****~*****~*****~*****~*****~*****~*****~*****
import sys
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
