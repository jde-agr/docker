#!/bin/sh

GRN="\x1B[0;32m"
YEL="\x1B[1;33m"
RST="\x1B[0m"

echo $YEL"First we need to create the onbuild image."$RST
echo $YEL"I want to run the command:"$RST
echo "    docker build -t ft-rails:on-build -f ft-rails/Dockerfile ."
echo $YEL"Proceed (y) or skip?"$RST  
read RESPONSE
if [ "$RESPONSE" = "y" ]
then
	docker build -t ft-rails:on-build -f ft-rails/Dockerfile .
fi
RESPONSE="n"

echo $YEL"Now that the onbuild image is created, we need to build the app image"$RST
echo $YEL"I want to run the command:"$RST
echo "    docker build -t railsapp-img ."
echo $YEL"Proceed (y) or skip?"$RST  
read RESPONSE
if [ "$RESPONSE" = "y" ]
then
	docker build -t railsapp-img .
fi
RESPONSE="n"

echo $YEL"Now that the app image is created, we can run the app"$RST
echo $YEL"I want to run the command:"$RST
echo "    docker run -d --name railsapp -it --rm -p 3000:3000 railsapp-img"
echo $YEL"Proceed (y) or skip?"$RST  
read RESPONSE
if [ "$RESPONSE" = "y" ]
then
	docker run -d --name railsapp -it --rm -p 3000:3000 railsapp-img
fi
RESPONSE="n"

echo $YEL"Waiting a bit for the server to stabilize..."$RST
sleep 2
echo $YEL"Server is running. You can now open:"$RST
echo $GRN"    $(docker-machine ip Char):3000"$RST
echo $YEL"in a web browser. When finished, run"$RST
echo $GRN"    docker stop railsapp"$RST
echo $YEL"and the app container will delete itself."$RST
