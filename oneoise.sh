#! /bin/bash

# store the start time in order to compare at the end
START=`date`
LIST=`date -I`
WD=/home/beard/NAS/backup/Pictures/timelapse/weir_balcony/"$LIST"

# clear the file and print timer
mkdir -p $WD

# list and then count all folders and subfolders to 3 levels to understand how many times to loop.
# clumsy method, but works
COUNT=`ls -dl {*/,*/*/,*/*/*/} | wc -l`

# loop through that many times
for i in $(eval echo {1..$COUNT})
do

# set the folder names.  NOTE: this doesn't work for folders with spaces in as the awk only sees the 9th section and none after
  FOLDER=`ls -dl {*/,*/*/,*/*/*/} | sed -n "$i"p | awk '{print $9}'`
  echo -e "\n---------------------------\nchecking $FOLDER"

# check folder has images
  if ! ls "$FOLDER"*jpg 1> /dev/null 2>&1 ; then
  echo "no images in $FOLDER"
  else
    if ls "$FOLDER"*13-00* 1> /dev/null 2>&1 ; then
    COPYTHIS=`ls "$FOLDER"*13-00*`
# copy the file to a folder
    cp "$COPYTHIS" "$WD"
    echo "copied $COPYTHIS"
    else
    :
    fi
  fi
done

# write out the start and finish times for record keeping
echo -e "\nscript START:\n$START"
echo "script FINISH"
date

exit 0
