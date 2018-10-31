#策略用途：指定的服务确保运行状态以及设置为开机自动启动
#策略说明：
#策略风险：
#策略验证：
#使用说明：
#case记录：

class base::service {
	service { ["sshd", "ntpd", "crond"]:
            ensure => "running",
            enable => "true",
	    hasrestart => true,
	    hasstatus => true,
        }
}
