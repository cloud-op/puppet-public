#策略用途：统一管理limits.conf文件
#策略说明：传文件/etc/security/limits.conf,不同系统同步相应系统下的文件，并做备份
#策略风险：
#策略验证：
#使用说明：
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
