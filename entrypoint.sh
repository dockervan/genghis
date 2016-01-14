#!/usr/bin/env sh

set -e

if [ -f servers.custom ]; then
    cp servers.custom servers
else
    rm -f servers

    for server in $(env | egrep '^DB(_[0-9a-zA-Z_-]+)?_NAME=' | sed 's/_NAME=.*//'); do
        host=$(printenv "${server}_NAME" | cut -d / -f 3)
        port=$(printenv "${server}_PORT_27017_TCP_PORT")

        if [ -f servers ]; then
            echo -n ";$host:$port" >> servers
        else
            echo -n "$host:$port" > servers
        fi
    done
fi

genghisapp --version

exec "$@"
