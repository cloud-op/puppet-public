#说明：传文件/etc/security/limits.conf,不同系统同步相应系统下的文件，并做备份
class base::limits {
	file { "/etc/security/limits.conf":
                ensure => "file",
                mode   => "0644",
                owner  => "root",
                group  => "root",
                source => "puppet:///modules/base/limits.conf",
	}
}
