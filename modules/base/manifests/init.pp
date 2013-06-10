class base {
  exec {"update apt":
    command => "/usr/bin/apt-get -y update;/usr/bin/apt-get -y dist-upgrade",
    refreshonly => true,
    timeout => 0,
    logoutput => true
  }

  group { "puppet": ensure => "present"; }  ->

  class { "aptitude": } ->
  package { "openjdk-6-jre": ensure => "present", } ->
  package { "curl": ensure => "present", } ->
  package { "git-core": ensure => "installed", } -> 
  package { "vim": ensure => "installed", } ->
  package { "wget": ensure => "installed", } ->
  package { "libssl0.9.8": ensure => "installed", } ->
  package { "build-essential": ensure => "installed", } ->
  package { "libsqlite3-dev": ensure => "installed", }

}
