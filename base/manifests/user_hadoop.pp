#创建hadoop用户,uid为1000
#用户组hadoop，gid为1000
#创建hadoop用户的home路径/home/hadoop/.ssh
class base::user_hadoop {
	group { "hadoop":
                gid     => "1000",
                ensure  => "present",
	}
	
	user {"hadoop":
                uid     => "1000",
                gid     => "1000",
                ensure  => "present",
                home    => "/home/hadoop",
                shell   => "/bin/bash",
                managehome => "true",
        }
	
        file {"/home/hadoop/.ssh":
                ensure =>  "directory",
                owner  =>  "hadoop",
                group  =>  "hadoop",
                mode   =>  "0700",
                backup =>  main,
        }
}
