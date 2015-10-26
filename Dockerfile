FROM alpine:3.2
RUN apk --update-cache add python py-pip procps nginx && rm -rf /var/cache/apk/*
RUN pip install -U docker-py==1.3.1 jinja2==2.8
COPY nginx-lb-monitor /usr/local/bin/nginx-lb-monitor
COPY nginx-lb-init /usr/local/bin/nginx-lb-init
ENTRYPOINT ["/usr/local/bin/nginx-lb-init"]
