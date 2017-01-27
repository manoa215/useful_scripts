#!/bin/bash
# pid-identifier.sh: Donne le chemin complet du processus associé avec ce pid.

NBARGS=1  # Nombre d'arguments que le script attend.
E_MAUVAISARGS=65
E_MAUVAISPID=66
E_PROCESSUS_INEXISTANT=67
E_SANSDROIT=68
PROCFILE=exe

if [ $# -ne $NBARGS ]
then
  echo "Usage: `basename $0` PID" >&2  # Message d'erreur >stderr.
  exit $E_MAUVAISARGS
fi  

nopid=$( ps ax | grep $1 | awk '{ print $1 }' | grep $1 )
# Cherche le pid dans l'affichage de "ps", car il est le champ #1.
# S'assure aussi qu'il s'agit du bon processus, et non pas du processus appelé
# par ce script.
# Le dernier "grep $1" supprime cette possibilité.
if [ -z "$nopid" ] # Si, après tous ces filtres, le résultat est une chaîne vide
then               # aucun processus en cours ne correspond au pid donné.
  echo "Aucun processus en cours."
  exit $E_PROCESSUS_INEXISTANT
fi  

# Autrement:
#   if ! ps $1 > /dev/null 2>&1
#   then                # Aucun processus ne correspond au pid donné.
#     echo "Ce processus n'existe pas"
#     exit $E_PROCESSUS_INEXISTANT
#    fi

# Pour simplifier tout cet algorithme, utilisez "pidof".


if [ ! -r "/proc/$1/$PROCFILE" ]  # Vérifiez les droits en lecture.
then
  echo "Processus $1 en cours, mais..."
  echo "Ne peut obtenir le droit de lecture sur /proc/$1/$PROCFILE."
  exit $E_SANSDROIT
    # Un utilisateur standard ne peut accéder à certains fichiers de /proc.
fi  

# Les deux derniers tests peuvent être remplacés par:
#    if ! kill -0 $1 > /dev/null 2>&1 # '0' n'est pas un signal, mais
                                      # ceci testera s'il est possible
                                      # d'envoyer un signal au processus.
#    then echo "PID n'existe pas ou vous n'êtes pas son propriétaire" >&2
#    exit $E_MAUVAISPID
#    fi



fichier_exe=$( ls -l /proc/$1 | grep "exe" | awk '{ print $11 }' )
# Ou       fichier_exe=$( ls -l /proc/$1/exe | awk '{print $11}' )
#
# /proc/pid-number/exe est un lien symbolique
# vers le chemin complet du processus appelé.

if [ -e "$fichier_exe" ]  # Si /proc/pid-number/exe existe...
then                   # le processus correspondant existe.
  echo "Processus #$1 appelé par $fichier_exe"
else
  echo "Processus inexistant"
fi  


# Ce script élaboré peut *pratiquement* être remplacé par
# ps ax | grep $1 | awk '{ print $5 }'
# Néanmoins, cela ne fonctionnera pas...
# parce que le cinquième champ de 'ps' est le argv[0] du processus,
# et non pas le chemin vers l'exécutable.
#
# Néanmoins, une des deux méthodes suivantes devrait fonctionner.
#       find /proc/$1/exe -printf '%l\n'
#       lsof -aFn -p $1 -d txt | sed -ne 's/^n//p'

# Commentaires supplémentaires par Stephane Chazelas.

exit 0
