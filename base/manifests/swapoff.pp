#关闭所有交换设备
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
