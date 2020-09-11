bootstrap:
	@echo -n "Do you want to install required Python dependencies? [y/n]: "; \
	read answer_dependencies; \
	if [ "$${answer_dependencies}" == "y" ]; then \
		sudo python3 -m pip install -r requirements.txt; \
	else \
		echo "Skipping Python dependencies installation."; \
	fi; \
	cat exokube.yml; \
	echo -n "You are about to deploy Kubernetes cluster with parameters above. Do you want to continue? [y/n] "; \
	read answer_install; \
	if [ "$${answer_install}" == "y" ]; then \
		./kubespray_bootstrap.sh bootstrap; \
	else \
		echo "Kubernetes cluster deployment stopped."; \
	fi

scale:
	@echo -n "Do you want to install required Python dependencies? [y/n]: "; \
	read answer_dependencies; \
	if [ "$${answer_dependencies}" == "y" ]; then \
		sudo python3 -m pip install -r requirements.txt; \
	else \
		echo "Skipping Python dependencies installation."; \
	fi; \
	cat exokube.yml; \
	echo -n "You are about to scale Kubernetes cluster with parameters above. Do you want to continue? [y/n] "; \
	read answer_scale; \
	if [ "$${answer_scale}" == "y" ]; then \
		./kubespray_bootstrap.sh scale; \
	else \
		echo "Kubernetes cluster scaling stopped."; \
	fi

clean:
	@rm -rf kubespray;
