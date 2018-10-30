#创建file_integrity文件夹，存放logrotate相关文件
#文件夹中的logsize_check.sh检查history.log和inotify.log日志的大小，根据条件进行切割
#logrotate.d中的两个文件对相应的log文件进行切割
#只适用于centos-7系统
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
