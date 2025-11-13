# How to use

## In unraid

If you're using unraid, open your Docker page and under Template repositories, add https://github.com/helfrichmichael/unraid-templates and save it. You should then be able to Add Container for prusaslicer-novnc. For unraid, the template will default to 6080 for the noVNC web instance.

## Outside of unraid

### Docker

To run this image, you can run the following command: docker run --detach --volume=prusaslicer-novnc-data:/configs/ --volume=prusaslicer-novnc-prints:/prints/ -p 8080:8080 -e SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt" --name=prusaslicer-novnc prusaslicer-novnc

This will bind /configs/ in the container to a local volume on my machine named prusaslicer-novnc-data. Additionally it will bind /prints/ in the container to superslicer-novnc-prints locally on my machine, it will bind port 8080 to 8080, and finally, it will provide an environment variable to keep Prusaslicer happy by providing an SSL_CERT_FILE.

### Docker Compose

To use the pre-built image, simply clone this repository or copy docker-compose.yml and run docker compose up -d.

To build a new image, clone this repository and run docker compose up -f docker-compose.build.yml --build -d

## Using a VNC Viewer

To use a VNC viewer with the container, the default port for X TigerVNC is 5900. You can add this port by adding -p 5900:5900 to your command to start the container to open this port for access.
