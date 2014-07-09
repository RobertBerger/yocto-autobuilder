echo "+ docker ps -a"
docker ps -a
echo "+ docker stop $(docker ps -a -q)"
docker stop $(docker ps -a -q)
echo "+ docker rm -f $(docker ps --no-trunc -a -q)"
docker rm -f $(docker ps --no-trunc -a -q)
echo "+ docker ps -a"
docker ps -a
