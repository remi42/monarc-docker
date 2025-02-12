#!/usr/bin/env bash

MONARC_VERSION=2.12.7
MONARCFO_RELEASE_URL="https://github.com/monarc-project/MonarcAppFO/releases/download/$MONARC_VERSION/MonarcAppFO-$MONARC_VERSION.tar.gz"
curl -sL $MONARCFO_RELEASE_URL -o ./docker/ubuntu/monarc.tar.gz

#docker compose build
