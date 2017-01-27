#!/usr/bin/python

import urllib


URL="https://xx.xxx.xxx.xxx/cgi-bin/mt.py"

parameters = {'asp':'xxx','password':'xxx','method':'sendAsynchronousSMS', 'sender':'xxx','recipients':'xxxxxxxxxx','text':'TEST+MT'}

p = urllib.urlencode(parameters)
s = urllib.urlopen(URL+"?"+p)
print URL+"?"+p
print s.read()
