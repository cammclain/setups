# This Dockerfile is used to build a development instance of Mythic C2 that can launched, and torn down on a whim.
# It is not meant to be used in a production environment.

FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    curl \
    git \
    docker.io \
    make \
    gcc \
    g++ \
    build-essential \
    python3 \
    python3-pip \
    docker-compose




COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]