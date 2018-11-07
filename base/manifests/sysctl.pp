#策略用途：统一管理文件/etc/sysctl.conf
#策略说明：同步文件/etc/sysctl.conf，如果文件被同步了，执行sysctl -p 生效新文件, 从文件/etc/sysctl.conf中加载
#	  修改参数1、默认fs.inotify.max_user_watches参数值太小，导致inotifywait无法启动成功
#	  修改参数2、降低磁盘写缓存的阈值
#	  修改参数3、降低flush到磁盘时的延迟
#策略风险: 参数1、fs.inotify.max_user_watches inotify监控数量变大
#         参数2、3 会造成写硬盘更加频繁，增加io负载
#策略验证: 查看文件/proc/sys/vm/dirty_background_ratio和/proc/sys/vm/dirty_ratio是否是预期值
#使用说明: timeout设置为60s，默认可以涵盖绝大部分情况，如果依然超时，可以将该时间调大
#case记录: case1. fs.inotify.max_user_watches 参数小时，inotifywait无法启动
#          case2. 在大内存的机器上如果磁盘写缓存阈值和flush到磁盘延迟时间用默认值时，会很慢导致死机

class base::sysctl {
	file { "/etc/sysctl.conf":
		ensure => "file",
		mode   => "0644",
		owner  => "root",
		group  => "root",
		source => "puppet:///modules/base/sysctl.conf",
		notify => "Exec[sysctl -p]",
		backup => main,
	}
	exec {"sysctl -p":
		cwd       => "/tmp",
	    	path      => "/usr/bin:/usr/sbin:/sbin:/bin",
	    	provider  => "shell",
	    	timeout   => "60",
	    	refreshonly => "true"
	}
}
