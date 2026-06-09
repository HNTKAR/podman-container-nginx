FROM nginx:mainline-alpine

COPY ["sites", "/usr/local/share/sites/"]

COPY ["config/*.conf", "/usr/local/lib/conf/"]
RUN mv /usr/local/lib/conf/nginx-user.conf /etc/nginx/nginx-user.conf

COPY ["run.sh", "certmgr", "/usr/local/bin/"]
RUN addgroup -g 1101 nginx-user && \
    adduser -D -G nginx-user -u 1101 nginx-user

RUN chmod +x /usr/local/bin/*

ENTRYPOINT ["/usr/local/bin/run.sh"]
