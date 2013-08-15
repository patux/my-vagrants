stage { 'pre': before => Stage['main'], }
stage { 'post': }
Stage['main'] -> Stage['post']

#--------------------------------------------
# Base

node basenode {
  class { 'proxy': 
        http_proxy_host  =>  "proxy-us.intel.com", 
        http_proxy_port  => "911", 
        https_proxy_host =>  "proxy-us.intel.com", 
        https_proxy_port => "911", 
        socks_proxy_host =>  "proxy-skype.intel.com", 
        socks_proxy_port => "1080", 
        no_proxy_domains => ".intel.com",
        stage => pre;
    }
  class { "base2":        stage => pre, require => Class['proxy']; }
}

#--------------------------------------------

node default inherits basenode {

  class { "devstack_heat": devstack_branch => "stable/grizzly"; }

  group { "vagrant": ensure => "present"; } ->
  user  { "vagrant": ensure => "present"; } 

  class { "oc-bootstrap": stage => post; }

}
