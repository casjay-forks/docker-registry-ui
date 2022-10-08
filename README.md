## 👋 Welcome to docker-registry-ui 🚀  

docker-registry-ui README  
  
  
## Run container

```shell
dockermgr update docker-registry-ui
```

### via command line

```shell
docker pull casjaysdevdocker/docker-registry-ui:latest && \
docker run -d \
--restart always \
--name casjaysdevdocker-docker-registry-ui \
--hostname casjaysdev-docker-registry-ui \
-e TZ=${TIMEZONE:-America/New_York} \
-v $HOME/.local/share/srv/docker/docker-registry-ui/files/data:/data:z \
-v $HOME/.local/share/srv/docker/docker-registry-ui/files/config:/config:z \
-p 80:80 \
casjaysdevdocker/docker-registry-ui:latest
```

### via docker-compose

```yaml
version: "2"
services:
  docker-registry-ui:
    image: casjaysdevdocker/docker-registry-ui
    container_name: docker-registry-ui
    environment:
      - TZ=America/New_York
      - HOSTNAME=casjaysdev-docker-registry-ui
    volumes:
      - $HOME/.local/share/srv/docker/docker-registry-ui/files/data:/data:z
      - $HOME/.local/share/srv/docker/docker-registry-ui/files/config:/config:z
    ports:
      - 80:80
    restart: always
```

## Authors  

🤖 casjay: [Github](https://github.com/casjay) [Docker](https://hub.docker.com/r/casjay) 🤖  
⛵ CasjaysDevDocker: [Github](https://github.com/casjaysdevdocker) [Docker](https://hub.docker.com/r/casjaysdevdocker) ⛵  
