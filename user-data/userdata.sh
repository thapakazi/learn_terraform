#!/bin/bash

# custom port change to fit our security group configs & reload
sed -i  's/^#\(Port\) \([0-9]*\)/\1 2048/g' /etc/ssh/sshd_config && systemctl restart sshd

# install basic automation tools
apt update 
apt install -y python-pip libssl-dev git
pip install awscli ansible #cli53
# install/configure ntp
HOME=/root
date > /root/.vault_pass

# part 2
export USERDATA_TMPDIR=/tmp/userdata && mkdir -p $USERDATA_TMPDIR
exec 2>&1 > $USERDATA_TMPDIR/pull.log
export BOOTSTRAP_PLAYBOOK_URL=https://gitlab.com/thapakazi/jeos_runner

# pull helpers
export BOOTSTRAP_PLAYBOOK_URL="https://gitlab.com/thapakazi/jeos_runner"
JEOS_HELPERS_REMOTE_URL="https://github.com/thapakazi/jeos_helpers"
JEOS_HELPERS_LOCAL=$USERDATA_TMPDIR/jeos_helpers
rm -rf $JEOS_HELPERS_LOCAL
git clone $JEOS_HELPERS_REMOTE_URL $JEOS_HELPERS_LOCAL
cp -v $JEOS_HELPERS_LOCAL/*_util* /etc/profile.d/
cp -v $JEOS_HELPERS_LOCAL/*_helpers* /etc/profile.d/
for file in /etc/profile.d/*_util*; do source $file; done
for file in /etc/profile.d/*_helpers*; do source $file; done

# EXPORT MUST HAVE VARIABLES 
export ENV=$(jeos_get_value_for_tag env)
export ROLE=$(jeos_get_value_for_tag role)
export PROJECT=$(jeos_get_value_for_tag project)

utils_export_home
bootstrap
# clean up the scripts 
rm /var/lib/cloud/instance/{sem/config_scripts_user,boot-finished}
