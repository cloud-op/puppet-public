#策略用途：创建hadoop用户
#策略说明：uid为1000，用户组hadoop，gid为1000,创建hadoop用户的home路径/home/hadoop/.ssh
#策略风险：如果系统已存在用户hadoop，且gid和uid不是1000，会更改hadoop gid和uid为1000，用户组和用户为hadoop的旧文件gid和uid还是旧的id
#策略验证：cat /etc/passwd | grep hadoop
#使用说明：
#case记录：case1. 已经存在hadoop用户的系统，执行完策略后，有些文件打不开，因为此文件的用户是旧有的hadoop id

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
