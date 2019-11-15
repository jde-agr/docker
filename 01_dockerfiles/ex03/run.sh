#!/bin/sh

GRN="\x1B[0;32m"
RED="\x1B[1;31m"
YEL="\x1B[1;33m"
RST="\x1B[0m"

echo $YEL"First we need to create the image."$RST
echo $YEL"I want to run the command:"$RST
echo "    docker build -t my-gitlab ."
echo $YEL"Proceed (y) or skip?"$RST  
read RESPONSE
if [ "$RESPONSE" = "y" ]
then
	docker build -t my-gitlab .
fi
RESPONSE="n"

echo $YEL"Now that the image is created, we can run a container"$RST
echo $YEL"I want to run the command:"$RST
echo "    docker run -it -p 8080:80 -p 8022:22 -p 8443:443 --privileged my-gitlab"
echo $YEL"Proceed (y) or skip?"$RST  
read RESPONSE
if [ "$RESPONSE" = "y" ]
then
	docker run -it -p 8080:80 -p 8022:22 -p 8443:443 --privileged my-gitlab
fi
RESPONSE="n"

# echo $RED"The remainder of run.sh has not been implemented yet."$RST
# exit 0
