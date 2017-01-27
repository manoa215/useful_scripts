#! /bin/sh
# letter-count.sh: Compter les occurrences des lettres d'un fichier texte.
#
# Script de nyal (nyal@voila.fr).
# Utilisé avec sa permission.
# Nouveaux commentaires par l'auteur du document.


INIT_TAB_AWK=""
# Paramètre pour initialiser le script awk.
compteur=0
FICHIER_A_ANALYSER=$1

E_PARAMERR=65

usage()
{
    echo "Usage: letter-count.sh fichier lettres" 2>&1
    # Par exemple:   ./letter-count.sh nom_fichier a b c
    exit $E_PARAMERR  # Pas assez d'arguments passé au script.
}

if [ ! -f "$1" ] ; then
    echo "$1: Fichier inconnu." 2>&1
    usage      # Affiche le message d'usage et quitte.
fi 

if [ -z "$2" ] ; then
    echo "$2: Aucune lettre spécifiée." 2>&1
    usage
fi 

shift                      # Lettres spécifiées.
for lettre in `echo $@`    # Pour chacune...
  do
  INIT_TAB_AWK="$INIT_TAB_AWK tableau_recherche[${compteur}] = \"$lettre\"; tableau_final[${compteur}] = 0; " 
  # A passer au script awk ci-dessous.
  compteur=`expr $compteur + 1`
done

# DEBUG:
# echo $INIT_TAB_AWK;

cat $FICHIER_A_ANALYSER |
# Envoyer le fichier cible au script awk suivant.

# --------------------------------------------------------------------------------
awk -v tableau_recherche=0 -v tableau_final=0 -v tab=0 -v nb_letter=0 -v chara=0 -v caractere2=0 \
"BEGIN { $INIT_TAB_AWK } \
{ split(\$0, tab, \"\"); \
for (caractere in tab) \
{ for (caractere2 in tableau_recherche) \
{ if (tableau_recherche[caractere2] == tab[caractere]) { tableau_final[caractere2]++ } } } } \
END { for (caractere in tableau_final) \
{ print tableau_recherche[caractere] \" => \" tableau_final[caractere] } }"
# --------------------------------------------------------------------------------
#  Rien de très compliqué, seulement...
#+ boucles for, tests if et quelques fonctions spécialisées.

exit $?
