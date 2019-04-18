class base::hosts {
    host 
        { 'test.jdcloud.com':
           ensure => present,
           ip => "10.1.0.1",
           comment => "测试用途",
        }
}
