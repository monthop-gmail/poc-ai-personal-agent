#!/bin/bash

# คัดลอก OAuth credentials จาก host มาใช้ใน container
if [ -f /tmp/host-claude-credentials/.credentials.json ]; then
    mkdir -p /home/node/.claude
    cp /tmp/host-claude-credentials/.credentials.json /home/node/.claude/.credentials.json
    echo "OAuth credentials copied successfully"
else
    echo "WARNING: No credentials found at /tmp/host-claude-credentials/.credentials.json"
    echo "Please run 'claude login' on the host first"
fi

exec "$@"
