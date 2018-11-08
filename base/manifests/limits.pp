#策略用途：统一管理limits.conf文件
#策略说明：传文件/etc/security/limits.conf,不同系统同步相应系统下的文件，并做备份
#策略风险：设置不合理会影响相对用户的使用
#策略验证：ulimit -a检查对应用户设置参数是否生效
#使用说明：需要根据需求设置合理的参数值
#case记录：

class base::limits {
	file { "/etc/security/limits.conf":
		ensure => "file",
		mode   => "0644",
		owner  => "root",
		group  => "root",
		source => "puppet:///modules/base/limits.conf",
	}
}
