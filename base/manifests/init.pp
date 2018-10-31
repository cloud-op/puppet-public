#说明：base模块入口文件
class base {
	include base::user_hadoop
	include base::yum_repo
	include base::package
	include base::limits	
	include base::swapoff
	include base::service
	include base::ntp
	include base::iptables
	include base::sysctl
	include base::rsyslog_agent
	include base::history
	include base::jdk
	include base::file_integrity
	include base::var_log
	include base::inotify
}
