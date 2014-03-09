#!/bin/sh

if [ ! -f /etc/apt/sources.list.d/puppetlabs.list ]; then
    ./tools/install_puppet.sh
fi

if [ ! -d .modules ]; then
    ./tools/install_modules.sh
fi

sudo puppet apply --verbose --modulepath='modules:.modules' manifests/site.pp --certname=grunt
