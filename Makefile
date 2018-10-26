export MYSELF ?= $(USER)
export UID := $(shell id -u)
export GID := $(shell id -g)

export AWS_REGION := us-east-1

backend:
	@docker run --rm -it \
	-e AWS_REGION \
	-e AWS_PROFILE \
	-e MYSELF \
	-v $(PWD)/ansible:/var/ansible \
	-v $(HOME)/.aws/credentials:/home/$(MYSELF)/.aws/credentials \
	--workdir /var/ansible \
	--entrypoint ansible-playbook terraform-workshop \
	--extra-vars='ansible_python_interpreter=/usr/bin/python' backend.yml

image:
	@docker build . \
		--build-arg UID=$(UID) \
		--build-arg GID=$(GID) \
		--build-arg MYSELF=$(MYSELF) \
		-t terraform-workshop

shell:
	@docker run --rm -it \
	-v $(PWD)/terraform:/var/terraform \
	-v $(HOME)/.aws/credentials:/home/$(MYSELF)/.aws/credentials \
	-e AWS_REGION \
	-e AWS_DEFAULT_REGION=$(AWS_REGION) \
	-e AWS_PROFILE=$(AWS_PROFILE) \
	-e MYSELF=$(MYSELF) \
	-e TF_VAR_myself=$(MYSELF) \
	--workdir /var/terraform \
	--entrypoint /bin/sh terraform-workshop

purge:
	@docker run --rm -it \
	-e AWS_REGION \
	-e AWS_PROFILE=$(AWS_PROFILE) \
	-e MYSELF=$(MYSELF) \
	-v $(PWD)/ansible:/var/ansible \
	-v $(HOME)/.aws/credentials:/home/$(MYSELF)/.aws/credentials \
	--workdir /var/ansible \
	--entrypoint ansible-playbook terraform-workshop \
	--extra-vars='ansible_python_interpreter=/usr/bin/python' purge.yml
