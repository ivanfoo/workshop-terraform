export MYSELF ?= $(USER)
export UID := $(shell id -u)
export GID := $(shell id -g)

export AWS_REGION := us-east-1

backend:
	@docker run --rm -it --entrypoint ansible-playbook terraform-workshop

image:
	@docker build . \
	--build-arg UID=$(UID) \
    --build-arg GID=$(GID) \
	--build-arg MYSELF=$(MYSELF) \
	-t terraform-workshop

shell:
	@docker run --rm -it --entrypoint /bin/sh terraform-workshop
