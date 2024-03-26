#!/bin/bash

SECRETS_JSON=""
while [ $# -gt 0 ]; do
    case "$1" in
        -f=*)
            SECRETS_JSON="${1#*=}"
            ;;
        -f)
            shift
            SECRETS_JSON="$1"
            ;;
        *)
            printf "***************************\n"
            printf "* Error: Invalid argument. *\n $1"
            printf "***************************\n"
            exit 1
            ;;
    esac
    shift
done

if [ -z "$SECRETS_JSON" ]; then
    echo "Missing required argument: -f=secrets.json"
    exit 1
fi

if [ ! -f "$SECRETS_JSON" ]; then
    echo "Error: secrets.json file not found"
    exit 1
fi

docker build -f /home/ubuntu/Dockerfile --build-arg SECRETS_JSON="$SECRETS_JSON" /home/ubuntu
