#!/bin/bash

cat x.txt

echo "---------------------------------"
awk '{ print "a = a + " $1 "; a" }' x.txt | bc -l | tail -1
SUM=`awk '{ print "a = a + " $1 "; a" }' x.txt | bc -l | tail -1`
echo "$SUM/9" | bc
#T=`$SUM/9 | bc`
#echo $T
