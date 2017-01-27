#!/bin/bash

###
# 07/08/2008
#
# Convert text File
#

###
# Verifie que le fichier ait un format avec CRLF

GLINE=`file $1 | grep "CRLF"`;
echo "(------------------Format---------------------)";
echo `file $1`
if [ -n "${GLINE}" ]
then

###
# Convertion du fichier

echo "(------------------Convert--------------------)";
perl -pi -e 's/\r$//g' $1;
echo "(-----------------New Format------------------)";
file $1;
else echo "ERROR : Bad Format or already convert";
fi
