#!/usr/bin/env bash

source .exoshift.rc

if [ -z "${EXOSHIFT_KEYFILE}" ]; then
    echo "EXOSHIFT_KEYFILE env variable is not set. Exiting.";
    exit 1;
fi

if [ $# -ne 1 ]; then
    echo "$0: Script usage: openshift_bootstrap.sh [prepare|deploy]";
    exit 1;
fi

playbook_mode=$1

# Set up playbook file used
if [ "${playbook_mode}" == "prepare" ]; then
    playbook_file="playbooks/prerequisites.yml"
elif [ "${playbook_mode}" == "deploy" ]; then
    playbook_file="playbooks/deploy_cluster.yml";
else
    echo "Unknown Ansible playbook mode: ${playbook_mode}. Please choose one of following: [prepare|deploy]"
    exit 1;
fi

# Clone Kubespray Github repository
if [ ! -d "openshift-ansible" ]; then
    GIT_URL="https://github.com/openshift/openshift-ansible"
    git clone ${GIT_URL};
fi

cd openshift-ansible
git checkout release-3.11
git pull --quiet

# Move Ansible inventory file to correct location
cp ../inventory inventory/inventory

# Run Ansible playbook
ansible-playbook -i inventory/inventory ${playbook_file} -b --private-key="${EXOSHIFT_KEYFILE}"
