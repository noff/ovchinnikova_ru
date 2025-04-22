# README

## Build docker container

Build:

```shell
docker build . -t rees46/ovchinnikova:latest -t rees46/ovchinnikova:2025.04.22.01 --platform linux/amd64 
```

Push:

```shell 
docker push rees46/ovchinnikova:2025.04.22.01
docker push rees46/ovchinnikova:latest
```

Use:

```shell
docker run -d -p 8001:8080 -e RAILS_LOG_TO_STDOUT='true' -e RAILS_MASTER_KEY='...' -it rees46/ovchinnikova:2025.04.21.01
```

## Development

Build:

```shell
docker build . -t ruby275:latest -t ruby275:2 -f DockerfileLocal
```

Run:

```shell
docker run -it -v .:/app -v ./gems:/usr/local/bundle -p 3001:3000 ruby275:2  /bin/bash 
```

or 

```shell
bin/docker-dev
```