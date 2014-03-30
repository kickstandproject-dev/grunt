#!/bin/bash -xe

source gruntrc

PUPPET_ARGS=""

if [[ "$GRUNT_DEBUG" == "True" ]]; then
    PUPPET_ARGS+=" --debug"
fi
if [[ "$GRUNT_PUPPET_CONFIG_COLOR" != "True" ]]; then
    PUPPET_ARGS+=" --color=false"
fi

if [ ! -f /etc/apt/sources.list.d/puppetlabs.list ]; then
    ./tools/install_puppet.sh
fi

if [ ! -d .modules ]; then
    ./tools/install_modules.sh
fi

sudo puppet apply --verbose --modulepath='modules:.modules' manifests/site.pp --certname=grunt $PUPPET_ARGS
