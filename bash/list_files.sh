#!/bin/sh
########################################################
##                                                    ##
## ABR:                                               ##
## Ce script affiche le repertoire courant            ##
## et test si un fichier existe                       ##
##                                                    ##
########################################################

# ou sommes nous ?
echo "1. Ou sommes nous ?"
pwd

echo 
echo 

# liste le contenu du repertoire courant (fichiers cachés inclus)
echo "2. Affichage du repertoire courant :"
ls -al

echo 
echo 

# on test si un fichier fourni en entrée existe
echo "3. Quel est le fichier a tester ?"
read a

if [ -d $a ]
then
	echo "C'est un repertoire !"
else
# ce n'est pas un repertoire donc on test si le fichier existe
		if [ ! -e $a ]
	then
	        ls -l "$a"
	else
	        ls -l "$a"
	fi

fi

if [ ! -e $a ]
then
	ls -l "$a"
else
	ls -l "$a"
fi

echo 
echo 

# on test si un fichier donné existe
file="/home/brosseta/scripts/list_files.sh"

echo "4. Le fichier $file existe t'il dans ce repertoire ?"

if [ ! -e $file ]
then
	ls -l "$file"
else
	ls -l "$file"
fi
