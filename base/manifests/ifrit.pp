#说明：如果文件夹/export/servers/ifrit 不存在，就获取ifrit安装文件；如果ifrit没有启动，就启动ifrit
class base::ifrit {
	# 安装ifrit
	exec {
		"wget -c -q http://storage-jd-local-jcloud-admin.proxy.jd.com/ifrit/ifrit-agent-public-v0.01.375.fceb228.20180402195806.bin -O installer && sh installer /export/servers/ifrit && rm -f installer":
		user     => "root",
		cwd      => "/tmp",
		path     => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider => "shell",
		timeout  => "180",
		unless   => "[ -d /export/servers/ifrit ]",
	}

	# 启动ifrit
	exec {
                "service ifritd restart":
                user     => "root",
                cwd      => "/tmp",
                path     => "/usr/bin:/usr/sbin:/sbin:/bin",
                provider => "shell",
                timeout  => "60",
                unless   => "service ifritd status"
	}
}
