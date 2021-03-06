#!/bin/bash

# Begin startup sequence
/init.sh

STATUS=$?  # Captures exit code from script that was run

# TODO this exit code detection is also present in worker.sh, needs to be combined
if [[ $STATUS == $SIGNAL_BUILD_STOP ]]
then
  echo "[run] container exit requested"
  exit # Exit cleanly
fi

if [[ $STATUS != 0 ]]
then
  echo "[run] failed to init"
  exit $STATUS
fi

# Primary command - starting webserver
echo "[nginx] start (foreground)"
exec /usr/sbin/nginx -g "daemon off;"
