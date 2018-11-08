#策略用途：安装指定版本1.8.0_172版本的jdk
#策略说明：如果/root/jdk-8u172-linux-x64.rpm不存在时,下载rpm包，如果文件/usr/bin/java不存在，则执行checkmd5sum，如果rpm包md5值对的，才触发执行安装
#策略风险：无
#策略验证：java -version查看版本是否符合预期
#使用说明：通过可访问地址下载jdk的rpm包
#case记录：

class base::jdk {
	#creates返回值为1即/root/jdk-8u172-linux-x64.rpm不存在时下载安装包，下载动作执行后触发MD5值校验
	exec {
		"wget http://xxx.xxx.com/saas-op/jdk-8u172-linux-x64.rpm": 
		user     => "root",
		cwd      => "/root/",
		creates  => "/root/jdk-8u172-linux-x64.rpm",
		path     => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider => "shell",
		notify   => "Exec[checkmd5sum]",
		timeout  => "180";
		
		#下载安装包时被触发校验安装包的MD5值
		"checkmd5sum":
		command => "echo '5fe15af21a4a4da4a53e56664d29752a /root/jdk-8u172-linux-x64.rpm' > md5file && md5sum -c md5file",
		user    => "root",
		cwd     => "/root",
		path    => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider => "shell",
		refreshonly => "true",
		timeout => "60";

		#unless返回值为1即不存在/usr/bin/java时，安装jdk
		"rpm -i /root/jdk-8u172-linux-x64.rpm":
		user     => "root",
		cwd      => "/root/",
		path     => "/usr/bin:/usr/sbin:/sbin:/bin",
		provider => "shell",
		unless   => "[ -f /usr/bin/java ]",
		timeout => "300",
	}
}
