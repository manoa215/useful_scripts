# si http code reponse not equal to 200
tail -f access_log  | awk '{if ($9 != 200) {print $1 " " $7 " " $9 " "  $NF;}}'
