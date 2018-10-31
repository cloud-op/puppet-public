#策略用途：统一管理ntp.conf文件
#策略说明：当ntp.conf文件有更新时，同步此文件，然后停止ntpd服务，ntpdate修正时间，启动ntpd服务
#策略风险：
#策略验证：
#使用说明：
#case记录：

class base::ntp {
	file { "/etc/ntp.conf":
		ensure  => "present",
		owner   => "root",
		group   => "root",
		mode    => "644",
		source  => "puppet:///modules/base/ntp.conf",
		notify  => "Exec[systemctl stop ntpd]",
		backup  => main,
}
	
	exec {
		"systemctl stop ntpd":
		user      => "root",
		cwd       => "/tmp",
		path      => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider  => "shell",
		timeout   => "60",
		refreshonly => "true";
	
		"ntpdate 0.cn.pool.ntp.org":
		user      => "root",
		cwd       => "/tmp",
		path      => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider  => "shell",
		timeout   => "60",
		subscribe => "Exec[systemctl stop ntpd]",
		refreshonly => "true";

		"systemctl start ntpd":
		user      => "root",
		cwd       => "/tmp",
		path      => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider  => "shell",
		timeout   => "60",
		subscribe => "Exec[ntpdate 0.cn.pool.ntp.org]",
		refreshonly => "true";
	}
}
