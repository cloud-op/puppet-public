#关闭机器的交换分区
#该命令可以直接操作，操作系统会自行处理
#执行完毕后，执行free 命令，可以看到swap的大小，total为0
class base::swapoff {
	exec {
		"swapoff -a":
		user     => "root",
		cwd      => "/tmp",
		path     => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider => "shell",
		timeout  => "60",
		onlyif   => "grep partition /proc/swaps";
	}
}
