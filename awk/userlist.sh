#!/bin/bash
# userlist.sh

FICHIER_MOTS_DE_PASSE=/etc/passwd
n=1           # Nombre d'utilisateurs

for nom in $(awk 'BEGIN{FS=":"}{print $1}' < "$FICHIER_MOTS_DE_PASSE" )
# Champ séparateur = :  ^^^^^^
# Affiche le premier champ      ^^^^^^^^
# Obtient l'entrée à partir du fichier        ^^^^^^^^^^^^^^^^^^^^^^
do
  echo "UTILISATEUR #$n = $nom"
  let "n += 1"
done  


# UTILISATEUR #1 = root
# UTILISATEUR #2 = bin
# UTILISATEUR #3 = daemon
# ...
# UTILISATEUR #30 = bozo

exit 0
