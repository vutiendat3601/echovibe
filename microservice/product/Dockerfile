FROM python:3.13-slim-bookworm

WORKDIR /app/
COPY ./ ./

RUN apt update
RUN apt upgrade -y
RUN pip install -r ./requirements.txt

ENTRYPOINT [ "/app/entrypoint.sh" ]
