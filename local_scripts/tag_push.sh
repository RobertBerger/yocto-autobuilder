docker images
docker tag reslocal/yocto-autobuilder:latest reliableembeddedsystems/yocto-autobuilder:latest
docker login --username reliableembeddedsystems
docker images
docker push reliableembeddedsystems/yocto-autobuilder:latest
