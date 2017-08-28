#! /bin/bash
read -r FOLDER</home/pi/number
mkdir -p /home/pi/$FOLDER
echo $[$FOLDER+1]>/home/pi/number
NUM=0
while true
do
BER="$(printf "%05d" $NUM)"
raspistill -w 2592 -h 1458 -vf -hf --nopreview -o /home/pi/$FOLDER/"$FOLDER"_oggcamp2017_$BER.jpg
NUM=$[$NUM+1]
sleep 10
done
