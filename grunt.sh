#!/bin/bash -xe

source gruntrc

PUPPET_ARGS="--detailed-exitcodes"

if [[ "$GRUNT_PUPPET_CONFIG_DEBUG" == "true" ]]; then
    PUPPET_ARGS+=" --debug"
fi
if [[ "$GRUNT_PUPPET_CONFIG_COLOR" != "true" ]]; then
    PUPPET_ARGS+=" --color=false"
fi

if [ ! -f /etc/apt/sources.list.d/puppetlabs.list ]; then
    ./tools/install_puppet.sh
fi

if [ ! -d .modules ]; then
    ./tools/install_modules.sh
fi

set +e
sudo -E puppet apply --verbose --modulepath='modules:.modules' manifests/site.pp --certname=grunt $PUPPET_ARGS
set -e

# An exit code of '4' means there were failures during the transaction, and an
# exit code of '6' means there were both changes and failures.
if [[ $? -gt 2 ]]; then
    exit $?
fi
