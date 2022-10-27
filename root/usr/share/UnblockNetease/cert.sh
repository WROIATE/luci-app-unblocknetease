#!/bin/sh

CERT_PATH="/usr/share/UnblockNetease"
CA_CRT="${CERT_PATH}/ca.crt"
CA_KEY="${CERT_PATH}/ca.key"
SERVER_KEY="${CERT_PATH}/server.key"
SERVER_CRT="${CERT_PATH}/server.crt"
SERVER_CSR="${CERT_PATH}/server.csr"
EXT_FILE="${CERT_PATH}/extfile"

[ -f "$CA_CRT" ] && [ -f "$SERVER_KEY" ] && [ -f "$SERVER_CRT" ] && return
rm -f ${CA_CRT} ${CA_KEY} ${SERVER_KEY} ${SERVER_CRT} ${SERVER_CSR}
openssl genrsa -out "${CA_KEY}" 2048
openssl req -x509 -new -nodes -key "${CA_KEY}" -sha256 -days 365 -out "${CA_CRT}" -subj "/C=CN/CN=UnblockNeteaseMusic Root CA/O=UnblockNeteaseMusic"
openssl genrsa -out "${SERVER_KEY}" 2048
openssl req -new -sha256 -key "${SERVER_KEY}" -out "${SERVER_CSR}" -subj "/C=CN/L=Hangzhou/O=NetEase (Hangzhou) Network Co., Ltd/OU=IT Dept./CN=*.music.163.com"
touch "${EXT_FILE}"
echo "authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage=digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage=serverAuth,OCSPSigning
subjectAltName=DNS:music.163.com,DNS:*.music.163.com" >"${EXT_FILE}"
openssl x509 -req -extfile "${EXT_FILE}" -days 365 -in "${SERVER_CSR}" -CA "${CA_CRT}" -CAkey "${CA_KEY}" -CAcreateserial -out "${SERVER_CRT}"
rm -f "${EXT_FILE}"
