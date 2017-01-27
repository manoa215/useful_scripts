#!/usr/bin/python

nom = raw_input('\n Entrer le nom du fichier : ')

fd = open(nom, 'r')
n = 0
for line in fd:
    n += 1
fd.close()

print "nb lines: "+str(n)
