#安装基础工具
class base::package {
	package {
                ["bind-utils","fping","cronolog","bash-completion","iftop","vim","sysstat","traceroute","lsof","strace","blktrace","perf","dstat","tcpdump","rsync","procps","psmisc","rsyslog","inotify-tools","readline-devel","snappy","lzo","tree","gcc","epel-release","bc","iotop","nethogs"]:
                ensure  => "installed",
        }
}
