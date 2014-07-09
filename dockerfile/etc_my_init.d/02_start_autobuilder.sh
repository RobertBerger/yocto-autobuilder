#!/bin/bash
set -e

if [[ -d /home/genius/test/yocto-autobuilder ]]; then
      echo "starting yocto-autobuilder..."
      (su genius -c "cd /home/genius/test/yocto-autobuilder ; ./yocto-stop-autobuilder both; . ./yocto-autobuilder-setup; ./yocto-start-autobuilder both")
fi

if [[ $(stat -c %U /home/genius/test) == "root" ]]; then
    echo "fixing pemissions"
    sudo chown genius:genius /home/genius/test
fi

exit 0

