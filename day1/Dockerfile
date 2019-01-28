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
    build-base \
    python-dev \
    libc-dev \
    libffi-dev \
    openssl-dev

RUN pip install --upgrade pip \
    boto \
    boto3

RUN pip install --upgrade ansible
    
WORKDIR /home/${MYSELF}
USER ${MYSELF}
