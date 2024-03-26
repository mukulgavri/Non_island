FROM ubuntu
ARG SECRETS_JSON

RUN mkdir -p /vault/secrets
COPY $SECRETS_JSON /vault/secrets/secrets.json
