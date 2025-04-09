FROM node:22.14.0-bookworm AS build-stage
WORKDIR /app/
COPY ./ ./

RUN npm install -g @angular/cli

RUN cd adminweb && ng build

FROM nginx:stable-alpine3.20-perl

WORKDIR /app/

RUN apk update && apk add openssl

COPY --from=build-stage /app/adminweb/dist/ ./
COPY --from=build-stage /app/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p ./log
EXPOSE 80
EXPOSE 443
