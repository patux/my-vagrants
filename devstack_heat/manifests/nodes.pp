stage { 'pre': before => Stage['main'], }
stage { 'post': }
Stage['main'] -> Stage['post']

#--------------------------------------------
# Base

node basenode {
  class { 'proxy': 
        http_proxy_host  =>  "192.168.1.30", 
        http_proxy_port  => "3128", 
        https_proxy_host =>  "192.168.1.30", 
        https_proxy_port => "3128", 
        socks_proxy_host =>  "", 
        socks_proxy_port => "", 
        no_proxy_domains => ".localnet.com",
        stage => pre;
    }
  class { "base2":        stage => pre, require => Class['proxy']; }
  #  class { "mongodb":       stage => pre, require => Class['proxy']; }
}

#--------------------------------------------

node default inherits basenode {

  class { "devstack_heat": devstack_branch => "master"; }

  group { "vagrant": ensure => "present"; } ->
  user  { "vagrant": ensure => "present"; } 

}
