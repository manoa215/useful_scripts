#!/bin/bash
# for an "svn pristine text not present" error like this:
# svn: E155010: Pristine text 'd6612ee6af5d9fb4459cbe7e2e8e18f7fb4201f8' not present
# you can delete the file and retrieve it with svn up
# (if you have local modifications, make up your own plan)
# -
# Run this script from the root of the working copy.
# It retrieves the file that's causing the error from wc.db
# usage example : ./svn-pristine-find.sh d6612ee6af5d9fb4459cbe7e2e8e18f7fb4201f8

SHA1="$1"
set -e

FILE=$(sqlite3 .svn/wc.db 'select local_relpath from nodes where checksum="$sha1$'$SHA1'"')

echo "File causing trouble is: $FILE";
