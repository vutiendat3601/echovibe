FROM python:3.13.3-slim-bookworm
ARG BUILD_NUMBER

WORKDIR /app/
COPY ./ ./

RUN apt update
RUN apt upgrade -y
RUN apt install libpq-dev -y
RUN pip install -r ./requirements.txt

ENV BUILD_NUMBER=${BUILD_NUMBER}
ENV APP_HOST=0.0.0.0
ENV APP_PORT=6130

EXPOSE 6130

ENTRYPOINT ["/app/entrypoint.sh"]
