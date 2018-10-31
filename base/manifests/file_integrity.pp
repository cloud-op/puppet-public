#策略用途：创建file_integrity文件夹，存放logrotate相关文件
#策略说明：文件夹中的logsize_check.sh检查history.log和inotify.log日志的大小，根据条件进行切割;logrotate.d中的两个文件对相应的log文件进行切割;改策略只适用于centos-7系统
#策略风险：无，该策略只同步文件，对系统无任何影响
#策略验证：查看/export/servers路径下是否存在file_integrity文件夹及其文件
#使用说明：recurse设置为remote可以同时传输该文件夹及其子文件，source_permissions设置为use为使用源文件的所有权限，如不需要，可修改为false
#case记录：

class base::file_integrity {
	if $operatingsystemmajrelease == '7' {
		file {"/export/servers/file_integrity":
			ensure  => "directory",
			recurse => "remote",
			source_permissions => "use",
			source => "puppet:///modules/base/file_integrity";
		}
	}
}
