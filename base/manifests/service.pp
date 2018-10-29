#说明：开启sshd,ntpd, crond 服务，并且开机自启动；
class base::service {
	service { ["sshd", "ntpd", "crond"]:
            ensure => "running",
            enable => "true",
	    hasrestart => true,
	    hasstatus => true,
        }
}
