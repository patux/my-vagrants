# Note #
The devstack install process takes time (~30-45mins).  The standard output of the install is redirected to /tmp/devstack_install.log. 
at the end of the provision it will also add a bootstrap endpoint to play within the environment.


You can change the branch to use to build the environment (default is stable/grizzly)

Use screen to launch this process.

This environment uses submodules:

    git submodule init
    git submodule update

ie:

screen -S devstack  bash -c 'vagrant up' -t devstack


