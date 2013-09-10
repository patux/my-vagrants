class base2 {
  exec {"apt-intel-extra-conf-line":
      command => "echo Acquire::http::proxy { repo-eg01.cps.intel.com DIRECT';'}';' >> /etc/apt/apt.conf.d/40proxy",
      user    => root,
  }
  exec {"update apt":
    command   => "/bin/bash -c 'source /etc/environment;/usr/bin/apt-get -y update;/usr/bin/apt-get -y dist-upgrade'",
    #command  => "apt-get -y update",
    timeout   => 0,
    logoutput => true,
    require   => Exec['apt-intel-extra-conf-line'],
  }

  group { "puppet": ensure => "present"; }  ->

  class { "aptitude": require         => Exec['update apt'], } ->
  package { "openjdk-6-jre": ensure   => "present", } ->
  package { "curl": ensure            => "present", } ->
  package { "git-core": ensure        => "installed", } -> 
  package { "vim": ensure             => "installed", } ->
  package { "wget": ensure            => "installed", } ->
  package { "libssl0.9.8": ensure     => "installed", } ->
  package { "build-essential": ensure => "installed", } ->
  package { "libsqlite3-dev": ensure => "installed", }

}
