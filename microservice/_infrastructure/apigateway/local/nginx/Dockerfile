FROM nginx:stable-alpine3.20-perl AS build-stage

WORKDIR /app/

COPY ./ ./

RUN apk update && apk add openssl
RUN chmod +x ./generate-tls.sh
RUN ./generate-tls.sh

FROM nginx:stable-alpine3.20-perl

WORKDIR /app/

RUN apk update
RUN apk add openssl nginx-module-njs
COPY --from=build-stage /app/njs/ ./njs/
COPY --from=build-stage /app/tls/certificate.crt ./tls/certificate.crt
COPY --from=build-stage /app/tls/private.key ./tls/private.key
COPY --from=build-stage /app/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p ./log

EXPOSE 80
EXPOSE 443
