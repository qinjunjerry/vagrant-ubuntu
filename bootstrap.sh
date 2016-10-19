#!/bin/bash


# install puppet collection repo
if [ ! -f /etc/apt/sources.list.d/puppetlabs-pc1.list ]; then
	repodeb=puppetlabs-release-pc1-xenial.deb
	curl https://apt.puppetlabs.com/$repodeb -o $repodeb
	dpkg -i $repodeb
fi

apt-get update
# install puppet 4 (and ruby)
apt-get install -y puppet-agent

# install r10k from Ruby Gems
/opt/puppetlabs/puppet/bin/gem install r10k

# download external puppet modules
cd /vagrant
/opt/puppetlabs/puppet/bin/r10k puppetfile install
