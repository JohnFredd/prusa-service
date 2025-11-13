# Descripción general

He creado un contenedor Docker sencillo (un software para ejecutar versiones muy pequeñas de software en una instancia aislada) para instalar PrusaSlicer en tu red local y acceder a él desde el navegador web. Antes tenía que mantener las configuraciones de mis tres impresoras, sus filamentos, etc., en todos mis dispositivos. Esto se estaba volviendo complicado y, a veces, las impresiones se realizaban con perfiles desactualizados.

Terminé buscando en Docker Hub y encontré algunas instancias de Prusaslicer que se servían a través del navegador, pero muchas parecían ser un poco más complejas de lo que buscaba y vi una oportunidad para simplificar esto y poder cortar rápidamente mis impresiones en el navegador.

Este contenedor está construido con Supervisor y proporciona una instancia bloqueada de Prusaslicer a través de noVNC para acceder a ella directamente en su navegador web favorito.

# ¿Cómo lo consigo?

Esto presupone que tienes Docker instalado y que está correctamente configurado y listo para servir contenedores Docker.

1. Crea un nuevo volumen Docker en tu máquina (consulta el ejemplo a continuación).

> docker volume create prusaslicer-novnc-data

2. Inicie el contenedor Docker utilizando el contenedor mikeah/prusaslicer-novnc (vea el ejemplo a continuación).

> docker run --detach --volume=prusaslicer-novnc-data:/configs/ -p 8080:8080 -e SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt" --name=prusaslicer-novnc mikeah/prusaslicer-novnc

El comando anterior se puede interpretar como la vinculación de `/configs/` con `prusaslicer-novnc-data`, que creó previamente. A continuación, enlazará el puerto 8080 del host con el puerto interno 8080 del contenedor. Finalmente, adjuntará el certificado SSL para Prusaslicer y, por último, nombraremos el contenedor y lo referenciaremos en Docker.

Además, desarrollé soporte específico para este contenedor en Unraid (un sistema operativo NAS muy popular). Puedes consultar la guía allí si lo utilizas.

Si has configurado el puerto 8080, ahora puedes acceder a Prusaslicer mediante http://docker_host:8080 . Si también has definido un directorio para las configuraciones, estas se conservarán (incluso entre actualizaciones de la imagen y de Prusaslicer).

# Advertencias y buenas prácticas

Esto utiliza VNC y noVNC para proporcionar acceso a una instancia de Prusaslicer en un contenedor Docker. Por defecto, no hay ningún tipo de autenticación. Esto significa que cualquier dispositivo de tu red local podrá acceder a este contenedor Docker a menos que lo hayas restringido o implementado alguna medida de seguridad a nivel de red.

Una forma segura de acceder de forma remota sería usar ArgoTunnel (Cloudflare Tunnel) y Cloudflare Teams para proporcionar acceso remoto con una capa de autenticación. En teoría, esto también permitiría conectar cada una de tus impresoras en PrusaSlicer a tus instancias de OctoPrint e imprimir sin problemas directamente desde PrusaSlicer a tu impresora.
