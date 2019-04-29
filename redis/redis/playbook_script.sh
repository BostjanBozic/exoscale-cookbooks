#!/usr/bin/env bash

EXODIS_KEYFILE=`cat ../terraform/terraform.tfvars | grep private_key_file | cut -d"\"" -f 2`

if [ ${#EXODIS_KEYFILE} -lt 1 ]; then
    echo "EXODIS_KEYFILE env variable is not set. Exiting.";
    exit 1;
fi

if [ $# -ne 1 ]; then
    echo "$0: Script usage: playbook_script.sh [single_node|replicated|cluster]";
    exit 1;
fi

playbook_mode=$1

if [ "${playbook_mode}" == "single_node" ]; then
    playbook_file="playbooks/single_node.yml"
elif [ "${playbook_mode}" == "replicated" ]; then
    playbook_file="playbooks/replicated.yml"
elif [ "${playbook_mode}" == "cluster" ]; then
    playbook_file="playbooks/cluster.yml"
else
    echo "Unknown Ansible playbook mode: ${playbook_mode}. Please choose one of following: [single_node|replicated|cluster]"
    exit 1;
fi

# Fetch Ansible role
ansible-galaxy install BostjanBozic.redis --force -p playbooks/roles

# Run Ansible playbook
ansible-playbook -i inventory ${playbook_file} --private-key="${EXOLASTIC_KEYFILE}"