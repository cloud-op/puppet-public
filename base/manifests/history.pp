#收集history操作历史日志
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
