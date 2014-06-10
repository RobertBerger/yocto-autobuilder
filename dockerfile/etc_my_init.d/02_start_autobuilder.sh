#!/bin/bash
set -e

if [[ -d /home/genius/test/yocto-autobuilder ]]; then
      echo "starting yocto-autobuilder..."
      (su genius -c "cd /home/genius/test/yocto-autobuilder ; ./yocto-stop-autobuilder both; . ./yocto-autobuilder-setup; ./yocto-start-autobuilder both")
      exit 0
fi
