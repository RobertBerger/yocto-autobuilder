IMAGE_NAME=$1
# let's run it - we'll share a folder with the host
echo "+ ID=\$(docker run -i -t -d ${IMAGE_NAME} /bin/bash)"
ID=$(docker run -i -t -d ${IMAGE_NAME} /bin/bash)
# let's attach to it
echo "+ docker attach ${ID}"
docker attach ${ID}
