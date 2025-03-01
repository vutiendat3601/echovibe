FROM nginx:stable-alpine3.20-perl AS build-stage

WORKDIR /app/

COPY ./ ./
FROM nginx:stable-alpine3.20-perl

WORKDIR /app/

RUN apk update && apk add openssl
COPY --from=build-stage /app/tls/certificate.pem ./tls/certificate.pem
COPY --from=build-stage /app/tls/private.pem ./tls/private.pem
COPY --from=build-stage /app/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p ./log

EXPOSE 80
EXPOSE 443