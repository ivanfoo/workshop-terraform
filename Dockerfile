FROM hashicorp/terraform:0.11.10

RUN apk add --no-cache \
	python \
  py-pip \
  ansible

RUN pip install --upgrade pip \
  boto \
  boto3
