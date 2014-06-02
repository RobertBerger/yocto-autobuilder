#IMAGE_NAME="reslocal/yocto"
IMAGE_NAME=$1
#HOST_FOLDER="${HOME}/yocto-image"
#IMAGE_FOLDER="/home/genius/yocto"
# this is a hack against permission denied
# there is still a problem with yocto when it populates the rootfs
#if [ ! -d ${HOST_FOLDER} ];
#then
#     echo "${HOST_FOLDER} does not exist, creating it"
#     mkdir -p ${HOST_FOLDER}
#     chmod a+w ${HOST_FOLDER}
#else
#     echo "${HOST_FOLDER} exists"
#fi
#docker run -i -t reslocal/yocto /bin/bash
#echo "+ ID=\$(docker run -p 127.0.0.1::22 -i -t -d ${IMAGE_NAME} /bin/bash)"
#ID=$(docker run -p 127.0.0.1::22 -i -t -d ${IMAGE_NAME} /bin/bash)
#echo "+ ID=\$(docker run -i -t -d ${IMAGE_NAME} /bin/bash)"
#ID=$(docker run -i -t -d ${IMAGE_NAME} /bin/bash)
#echo "+ ID=\$(docker run -i -t -d -v ${HOST_FOLDER}:${IMAGE_FOLDER}:rw ${IMAGE_NAME} /bin/bash)"
#ID=$(docker run -i -t -d -v ${HOST_FOLDER}:${IMAGE_FOLDER}:rw ${IMAGE_NAME} /bin/bash)
echo "+ ID=\$(docker run -i -t -d ${IMAGE_NAME} /bin/bash)"
ID=$(docker run -i -t -d ${IMAGE_NAME} /bin/bash)
#echo "+ IPAddress: $(docker inspect --format '{{ .NetworkSettings.IPAddress }}' ${ID})"
# ssh does not work for now
#echo "+ ssh to: $(docker port ${ID} 22)"
echo "+ docker attach ${ID}"
docker attach ${ID}
