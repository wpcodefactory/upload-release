FROM alpine

COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache ca-certificates

ADD *.sh /

ENTRYPOINT ["/entrypoint.sh"]