#! /bin/bash

### SET VARIABLES AND FAFF AT START ####

# define wait period between images and set incremental number for loop
DELAY=15
NUM=0
ROOT_FOLDER=/home/pi

# read in the next folder number, make that folder and increment folder number for next reboot
read -r FOLDER<$ROOT_FOLDER/number
mkdir -p $ROOT_FOLDER/$FOLDER
echo $[$FOLDER+1]>$ROOT_FOLDER/number

# record the delay between photos
echo "$DELAY seconds" > $ROOT_FOLDER/$FOLDER/delay.var



### TIMELAPSE SCRIPT ###

# infinite loop which takes photos
while true
do

# make incremental number 5 digid with leading zeros
BER="$(printf "%05d" $NUM)"

# take photo, increment loop number and wait
raspistill -w 3280 -h 1845 -vf -hf --nopreview -o $ROOT_FOLDER/$FOLDER/"$FOLDER"_loungeDIY_$BER.jpg
NUM=$[$NUM+1]
sleep $DELAY

# check to see if it is time to stop taking photos for backup & reset
if [ `date +%H` -eq 23 ]; then
break
fi

done

