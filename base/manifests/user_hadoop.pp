#通过shell脚本创建hadoop用户
class base::user_hadoop {
	file { "/root/create_hadoop.sh":
                ensure  =>  "present",
                owner   =>  "root",
                group   =>  "root",
                mode    =>  "0755",
		source  =>  "puppet:///modules/base/create_hadoop.sh",
        }

	exec { "sh /root/create_hadoop.sh":
		user   => "root",
		cwd    => "/tmp",
		path   => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider => "shell",
		unless => "cat /etc/passwd | grep hadoop",
		timeout => "60",
	}
}
