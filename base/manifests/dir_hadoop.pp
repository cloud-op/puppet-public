#创建hadoop用户home文件路径/home/hadoop/.ssh
class base::dir_hadoop {

	file { "/home/hadoop/":
                ensure  =>  "directory",
                owner   =>  "hadoop",
                group   =>  "hadoop",
                mode    =>  "0700",
        }


        file { "/home/hadoop/.ssh":
                ensure  =>  "directory",
                owner   =>  "hadoop",
                group   =>  "hadoop",
                mode    =>  "0700",
	}
}
