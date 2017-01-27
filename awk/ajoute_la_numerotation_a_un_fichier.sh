awk '{printf "%03u : %s\n",FNR,$0}' titi

#ou

awk '{print FNR " : " $0 }' titi
