#!/usr/bin/env bash

source .exokube.rc

if [ -z "${EXOKUBE_KEYFILE}" ]; then
    echo "EXOKUBE_KEYFILE env variable is not set. Exiting.";
    exit 1;
fi

if [ $# -ne 1 ]; then
    echo "$0: Script usage: kubespray_bootstrap.sh [bootstrap|scale]";
    exit 1;
fi

playbook_mode=$1

# Set up playbook file used
if [ "${playbook_mode}" == "bootstrap" ]; then
    playbook_file="cluster.yml"
elif [ "${playbook_mode}" == "scale" ]; then
    playbook_file="scale.yml";
else
    echo "Unknown Ansible playbook mode: ${playbook_mode}. Please choose one of following: [bootstrap|scale]"
    exit 1;
fi

# Clone Kubespray Github repository
if [ ! -d "kubespray" ]; then
    GIT_URL="https://github.com/kubernetes-sigs/kubespray"
    git clone ${GIT_URL};
fi

cd kubespray
git checkout release-2.12
git pull --quiet

# Move Ansible inventory file to correct location
cp ../inventory inventory/inventory

# Remove fact cache
rm -rf /tmp/k8s-*

# Run Ansible playbook
ansible-playbook -i inventory/inventory ${playbook_file} -b --become-user=root --private-key="${EXOKUBE_KEYFILE}" --extra-vars="@../exokube.yml"
