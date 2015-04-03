IMAGE_NAME=$1
NETWORK_INTERFACE=$2

if [ $# -lt 2 ];
then
    echo "+ $0: Too few arguments!"
    echo "+ use something like:"
    echo "+ $0 <docker image> <network interface>" 
    echo "+ $0 reslocal/yocto-autobuilder br0"
    echo "+ $0 reslocal/yocto-autobuilder docker0"
    exit
fi

# enable TUN device (for qemu)
echo "+ sudo modprobe tun"
sudo modprobe tun

# run the image
#echo "+ ID=\$(docker run -i -t -d -p 22 --privileged ${IMAGE_NAME} /bin/bash)"
#ID=$(docker run -i -t -d -p 22 --privileged ${IMAGE_NAME} /bin/bash)

echo "+ ID=\$(docker run -t -i -d -p 22 -p 8010 -p 8000 -p 8200 --privileged ${IMAGE_NAME} /sbin/my_init -- bash -l)"
ID=$(docker run -t -i -d -p 22 -p 8010 -p 8000 -p 8200 --privileged ${IMAGE_NAME} /sbin/my_init -- bash -l)

# ssh stuff:
PORT=$(docker port ${ID} 22 | awk -F':' '{ print $2 }')
IPADDR=$(ifconfig ${NETWORK_INTERFACE} | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}')
echo "+ ssh to the container like this:"
echo "ssh -X genius@${IPADDR} -p ${PORT}"

# web stuff:
WEBPORT=$(docker port ${ID} 8010 | awk -F':' '{ print $2 }')
echo "+ point your browser to:"
echo "http://${IPADDR}:${WEBPORT}"

# toaster stuff:
PORT_8000=$(docker port ${ID} 8000 | awk -F':' '{ print $2 }')
PORT_8200=$(docker port ${ID} 8200 | awk -F':' '{ print $2 }')
echo "+ port 8000 maps to: ${PORT_8000}"
echo "+ port 8200 maps to: ${PORT_8200}"

# let's attach to it:
echo "+ docker attach ${ID}"
docker attach ${ID}
