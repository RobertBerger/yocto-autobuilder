#!/bin/bash
set -e

if grep -qs '/tmp/yocto-autobuilder' /proc/mounts; then
    echo "/tmp/yocto-autobuilder is mounted."

    if [[ -d /home/genius/test/yocto-autobuilder ]]; then

      if [[ $(stat -c %U /home/genius) == "root" ]]; then
        echo "fixing pemissions"
        sudo chown genius:genius /home/genius
      fi

      if [[ $(stat -c %U /home/genius/test) == "root" ]]; then
        echo "fixing pemissions"
        sudo chown genius:genius /home/genius/test
      fi

      rsync -avp /home/genius/test/yocto-autobuilder /tmp/yocto-autobuilder
      mv /home/genius/test/yocto-autobuilder /home/genius/test/yocto-autobuilder.ori
    else
      echo "/home/genius/test/yocto-autobuilder does not exist anymore"
    fi
else
    echo "/tmp/yocto-autobuilder is not mounted."
    exit 0 
fi

  if [[ -d /tmp/yocto-autobuilder/yocto-autobuilder ]]; then
        echo "starting yocto-autobuilder..."
        (su genius -c "cd /tmp/yocto-autobuilder/yocto-autobuilder ; ./yocto-stop-autobuilder both; . ./yocto-autobuilder-setup; ./yocto-start-autobuilder both")
  fi

# if [[ $(stat -c %U /home/genius) == "root" ]]; then
#     echo "fixing pemissions"
#     sudo chown genius:genius /home/genius
# fi

# if [[ $(stat -c %U /home/genius/test) == "root" ]]; then
#     echo "fixing pemissions"
#     sudo chown genius:genius /home/genius/test
# fi

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

