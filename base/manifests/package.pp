#策略用途：安装基础工具
#策略说明：package类型通过yum方式将各类工具安装位yum源中的最新版本
#策略风险：无
#策略验证：rpm -qa | grep package-name是否存在
#使用说明：installed直接安装工具的最新版本，如果不希望使用最新版，则需要单独指定安装包的版本
#case记录：

class base::package {
	package {
		["bind-utils","fping","cronolog","bash-completion","iftop","vim","sysstat","traceroute","lsof","strace","blktrace","perf","dstat","tcpdump","rsync","procps","psmisc","rsyslog","inotify-tools","readline-devel","snappy","lzo","tree","gcc","epel-release","bc","yum-plugin-fastestmirror","iotop","nagios-plugins-all","golang","nethogs","ansible"]:
		ensure  => "installed",
        }
}
