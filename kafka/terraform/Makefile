create-infrastructure:
	@cat terraform.tfvars; \
	echo -n "Are variables set accordingly? [y/n]: "; \
	read answer_variables; \
	if [ "$${answer_variables}" == "y" ]; then \
		terraform plan; \
		echo -n "Proceed with deploying infrastructure? [y/n]: "; \
		read answer_plan; \
		if [ "$${answer_plan}" == "y" ]; then \
			terraform apply; \
		else \
			echo "Stopping deployment of infrastructure."; \
		fi \
	else \
		echo "Stopping deployment of infrastructure."; \
	fi \

destroy-infrastructure:
	@echo "WARNING: You are about to destroy your infrastructure!"; \
	echo ; \
	echo -n "Proceed with destruction of infrastructure? [y/n]: "; \
	read answer_destroy; \
	if [ "$${answer_destroy}" == "y" ]; then \
		terraform destroy; \
	else \
		echo "Destruction of infrastructure stopped."; \
	fi \

create-ssh-keypair:
	@echo -n "Specify name of SSH keypair: "; \
	read key_name; \
	echo -n "You are about to create SSH keypair with name $${key_name}. Continue? [y/n]: "; \
	read answer_ssh; \
	if [ "$${answer_ssh}" == "y" ]; then \
		ssh-keygen -f ~/.ssh/$${key_name}; \
	else \
		echo "SSH keypair not created."; \
	fi \
