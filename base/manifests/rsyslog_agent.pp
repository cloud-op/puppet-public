#安装rsyslog-agent用于收集日志
#启动rsyslog收集日志
class base::rsyslog_agent {
	#下载rsyslog_agent安装包
	exec {
		#下载安装包
		"wget http://storage-jd-local-jcloud-admin.proxy.jd.com/saas-op/rsyslog-agent.tar.gz":
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
		subscribe => "Exec[wget http://storage-jd-local-jcloud-admin.proxy.jd.com/saas-op/rsyslog-agent.tar.gz]",
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
