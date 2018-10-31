#策略用途：启停服务
#策略说明：指定的服务确保运行状态以及设置为开机自启动
#策略风险：
#策略验证：
#使用说明：
#case记录：

class base::service {
	service { ["sshd", "ntpd", "crond"]:
		ensure => "running",
		enable => "true",
		hasrestart => true, #是否支持restart参数,不支持就用stop和start实现重启
		hasstatus => true,  #是否支持status参数,不支持的话查找进程列表来判断服务状态
        }
}
