class devstack_heat ($devstack_branch = "stable/grizzly") {
  file {"/home/vagrant/install_devstack.sh":
    owner => vagrant,
    group => vagrant,
    mode => '0740',
    replace => false,
    content => template('devstack_heat/install_devstack.sh.erb'),
  } ~>
  exec { "devstack": 
    command => "su - vagrant -c '/home/vagrant/install_devstack.sh 2>&1 | tee -a /tmp/devstack_install.log'",
    provider    => shell,
    cwd         => "/home/vagrant/",
    refreshonly => true,   
    timeout   => 0,
    logoutput => true,
  }
}
