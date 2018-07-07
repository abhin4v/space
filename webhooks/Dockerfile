FROM almir/webhook
RUN apk add --update docker py-pip heirloom-mailx \
    && pip install docker-compose \
    && rm -rf /var/cache/apk/*
COPY hooks.json /etc/webhook/hooks.json
COPY redeploy-site.sh /var/scripts/redeploy-site.sh 
CMD ["-verbose", "-hooks=/etc/webhook/hooks.json"]
