#策略用途： 安装rsyslog-agent用于收集日志
#策略说明： 启动rsyslog收集日志
#策略风险： 已做了系统资源限制， 如果失效，可能会消耗大量cpu
#策略验证： 查看rsyslog-agent进程是否启动，配置文件是否正确
#使用说明： 仅适用于centos-7机器
#case记录：

class base::rsyslog_agent {
	#下载rsyslog_agent安装包
	exec {
		#下载安装包
		"wget http://xxx.xxx.com/saas-op/rsyslog-agent.tar.gz":
		user     => "root",
		cwd      => "/export/servers/",
		creates  => "/export/servers/rsyslog-agent",
		path     => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider => "shell",
		timeout  => "120";
		
		#解压安装包
		"tar -xvf rsyslog-agent.tar.gz":
		user     => "root",
		cwd      => "/export/servers/",
		path     => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider => "shell",
		timeout  => "120",
		subscribe => "Exec[wget http://xxx.xxx.com/saas-op/rsyslog-agent.tar.gz]",
		refreshonly => "true";
		
		#生成history配置文件
		"bash bin/control generate_agent_config history  /var/log/history.log":
		user     => "root",
		cwd      => "/export/servers/rsyslog-agent/",
		path     => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider => "shell",
		timeout  => "120",
		unless   => "[ -f /export/servers/rsyslog-agent/etc/rsyslog.d/11-input-history.conf ]",
		onlyif   => "[ -d /export/servers/rsyslog-agent ]";
		
		#生成inotify配置文件
		"bash bin/control generate_agent_config inotify /var/log/inotify/inotify.log":
		user     => "root",
		cwd      => "/export/servers/rsyslog-agent/",
		path     => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider => "shell",
		timeout  => "120",
		unless   => "[ -f /export/servers/rsyslog-agent/etc/rsyslog.d/11-input-inotify.conf ]",
		onlyif   => "[ -d /export/servers/rsyslog-agent ]";
		
	}
}
