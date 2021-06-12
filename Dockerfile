FROM alpine:3.11

ENV VERSION=0.0.3
ENV GITHUB_HEAD_REF = ""

COPY entrypoint.sh /entrypoint.sh

RUN apk add --update --no-cache bash curl

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]