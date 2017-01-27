#!/usr/bin/python

import time, datetime

d = datetime.datetime.now()
ts=time.mktime(d.timetuple())
print "time: " 
print d
print "timestamp: "
print ts
print "timestamp integer"
print int(ts)
