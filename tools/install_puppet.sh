#!/bin/bash

# Copyright 2013 OpenStack Foundation.
# Copyright 2013 Hewlett-Packard Development Company, L.P.
# Copyright 2013 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

# Install pip using get-pip
EZ_SETUP_URL=https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
PIP_GET_PIP_URL=https://raw.github.com/pypa/pip/master/contrib/get-pip.py

curl -O $EZ_SETUP_URL || wget $EZ_SETUP_URL
python ez_setup.py
curl -O $PIP_GET_PIP_URL || wget $PIP_GET_PIP_URL
python get-pip.py

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
