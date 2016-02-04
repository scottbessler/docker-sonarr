#!/bin/sh

handle_signal() {
  PID=$!
  echo "received signal. PID is ${PID}"
  kill -s SIGHUP $PID
}

trap "handle_signal" SIGINT SIGTERM SIGHUP

echo "starting sonarr"
mono /NzbDrone/NzbDrone.exe --no-browser -data=/config & wait
echo "stopping sonarr"
