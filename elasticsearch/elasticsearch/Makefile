deploy-all:
	@cat group_vars/all.yml; \
	echo -n "Are variables set accordingly (group_vars/all.yml)? [y/n]: "; \
	read answer; \
	if [ "$${answer}" == "y" ]; then \
		./playbook_script.sh deploy; \
	else \
		echo "Stopping deployment of Elasticsearch."; \
	fi \

deploy-master:
	@cat group_vars/all.yml; \
	echo -n "Are variables set accordingly (group_vars/all.yml)? [y/n] "; \
	read answer; \
	if [ "$${answer}" == "y" ]; then \
		./playbook_script.sh deploy master; \
	else \
		echo "Stopping deployment of Elasticsearch master nodes."; \
	fi \

deploy-data:
	@cat group_vars/all.yml; \
	echo -n "Are variables set accordingly (group_vars/all.yml)? [y/n] "; \
	read answer; \
	if [ "$${answer}" == "y" ]; then \
		./playbook_script.sh deploy data; \
	else \
		echo "Stopping deployment of Elasticsearch data nodes."; \
	fi \

deploy-ingest:
	@cat group_vars/all.yml; \
	echo -n "Are variables set accordingly (group_vars/all.yml)? [y/n] "; \
	read answer; \
	if [ "$${answer}" == "y" ]; then \
		./playbook_script.sh deploy ingest; \
	else \
		echo "Stopping deployment of Elasticsearch ingest nodes."; \
	fi \

restart-service:
	@./playbook_script.sh service restart;

stop-service:
	@./playbook_script.sh service stop;
