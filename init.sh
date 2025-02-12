#!/usr/bin/env bash

start=`date +%s`

echo "# reset everything first"
source "down.sh"
echo "$((`date +%s`-start))s"

echo "# start docker containers"
docker compose pull
docker compose build
docker compose up -d
echo "$((`date +%s`-start))s"

echo "# wait for healthiness"
blink="*"
while true; do
  count=$(docker ps | grep -c healthy)
  if [ "$count" -eq 1 ]; then
    break
  fi
  echo -ne "\r$count$blink"
  if [ "$blink" == "*" ]; then
    blink="#"
  else
    blink="*"
  fi
  sleep 1
done
echo -e "\r$count   "
echo "$((`date +%s`-start))s"

echo "# bootstrap"
echo "TODO"
echo "$((`date +%s`-start))s"

echo "# done"
echo "==> open https://localhost/"
