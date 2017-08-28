#! /bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
YEAR1=0
MONTH1=0
DAY1=0
for i in *jpg; do
  DAY=`echo $i | awk -F'[_]' '{print $3}' | awk -F'[-]' '{print $3}'`
  MONTH=`echo $i | awk -F'[_]' '{print $3}' | awk -F'[-]' '{print $2}'`
  YEAR=`echo $i | awk -F'[_]' '{print $3}' | awk -F'[-]' '{print $1}'`
  if ! [ -d $YEAR/$MONTH/$DAY ]
    then
    mkdir -p $YEAR/$MONTH/$DAY
  fi
  mv "$i" $YEAR/$MONTH/$DAY/
  if [ "$YEAR" = "$YEAR1" -a "$MONTH" = "$MONTH1" -a "$DAY" = "$DAY1" ]
    then
    :
    else
    echo "moving $YEAR/$MONTH/$DAY"
    YEAR1=$YEAR
    MONTH1=$MONTH
    DAY1=$DAY
  fi
done
