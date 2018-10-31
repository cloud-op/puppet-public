#说明：统一配置yum源并清理yum缓存
class base::yum_repo {
	file{
               "/etc/yum.repos.d/epel.repo":
               owner  => "root",
               group  => "root",
               mode   => "0644",
               source => "puppet:///modules/base/epel.repo",
               notify => "Exec[yum clean all]";
        
               "/etc/yum.repos.d/centos.repo":
               owner  => "root",
               group  => "root",
               mode   => "0644",
               source => "puppet:///modules/base/centos.repo",
               notify => "Exec[yum clean all]";
	}
	exec {"yum clean all":
               user        => "root",
               group       => "root",
               path        => "/usr/bin:/usr/sbin:/sbin:/bin",
               provider    => "shell",
               timeout     => "180",
               refreshonly => "true";
	}
}
