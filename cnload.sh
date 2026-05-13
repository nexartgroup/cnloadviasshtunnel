#!/bin/bash

# ============================================
# Toggle SSH tunnel for JDownloader Click'n'Load
# Local:  localhost:9666
# Remote: 192.168.1.1:9666
# ============================================
VERSION="0.1 Alpha"
NAS_USER="admin"
NAS_HOST="192.168.1.1"
LOCAL_PORT="9666"
REMOTE_PORT="9666"

# Check if tunnel already exists
PID=$(lsof -ti tcp:${LOCAL_PORT} -sTCP:LISTEN)

if [ -n "$PID" ]; then
	PIDCMD=$(ps -p ${PID} -o command=)
	PIDUSER=$(ps -p ${PID} -o user=)
	PIDSTART=$(ps -p ${PID} -o start=)
    echo "Click'n'Load Tunnel already running."
    echo "USER:${PIDUSER} PID:${PID} STARTED:${PIDSTART}\n ${PIDCMD}"
    kill "$PID"
    sleep 1
    echo "Tunnel stopped."
else
	echo -e "\033[94m
╭━━━┳╮╱╱╱╱╭╮╱╱╱╱╱╭╮╱╱╱╱╱╱╱╱╱╱╭╮╭━━━┳━━━┳╮╱╭╮╭━━━━╮╱╱╱╱╱╱╱╱╱╱╭╮
┃╭━╮┃┃╱╱╱╱┃┃╱╭╮╱╭┫┃╱╱╱╱╱╱╱╱╱╱┃┃┃╭━╮┃╭━╮┃┃╱┃┃┃╭╮╭╮┃╱╱╱╱╱╱╱╱╱╱┃┃
┃┃╱╰┫┃╭┳━━┫┃╭┫┣━┫┃┃╱╱╭━━┳━━┳━╯┃┃╰━━┫╰━━┫╰━╯┃╰╯┃┃┣┫╭┳━╮╭━╮╭━━┫┃
┃┃╱╭┫┃┣┫╭━┫╰╯┻┫╭╋┫┃╱╭┫╭╮┃╭╮┃╭╮┃╰━━╮┣━━╮┃╭━╮┃╱╱┃┃┃┃┃┃╭╮┫╭╮┫┃━┫┃
┃╰━╯┃╰┫┃╰━┫╭╮╮┃┃┃┃╰━╯┃╰╯┃╭╮┃╰╯┃┃╰━╯┃╰━╯┃┃╱┃┃╱╱┃┃┃╰╯┃┃┃┃┃┃┃┃━┫╰╮
╰━━━┻━┻┻━━┻╯╰╯╰╯╰┻━━━┻━━┻╯╰┻━━╯╰━━━┻━━━┻╯╱╰╯╱╱╰╯╰━━┻╯╰┻╯╰┻━━┻━╯
                                              Version:${VERSION}\033[0m"
	echo ""
    echo "Starting Click'n'Load Tunnel via SSH Tunnel..."

    ssh -f -N \
        -L ${LOCAL_PORT}:127.0.0.1:${REMOTE_PORT} \
        ${NAS_USER}@${NAS_HOST}

    sleep 1

    # Verify tunnel
    if lsof -i TCP:${LOCAL_PORT} | grep LISTEN >/dev/null; then
        echo "Tunnel started successfully."
        echo "127.0.0.1:${LOCAL_PORT} ► ${NAS_HOST}:${REMOTE_PORT}"
    else
        echo "Failed to start tunnel."
    fi
fi
