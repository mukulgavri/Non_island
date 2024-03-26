FROM ubuntu

RUN mkdir -p /vault/secrets
COPY secrets.json /vault/secrets/secrets.json
