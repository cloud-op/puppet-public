#策略用途：关闭机器的交换分区
#策略说明：业界当前服务器内存基本都是64G起步，因此swap分区的存在，更多的是增添服务隐患，降低性能，在BAT这样的公司中，SWAP分区默认是关闭状态
#策略风险：该命令可以直接操作，操作系统会自行处理，因此不用担心目前swap分区存储数据的问题
#策略验证：执行完毕后，执行free 命令，可以看到swap的大小，total为0
#case记录：

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
