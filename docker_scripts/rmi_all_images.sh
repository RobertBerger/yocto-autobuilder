echo "+ docker images"
docker images
echo "+ docker rmi -f $(docker images -a -q)"
docker rmi -f $(docker images -a -q)
echo "+ docker images"
docker images
