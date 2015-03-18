#!/bin/bash
set -e

if [[ -d /home/genius/test/yocto-autobuilder ]]; then
      echo "starting yocto-autobuilder..."
      (su genius -c "cd /home/genius/test/yocto-autobuilder ; ./yocto-stop-autobuilder both; . ./yocto-autobuilder-setup; ./yocto-start-autobuilder both")
fi

if [[ $(stat -c %U /home/genius) == "root" ]]; then
    echo "fixing pemissions"
    sudo chown genius:genius /home/genius
fi

if [[ $(stat -c %U /home/genius/test) == "root" ]]; then
    echo "fixing pemissions"
    sudo chown genius:genius /home/genius/test
fi

# Delete X locks
(su genius -c "rm -f /tmp/.X*-lock")
(su genius -c "rm -f /tmp/.X11-unix/*")

if [ $(ps aux | grep -e 'Xtightvnc' | grep -v grep | wc -l | tr -s "\n") -eq 0 ]; then
    echo "Xtightvnc Stopped -  starting it"
    (su genius -c "tightvncserver")
else
    echo "Xtightvnc already running"
fi

exit 0

