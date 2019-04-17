INVENTORY ?= inventory

configure:
	@cat group_vars/all.yml; \
	echo -n "Are variables set accordingly (group_vars/all.yml)? [y/n]: "; \
	read answer; \
	if [ "$${answer}" == "y" ]; then \
		ansible-playbook -i ${INVENTORY} playbooks/deploy.yml --tags="configure" --private-key=`cat ../terraform/terraform.tfvars | grep private_key_file | cut -d"\"" -f 2`; \
	else \
		echo "Stopping deployment of GlusterFS."; \
	fi \

clean:
	rm -f playbooks/*.retry;
