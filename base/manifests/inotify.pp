#策略用途：安装inotify-monitor,同步配置文件，并重启服务，收集文件变更日志
#策略说明：
#策略风险：
#策略验证：
#使用说明：仅适用于centos-7机器
#case记录：

class base::inotify {
	if $operatingsystemmajrelease == '7' {
	file {
		"/usr/lib/systemd":
		ensure => "directory",
		owner  => "root",
		group  => "root",
		mode   => "0755";
	
		"/usr/lib/systemd/system":
		ensure => "directory",
		owner  => "root",
		group  => "root",
		mode   => "0755";

		#创建/var/log/inotify文件夹	
		"/var/log/inotify":
		ensure => "directory",
		owner  => "nobody",
		group  => "nobody",
		mode   => "0755";
		
		#增加inotify服务的配置文件		
		"/usr/lib/systemd/system/inotify-monitor.service":
		owner  => "root",
		group  => "root",
		mode   => "0644",
		source => "puppet:///modules/base/inotify-monitor.service",
		notify => "Exec[restart services]";
	
		#添加inotify.conf文件
		"/etc/sysconfig/inotify.conf":
		owner  => "root",
		group  => "root",
		mode   => "0644",
		source => "puppet:///modules/base/inotify.conf",
		notify => "Exec[restart services]";
        
		#添加inotify.include配置文件
		"/etc/sysconfig/inotify.include":
		owner  => "root",
		group  => "root",
		mode   => "0644",
		source => "puppet:///modules/base/inotify.include",
		notify  => "Exec[restart services]";
	}
	#inotify-monitor.service或inotify.conf或inotify.include任一文件有变更，即重启inotify服务
	#挂内存盘，防止inotify产生的日志把磁盘写满
	exec {
		"mount -t tmpfs -o size=150m tmpfs /var/log/inotify":
		user        => "root",
		group       => "root",
		path        => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider    => "shell",
		timeout     => "180",
		unless      => "df -h | grep /var/log/inotify";

		"restart services":
		command     => "systemctl daemon-reload && systemctl restart inotify-monitor ",
		user        => "root",
		group       => "root",
		path        => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider    => "shell",
		timeout     => "180",
		refreshonly => "true";

		"systemctl restart inotify-monitor":
		user        => "root",
		group       => "root",
		path        => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider    => "shell",
		timeout     => "180",
		unless      => "ps aux | grep inotifywait | grep -v grep";
	}
	#添加定时任务，每分钟执行一次文件变更日志大小检查的脚本
	#脚本在file_integrity.pp策略中同步
	cron {
		"excute logsize_check.sh":
		command => "bash /export/servers/file_integrity/logsize_check.sh",
		ensure => "present",
		user   => 'root',
		minute => '*',
		}
	}
}
#快速止损方式：systemctl stop inotify-monitor 删除crontab > /export/Logs/system/inotify.log
