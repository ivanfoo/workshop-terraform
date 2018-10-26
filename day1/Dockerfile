FROM hashicorp/terraform:0.11.10

ARG UID
ARG GID
ARG MYSELF
RUN addgroup -g ${GID} ${MYSELF} \
    && adduser -SD ${MYSELF} --uid ${UID} -G ${MYSELF}

RUN apk add --no-cache \
    python \
    py-pip \
    shadow \
    ansible

RUN pip install --upgrade pip \
    boto \
    boto3

WORKDIR /home/${MYSELF}
USER ${MYSELF}
