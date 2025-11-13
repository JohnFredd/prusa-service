FROM mikeah/prusaslicer-novnc:latest

# Instala FastAPI y Uvicorn
RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install fastapi uvicorn

# Copia tu API
COPY api/ /app/
WORKDIR /app

# Copia configuración de supervisord para la API
COPY api/supervisord.conf /etc/supervisor/conf.d/api.conf

EXPOSE 8000

CMD ["/usr/bin/supervisord"]