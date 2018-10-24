#用shell脚本创建admin用户
class base::user_admin {
	file { "/root/create_admin.sh":
                ensure  =>  "present",
                owner   =>  "root",
                group   =>  "root",
                mode    =>  "0755",
		source  =>  "puppet:///modules/base/create_admin.sh",
        }

	exec { "sh /root/create_admin.sh":
		user   => "root",
		cwd    => "/tmp",
		path   => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider => "shell",
		unless => "cat /etc/passwd | grep admin",
		timeout => "60",
	}
}
