#!/usr/bin/env bash

echo "# Stop everything"
docker compose down --remove-orphans

echo "# Remove all volumes"
docker volume rm "${PWD##*/}_mariadb" || true
