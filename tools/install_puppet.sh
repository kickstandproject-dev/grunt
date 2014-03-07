#!/bin/bash
cat > 00-puppet.pref <<EOF
Package: puppet puppet-common puppetmaster puppetmaster-common puppetmaster-passenger
Pin: version 2.7*
Pin-Priority: 501
EOF

sudo mv 00-puppet.pref /etc/apt/preferences.d/00-puppet.pref

lsbdistcodename=`lsb_release -c -s`
puppet_deb=puppetlabs-release-${lsbdistcodename}.deb
wget http://apt.puppetlabs.com/$puppet_deb -O $puppet_deb
sudo dpkg -i $puppet_deb
rm $puppet_deb

sudo apt-get update
sudo apt-get install --force-yes -y puppet git rubygems
