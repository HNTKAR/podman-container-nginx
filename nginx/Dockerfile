FROM nginx:mainline-alpine

ARG P12_PASS="password"
ENV CERT_DIR="/usr/local/share/cert"

RUN apk upgrade
RUN apk add bash openssl vim

COPY ["nginx/config/mime-append.types", "/etc/nginx/mime-append.types"]
COPY ["nginx/sites", "/usr/local/share/sites/"]

COPY ["nginx/config/*.conf", "/usr/local/lib/conf/"]
RUN mv /usr/local/lib/conf/nginx-user.conf /etc/nginx/nginx-user.conf

COPY ["nginx/*.sh","nginx/certmgr", "/usr/local/bin/"]
RUN chmod +x /usr/local/bin/*

# 各種証明書の作成
WORKDIR ${CERT_DIR}
COPY ["nginx/config/openssl-append.ini", "/usr/local/lib/openssl.cnf"]
RUN mkdir -p /usr/lib/ssl ${CERT_DIR}
RUN cat /usr/local/lib/openssl.cnf >> /etc/ssl/openssl.cnf
# CA証明書
RUN openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout ${CERT_DIR}/ca.key -noenc -out ${CERT_DIR}/ca.crt -subj="/CN=CA"
# サーバー証明書
RUN certmgr create -p ${P12_PASS} -c ${CERT_DIR} -o ${CERT_DIR} -s "/C=JP/ST=City/O=Org/CN=server" -d 365 -n "server"
# クライアント証明書
RUN certmgr create -p ${P12_PASS} -c ${CERT_DIR} -o ${CERT_DIR} -s "/C=JP/ST=City/O=Org/CN=client" -d 365 -n "client"
# CRL
RUN openssl ca -gencrl -keyfile ${CERT_DIR}/ca.key -cert ${CERT_DIR}/ca.crt -out ${CERT_DIR}/crl.pem

WORKDIR /
ENTRYPOINT ["/usr/local/bin/run.sh"]
