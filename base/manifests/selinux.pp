#策略用途：关闭selinux服务
#策略说明：通过修改selinux_config文件关闭selinux服务，并将此文件同步至各agent
#策略风险：无
#策略验证：登录机器使用getenforce命令查看，显示disable则说明selinux服务已关闭
#使用说明：原selinux_config文件备份，以便快速回滚
#case记录：

class base::selinux {
        file { "/etc/selinux/config":
                ensure => "file",
                mode   => "0644",
                owner  => "root",
                group  => "root",
                source => "puppet:///modules/base/selinux_config",
		backup => main,
	}
}
