#策略用途：统一配置yum源
#策略说明：更改yum源后要清理yum缓存，方可使用新的yum源
#策略风险：无；只是替换文件，执行清理yum缓存命令
#策略验证：查看文件是否是替换后的文件，执行yum search vim
#使用说明：timeout设置为180s，默认可以涵盖绝大部分情况，如果依然超时，可以将该时间调大
#case记录: 策略执行失败，原因是timeout设置60s，有的机器清理yum缓存需要时间较长

class base::yum_repo {
	file{
		"/etc/yum.repos.d/epel.repo":
        	owner  => "root",
        	group  => "root",
        	mode   => "0644",
        	source => "puppet:///modules/base/epel.repo",
		notify => "Exec[yum clean all]";
        
	        "/etc/yum.repos.d/centos.repo":
                owner  => "root",
                group  => "root",
                mode   => "0644",
                source => "puppet:///modules/base/centos.repo",
		notify => "Exec[yum clean all]";
	}
	exec {"yum clean all":
		user        => "root",
		group       => "root",
		path        => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider    => "shell",
		timeout     => "180",
		refreshonly => "true";
	}
}
