#!/bin/bash
# Setting root pwd from the very beggining
echo root:rootroot | chpasswd
#--------------------------------------------------------------------
# BOOTSTRAP Variables
#--------------------------------------------------------------------
export BOOTSTRAP_HOST=gmw-gorozco1.zpn.intel.com
export BOOTSTRAP_URL=http://$BOOTSTRAP_HOST/oc-bootstrap
export BOOTSTRAP_RECIPES_URL=http://$BOOTSTRAP_HOST/oc-bootstrap/recipes/
# export no_proxy=$no_proxy,$BOOTSTRAP_HOST
# Local variables for the bootstrap 
RECIPES="intel-repo puppet-repo puppet-agent" 
DISTRO_AND_VERSION=`wget -qO- $BOOTSTRAP_URL/tools/os_detect.sh | bash | tr ' ' '/'` # Detect Distro and Version
#--------------------------------------------------------------------
# RECIPES Variables
# if you want to overwrite the default variable value they have already
# Add your recipes variables,values here 
#--------------------------------------------------------------------
export OS_REPO=repo-eg01.cps.intel.com
export PUPPET_REPO=http://repo-eg01.cps.intel.com/apt.puppetlabs.com/
export PUPPET_KEY=http://$BOOTSTRAP_HOST/oc-bootstrap/recipes/puppet-agent/common/puppetlabs-pubkey.gpg
#--------------------------------------------------------------------
# NO TUNABLES BELOW THIS POINT
#--------------------------------------------------------------------
if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi
# This is a chicken and the egg problem.. we cannot get curl installed
# because we haven't set the local repos ;-), other option will be to
# cook curl in the images already but the Vagrant boxes does not have it
# by default :-(
#
# Installing curl if we don't have it
# [[ -z `which curl` ]] && apt-get install -y curl >/dev/null
# So the wget instructions can be curl instead

# Loop on the recipes to run
for recipe in $RECIPES
do
    wget -qO- "${BOOTSTRAP_RECIPES_URL}/${recipe}/os/${DISTRO_AND_VERSION}/init.sh" | bash
done
