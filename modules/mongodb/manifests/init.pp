class mongodb {
    exec { "get-mongokey":
        command => "/bin/bash -c 'source /etc/environment;/usr/bin/wget -qO - http://docs.mongodb.org/10gen-gpg-key.asc | /usr/bin/apt-key add -'", 
        user    => root, 
        timeout => 0,
    }
    file { '/etc/apt/sources.list.d/mongodb.list':
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => 600,
      source  => 'puppet:///modules/mongodb/mongodb.list',
    }
    exec { "install-mongo":
        command => "/bin/bash -c 'source /etc/environment;/usr/bin/apt-get update;/usr/bin/apt-get install mongodb-10gen -y'", 
        user    => root, 
        timeout => 0,
        require => [Exec['get-mongokey'], File['/etc/apt/sources.list.d/mongodb.list']]
        }  
}
