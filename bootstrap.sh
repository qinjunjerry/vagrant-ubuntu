#!/bin/bash

# install puppet (and ruby)
apt-get install -y puppet

# install r10k from Ruby Gems
gem install r10k

# download external puppet modules
cd /vagrant
r10k puppetfile install
