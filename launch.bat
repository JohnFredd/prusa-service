@echo off

echo Creando el volumen docker "prusaslicer-novnc-data"...
docker volume create prusaslicer-novnc-data

echo Construyendo la imagen Docker...
docker build -t prusa-service .

echo Ejecutando el contenedor docker "prusa-service" en los puertos 8080 y 8000..
docker run --detach --volume=prusaslicer-novnc-data:/configs/ -p 8080:8080 -p 8000:8000 -e SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt" --name=prusa-service prusa-service

echo Proceso de Docker completado.
pause
