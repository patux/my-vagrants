# Notes

All vagrants leverage host networking and use generic base builds (Ubuntu-precise64).  See the individual Vagrantfile for the IP details.
Default user: vagrant
Default password: vagrant


## This environment uses submodules:

    git submodule init
    git submodule update

## This enviornmen tries to use a proxy (we use squid proxy cache to accelerate the creation/build of the system)

If you are not using proxy, comment out these files all the values related to proxy

    Vagrantfile
    nodes.pp
