# README

## Build docker container

Build:

```shell
docker build . -t rees46/ovchinnikova:2025.04.21.01 --platform linux/amd64 
```

Push:

```shell 
docker push rees46/ovchinnikova:2025.04.21.02
```

Use:

```shell
docker run -p 8080:8080 -e RAILS_LOG_TO_STDOUT='true' -e RAILS_MASTER_KEY='...' -it rees46/ovchinnikova:2025.04.21.01
```