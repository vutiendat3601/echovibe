#!/bin/sh

DOMAIN="echovibe.io.vn"
WILDCARD_DOMAIN="*-local.echovibe.io.vn"
CERT_DIR="./tls"
KEY_FILE="private.key"
CERT_FILE="certificate.crt"
DAYS_VALID=3650 # 10 years

mkdir -p $CERT_DIR

# Generate the self-signed SSL certificate
openssl req -x509 -nodes -newkey rsa:2048 -keyout "$CERT_DIR/$KEY_FILE" -out "$CERT_DIR/$CERT_FILE" -days $DAYS_VALID -subj "/C=VN/ST=Ho Chi Minh City/L=City/O=Echovibe/OU=Echovibe/CN=$WILDCARD_DOMAIN"

echo "Self-signed certificate generated for $WILDCARD_DOMAIN"

# Ensure permissions are correct
chmod 600 "$CERT_DIR/$KEY_FILE"
chmod 600 "$CERT_DIR/$CERT_FILE"
echo "Permissions set for the certificate and key."
