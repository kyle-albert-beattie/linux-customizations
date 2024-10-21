#!/bin/bash
# This script will launch searx, a self-hosted web search engine.
export PORT=80
docker run --rm -d -v ${PWD}/searx:/etc/searx -p $PORT:8080 -e BASE_URL=http://localhost:$PORT/ searx/searx
brave-browser http://localhost:$PORT
