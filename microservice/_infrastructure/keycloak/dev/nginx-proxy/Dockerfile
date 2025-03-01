FROM nginx:stable-alpine3.20-perl AS build-stage

WORKDIR /app/

COPY ./ ./
FROM nginx:stable-alpine3.20-perl

WORKDIR /app/

RUN apk update && apk add openssl
COPY --from=build-stage /app/tls/certificate.crt ./tls/certificate.crt
COPY --from=build-stage /app/tls/private.key ./tls/private.key
COPY --from=build-stage /app/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p ./log

EXPOSE 80
EXPOSE 443
