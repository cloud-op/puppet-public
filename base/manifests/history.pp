#策略用途： 收集history操作历史日志
#策略说明： 通过添加环境变量，把日志通过rsyslog写入到本地日志
#策略风险： 如果环境变量出现错误， 可能会导致登录报错， 但不影响正常使用
#策略验证： 查看/etc/profile.d/history.sh是否存在，系统rsyslogd是否重启
#使用说明： 添加配置到/etc/profile.d, 登录的时候加载环境变量
#case记录：

class base::history {
	file {
		"/etc/profile.d/history.sh":
		owner  => "root",
		group  => "root",
		mode   => "0644",
		source => "puppet:///modules/base/base/history.sh",
		backup => 'main';
               
		"/etc/rsyslog.d/history.conf":
		owner  => "root",
		group  => "root",
		mode   => "0644",
		source => "puppet:///modules/base/base/history.conf",
		notify => "Exec[service rsyslog restart]",
		backup => 'main';

		"/etc/logrotate.d/history":
		owner  => "root",
		group  => "root",
		mode   => "0644",
		source => "puppet:///modules/base/base/history",
		backup => 'main';
	}
	exec {
		"service rsyslog restart":
		user     => "root",
		group    => "root",
		path     => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider => "shell",
		timeout  => "60",
		refreshonly => "true",
	}
}
