#清空iptables列表
class base::iptables {
        exec { "iptables -F":
                user     => "root",
                path     => "/usr/bin:/usr/sbin:/sbin:/bin",
                provider => "shell",
                timeout  => "60",
        }
}

