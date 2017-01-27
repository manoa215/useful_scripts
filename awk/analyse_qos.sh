#!/bin/sh

cat app01_access_log.200810060000 | awk '{if ($NF >= 5000000) print $4 " " $7 " " $NF;}'> app01 ; wc -l app01
