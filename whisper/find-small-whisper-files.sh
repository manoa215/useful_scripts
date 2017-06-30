#!/bin/bash
#
# Find whisper files smaller than correct file size (676k)
#

echo "Find whisper files smaller than 676K: "
cd /opt/graphite/storage/whisper
find . -type f -size -676k
