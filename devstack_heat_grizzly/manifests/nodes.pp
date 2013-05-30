stage { 'pre': before => Stage['main'] }

#--------------------------------------------
# Base

node basenode {
  class { "base": stage => pre; }
}

#--------------------------------------------

node default inherits basenode {

  include devstack_heat_grizzly

  group { "vagrant": ensure => "present"; } ->
  user  { "vagrant": ensure => "present"; } 

}
