Qui dit la fin de l'année.. dit statistiques... dit "sommes"...

Un des moyens de faire la somme des valeurs qui sont dans un fichier:

    awk '{ s+= $1 } END { print s }' File

Rien d'exceptionnel.. mais je ne m'en rappelle jamais.. donc le voici une fois pour toute.
