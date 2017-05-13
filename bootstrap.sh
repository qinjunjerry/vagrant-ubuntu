#!/bin/bash

# install puppet collection repo
if [ ! -f /etc/apt/sources.list.d/puppetlabs-pc1.list ]; then
	repodeb=puppetlabs-release-pc1-xenial.deb
	curl -s -S https://apt.puppetlabs.com/$repodeb -o $repodeb
	dpkg -i $repodeb
fi

# to avoid errors like: dpkg-preconfigure: unable to re-open stdin: No such file or directory
#export DEBIAN_FRONTEND=noninteractive

apt-get update
# install puppet 4 (and ruby)
apt-get install -y puppet-agent

# install r10k from Ruby Gems
/opt/puppetlabs/puppet/bin/gem install r10k

# download external puppet modules
cd /vagrant
/opt/puppetlabs/puppet/bin/r10k puppetfile install
