#创建dev用户,uid为1002
#用户组为dev，gid为1002
#创建dev用户的home路径/home/dev/.ssh
class base::user_dev {
	group { "dev":
                gid     => "1002",
                ensure  => "present",
	}
	user {"dev":
                uid     => "1002",
                gid     => "1002",
                ensure  => "present",
                home    => "/home/dev",
                shell   => "/bin/bash",
                managehome => "true",
        }
        file {"/home/dev/.ssh":
                ensure =>  "directory",
                owner  =>  "dev",
                group  =>  "dev",
                mode   =>  "0700",
		backup =>  main,
        }
}
