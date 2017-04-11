if [ "$#" -ne 1 ]; then
    echo "Usage:"
    echo "./special_tag_push.sh <tag>"
    exit
fi

set -x
docker images
docker tag reslocal/yocto-autobuilder:latest reliableembeddedsystems/yocto-autobuilder:$1
docker images
docker login --username reliableembeddedsystems
docker push reliableembeddedsystems/yocto-autobuilder:$1
set +x
