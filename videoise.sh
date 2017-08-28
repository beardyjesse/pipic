#! /bin/bash

# store the start time in order to compare at the end
START=`date`

# list and then count all folders and subfolders to 3 levels to understand how many times to loop.
# clumsy method, but works
COUNT=`ls -dl {*/,*/*/,*/*/*/} | wc -l`

# loop through that many times
for i in $(eval echo {1..$COUNT})
do

# set the folder names.  NOTE: this doesn't work for folders with spaces in as the awk only sees the 9th section and none after
  FOLDER=`ls -dl {*/,*/*/,*/*/*/} | sed -n "$i"p | awk '{print $9}'`
  echo -e "\n---------------------------\nchecking $FOLDER"

# check that mp4 file doesn't exist (and hence one may be needed)
  if ! ls "$FOLDER"*mp4 1> /dev/null 2>&1 ; then
  echo "no mp4 in $FOLDER"
# now check if there are jpeg files (and hence if an mp4 should be made)
    if ls "$FOLDER"*jpg 1> /dev/null 2>&1 ; then

# make it obvious in the output that a video was made by printing +'s
      echo "make video in $FOLDER ++++++++++++++"
# get the date of the photos from their file name for naming the video
# ls -l lists the files in long format
# tail cuts all but first two and head takes the last so as to avoid the size info from ls -l which is prined first
# 1st awk takes the last part of that only - the filename
# 2nd awk then used "_" to define the selection criteria and takes the date
      DATE=`ls "$FOLDER" -l | tail -n +2 | head -1 | awk '{printf $9;}' | awk -F '[_]' '{printf $3;}'`

# time command used to output the time taken to run the ffmpeg command
# -loglevel error means that only errors are reported
# -r 15 is 15 fps, -i brings in all the jpegs from the current working directory
# -vf is not verbose something, it means [from man page];
# Simple filtergraphs are configured with the per-stream -filter option (with -vf and -af aliases for video and audio respectively)
      time ffmpeg -loglevel error -r 15 -i $FOLDER'%*.jpg' -vf crop=3280:2464 $FOLDER"balcony_$DATE.mp4"
      echo "made balcony_$DATE.mp4"
    else

# if no jpgs then it's a root folder [or error] - stop
    echo "no jpg in $FOLDER"

# to do nothing in an if command (i.e. not use the above echo statement have to use the below colon
# : 
    fi
  else

# if there is an mp4 then do nothing
  echo "existing mp4 in $FOLDER"
  fi

done 

# write out the start and finish times for record keeping
echo -e "\nscript START:\n$START"
echo "script FINISH"
date

exit 0
