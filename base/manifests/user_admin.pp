#创建admin用户，UID为1001
#用户组为admin，gid为1001
#创建admin用户的home路径为/home/admin/.ssh
class base::user_admin {
	group { "admin":
                gid     => "1001",
                ensure  => "present",
	}
	user {"admin":
                uid     => "1001",
                gid     => "1001",
                ensure  => "present",
                home    => "/home/admin",
                shell   => "/bin/bash",
                managehome => "true",
        }
        file {"/home/admin/.ssh":
                ensure =>  "directory",
                owner  =>  "admin",
                group  =>  "admin",
                mode   =>  "0700",
		backup =>  main,
        }
}
