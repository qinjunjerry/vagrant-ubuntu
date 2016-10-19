#!/bin/bash

echo -n "Waiting for ongoing apt/dpkg processes to be finished "
while true; do
	ps -ef | egrep "/usr/bin/dpkg|/usr/lib/apt/apt.systemd.daily" | grep -v grep >/dev/null
	if [ $? -ne 0 ]; then
		break
	fi
	echo -n .
	sleep 3
done
echo

# install puppet collection repo
if [ ! -f /etc/apt/sources.list.d/puppetlabs-pc1.list ]; then
	repodeb=puppetlabs-release-pc1-xenial.deb
	curl -s -S https://apt.puppetlabs.com/$repodeb -o $repodeb
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
