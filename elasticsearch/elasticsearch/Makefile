deploy-es:
	@cat group_vars/all.yml | grep -v kibana_; \
	echo -n "Are variables set accordingly (group_vars/all.yml)? [y/n]: "; \
	read answer; \
	if [ "$${answer}" == "y" ]; then \
		./playbook_script.sh deploy; \
	else \
		echo "Stopping deployment of Elasticsearch."; \
	fi \

deploy-master:
	@cat group_vars/all.yml | grep -v kibana_; \
	echo -n "Are variables set accordingly (group_vars/all.yml)? [y/n] "; \
	read answer; \
	if [ "$${answer}" == "y" ]; then \
		./playbook_script.sh deploy master; \
	else \
		echo "Stopping deployment of Elasticsearch master nodes."; \
	fi \

deploy-data:
	@cat group_vars/all.yml | grep -v kibana_; \
	echo -n "Are variables set accordingly (group_vars/all.yml)? [y/n] "; \
	read answer; \
	if [ "$${answer}" == "y" ]; then \
		./playbook_script.sh deploy data; \
	else \
		echo "Stopping deployment of Elasticsearch data nodes."; \
	fi \

deploy-ingest:
	@cat group_vars/all.yml | grep -v kibana_; \
	echo -n "Are variables set accordingly (group_vars/all.yml)? [y/n] "; \
	read answer; \
	if [ "$${answer}" == "y" ]; then \
		./playbook_script.sh deploy ingest; \
	else \
		echo "Stopping deployment of Elasticsearch ingest nodes."; \
	fi \

restart-es-service:
	@./playbook_script.sh service es-restart;

start-es-service:
	@./playbook_script.sh service es-start;

stop-es-service:
	@./playbook_script.sh service es-stop;

deploy-kibana:
	@cat group_vars/all.yml | grep -v es_; \
	echo -n "Are variables set accordingly (group_vars/all.yml)? [y/n] "; \
	read answer; \
	if [ "$${answer}" == "y" ]; then \
		./playbook_script.sh kibana; \
	else \
		echo "Stopping deployment of Kibana."; \
	fi \

restart-kibana-service:
	@./playbook_script.sh service kibana-restart;

start-kibana-service:
	@./playbook_script.sh service kibana-start;

stop-kibana-service:
	@./playbook_script.sh service kibana-stop;
