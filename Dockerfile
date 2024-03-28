FROM ubuntu

RUN mkdir -p /vault/secrets
COPY secrets.json /vault/secrets/secrets.json
COPY Jenkinssecrets.json /vault/secrets/Jenkinssecrets.json
