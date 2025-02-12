#!/bin/bash

# Start apache2
service apache2 start

# Running
touch /var/log/apache2/error.log
tail -f /var/log/apache2/error.log
