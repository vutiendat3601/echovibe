FROM python:3.13-slim-bookworm

WORKDIR /app/
COPY ./ ./

RUN apt update
RUN apt upgrade -y
RUN pip install -r ./requirements.txt

ENV APP_HOST=0.0.0.0
ENV APP_PORT=6200
EXPOSE 6200

ENTRYPOINT [ "/app/entrypoint.sh" ]
