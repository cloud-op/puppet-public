#系统类日志和客户端类日志收集
class base::var_log {
	exec {
		#收集message
		"bash control generate_agent_config messages /var/log/messages":
                user     => "root",
                cwd      => "/export/servers/rsyslog-agent/bin/",
                path     => "/usr/bin:/usr/sbin:/sbin:/bin",
                provider => "shell",
                timeout  => "120",
                unless   => "[ -f /export/servers/rsyslog-agent/etc/rsyslog.d/11-input-messages.conf ]";
		
		#收集secure
		"bash control generate_agent_config secure /var/log/secure":
		user     => "root",
                cwd      => "/export/servers/rsyslog-agent/bin/",
                path     => "/usr/bin:/usr/sbin:/sbin:/bin",
                provider => "shell",
                timeout  => "120",
                unless   => "[ -f /export/servers/rsyslog-agent/etc/rsyslog.d/11-input-secure.conf ]";

		#收集cron
		"bash control generate_agent_config cron /var/log/cron":
		user     => "root",
                cwd      => "/export/servers/rsyslog-agent/bin/",
                path     => "/usr/bin:/usr/sbin:/sbin:/bin",
                provider => "shell",
                timeout  => "120",
                unless   => "[ -f /export/servers/rsyslog-agent/etc/rsyslog.d/11-input-cron.conf ]";

		#收集ifrit
		'bash control generate_agent_config ifrit "/export/servers/ifrit/var/log/\*/\*.log" ':
		user     => "root",
                cwd      => "/export/servers/rsyslog-agent/bin/",
                path     => "/usr/bin:/usr/sbin:/sbin:/bin",
                provider => "shell",
                timeout  => "120",
                unless   => "[ -f /export/servers/rsyslog-agent/etc/rsyslog.d/11-input-ifrit.conf ]";
	}
}	
