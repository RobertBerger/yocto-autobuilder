echo "+ docker images"
docker images
echo "+ docker rmi $(docker images -a -q)"
docker rmi $(docker images -a -q)
echo "+ docker images"
docker images
