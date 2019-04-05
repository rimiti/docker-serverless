FROM node:lts-alpine

RUN apk update \
    && apk upgrade \
    && apk add \
        bash \
        git \
        ca-certificates \
        curl \
        jq \
        make \
        py-pip \
        tini \
    && pip install awscli \
    && yarn global add \
        serverless \
    && rm -rf /var/cache/apk/*

ENV NODE_PATH /usr/local/lib/node_modules

WORKDIR /service

COPY assume-role /usr/local/bin/

ENTRYPOINT ["/sbin/tini", "--", "yarn -v", "assume-role", "serverless"]
