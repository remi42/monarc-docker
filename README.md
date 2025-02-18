# monarc-docker
docker-compose.yml environment to start monarc with docker

## init

```shell
bash init.sh
```

## build

Build container image without using cache

```shell
docker compose build --no-cache
```

## bash

```shell
docker compose exec monarc bash
```

## migrate

```shell
docker compose exec monarc bash -c "cd /var/lib/monarc && php ./vendor/robmorgan/phinx/bin/phinx migrate -c module/Monarc/FrontOffice/migrations/phinx.php"
docker compose exec monarc bash -c "cd /var/lib/monarc && php ./vendor/robmorgan/phinx/bin/phinx migrate -c module/Monarc/Core/migrations/phinx.php"
```

