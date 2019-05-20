#!/bin/bash

# custom port change to fit our security group configs & reload
sed -i  's/^#\(Port\) \([0-9]*\)/\1 7302/g' /etc/ssh/sshd_config && systemctl restart sshd

# install basic automation tools
apt update 
apt install -y python-pip libssl-dev git
pip install awscli ansible #cli53

#get cli53 from upstream
CLI53_BIN='/usr/local/bin/cli53'
CLI53_VERSION=0.8.12
wget -c https://github.com/barnybug/cli53/releases/download/$CLI53_VERSION/cli53-linux-amd64 -O ${CLI53_BIN}
chmod 755 ${CLI53_BIN}

# install/configure ntp
HOME=/root
NTP_BRANCH=master
NTP_TMP_PULL_DIR=/tmp/ansible-roles
NTP_GITHUB_URL=github.com/cloudfactory/ansible-ntp
NTP_PLAYBOOK=ntp.yml
ANSIBLE_DEBUG_FLAG=-vvv
mkdir -p $NTP_TMP_PULL_DIR
date > /root/.vault_pass

# seems they moved away from github :(
# ansible-pull -C $NTP_BRANCH \
# 		     --full -d ${NTP_TMP_PULL_DIR} \
# 		     -U https://${NTP_GITHUB_URL}.git \
# 		     --accept-host-key $NTP_PLAYBOOK \
# 		     ${ANSIBLE_DEBUG_FLAG}

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
