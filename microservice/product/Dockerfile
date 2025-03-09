FROM python:3.13-bookworm

WORKDIR /app/
COPY ./ ./
RUN apt-get update
RUN apt-get upgrade -y

RUN pip install --no-cache-dir -r requirements.txt

ENTRYPOINT [ "./start.sh" ]
