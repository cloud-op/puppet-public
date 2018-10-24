#创建admin用户的home文件路径/home/admin/.ssh
class base::dir_admin {

	file { "/home/admin/":
                ensure  =>  "directory",
                owner   =>  "admin",
                group   =>  "admin",
                mode    =>  "0700",
        }


        file { "/home/admin/.ssh":
                ensure  =>  "directory",
                owner   =>  "admin",
                group   =>  "admin",
                mode    =>  "0700",
	}
}
