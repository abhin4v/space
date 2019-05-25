FROM golang:alpine3.9 AS build
WORKDIR /go/src/github.com/adnanh/webhook
ENV WEBHOOK_VERSION 2.6.9
RUN apk add --update -t build-deps curl libc-dev gcc libgcc
RUN curl -L --silent -o webhook.tar.gz https://github.com/adnanh/webhook/archive/${WEBHOOK_VERSION}.tar.gz && \
    tar -xzf webhook.tar.gz --strip 1 &&  \
    go get -d && \
    go build -o /usr/local/bin/webhook

FROM docker/compose:1.22.0
COPY --from=build /usr/local/bin/webhook /usr/local/bin/webhook
VOLUME ["/etc/webhook"]
RUN apk add --update heirloom-mailx \
    && rm -rf /var/cache/apk/*
COPY hooks.json /etc/webhook/hooks.json
COPY redeploy-site.sh /var/scripts/redeploy-site.sh 
ENTRYPOINT ["/usr/local/bin/webhook", "-verbose", "-hooks=/etc/webhook/hooks.json"]
