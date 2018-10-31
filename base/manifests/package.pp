#策略用途：安装基础工具
#策略说明：
#策略风险：
#策略验证：
#使用说明：
#case记录：

class base::package {
	package {
		["bind-utils","fping","cronolog","bash-completion","iftop","vim","sysstat","traceroute","lsof","strace","blktrace","perf","dstat","tcpdump","rsync","procps","psmisc","rsyslog","inotify-tools","readline-devel","snappy","lzo","tree","gcc","epel-release","bc","iotop","nethogs"]:
		ensure  => "installed",
        }
}
