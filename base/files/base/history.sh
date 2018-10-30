#添加环境变量 把登录shell的所有命令记录到local3级别日志中

export PROMPT_COMMAND='history -a >(tee -ia ~/.bash_history 2>/dev/null | logger -t "$USER[$$] $SSH_CONNECTION" -p local3.debug 2>/dev/null)'
