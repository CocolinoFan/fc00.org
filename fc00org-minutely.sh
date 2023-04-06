#!/bin/bash

echo "begin `date`"

cd /home/fc00web/
source ./.bashrc
source ./venv/bin/activate

ps -ef | grep -v grep | grep -q 'python ./web/web.py' || (
    cd ./fc00.org/
    python ./web/web.py >/dev/null 2>/dev/null &
)

(
    mysql -ufc00 -phunter2 < ./fc00.org/web/database.sql
)

(
    cd ./cjdnswalk/
    #curl http://localhost:3333/walk | node sendEntireGraph.js
    curl localhost:3333/walk | node ./sendEntireGraph2sql.js | mysql -ufc00 -phunter2
)

(
#    cd ./fc00.org
    python ./fc00.org/web/updateGraph.py
)

echo "end `date`"
