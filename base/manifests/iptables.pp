#策略用途：清空iptables列表
#策略说明：仅清空filter表，不会清空mangle等其他表
#策略风险：有；如果当前所有/部分机器依赖于iptables进行一些规则过滤，那么该策略会导致这些策略失效
#策略验证：执行完毕后，执行iptables -nL命令，可以检查有无残存策略
#使用说明：在集群运维中，轻易不会使用Iptables进行策略防护，这是可以清空的前提；因此一旦有错误策略设置，那么puppet可以将其清空
#case记录：

class base::iptables {
	exec { "iptables -F":
		user     => "root",
		path     => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider => "shell",
		timeout  => "60",
	}
}

