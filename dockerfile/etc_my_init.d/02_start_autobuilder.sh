#!/bin/bash
set -e

# check if we have /tmp/yocto-autobuilder
if grep -qs '/tmp/yocto-autobuilder' /proc/mounts; then
    echo "/tmp/yocto-autobuilder is mounted."

    # do we have /tmp/yocto-autobuilder and /home/genius/test/yocto-autobuilder?
    if [[ -d /home/genius/test/yocto-autobuilder ]]; then
      
      # we have /tmp/yocto-autobuilder and /home/genius/test/yocto-autobuilder
      if [[ $(stat -c %U /home/genius) == "root" ]]; then
        echo "fixing pemissions"
        sudo chown genius:genius /home/genius
      fi

      if [[ $(stat -c %U /home/genius/test) == "root" ]]; then
        echo "fixing pemissions"
        sudo chown genius:genius /home/genius/test
      fi

      #rsync -avp /home/genius/test/yocto-autobuilder /tmp/yocto-autobuilder
      #mv /home/genius/test/yocto-autobuilder /home/genius/test/yocto-autobuilder.ori
      read -r -p "Do you really want to wipe your build dirs and (maybe) update yocto-autobuilder? [y/N] " response
      case $response in
        [yY][eE][sS]|[yY])
        set -x
        sudo rm -rf /tmp/yocto-autobuilder/yocto-autobuilder
        mv /home/genius/test/yocto-autobuilder/ /tmp/yocto-autobuilder/yocto-autobuilder
        rm -f /tmp/yocto-autobuilder/yocto-autobuilder/yocto-worker/twistd.pid
        set +x
        ;;
    *)
        echo "leaving the yocto-autobuilder as you have it plus build dirs"
        #rsync -avp /home/genius/test/yocto-autobuilder /tmp/yocto-autobuilder
        mv /home/genius/test/yocto-autobuilder /home/genius/test/yocto-autobuilder.ori
        ;;
      esac
#      sudo rm -rf /tmp/yocto-autobuilder/yocto-autobuilder
#      mv /home/genius/test/yocto-autobuilder/ /tmp/yocto-autobuilder/yocto-autobuilder
#      rm -f /tmp/yocto-autobuilder/yocto-autobuilder/yocto-worker/twistd.pid
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

