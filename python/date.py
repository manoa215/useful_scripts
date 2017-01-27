#!/usr/bin/python


#----------------------------- 
#introduction
# There are three common ways of manipulating dates in Python
# mxDateTime - a popular third-party module (not discussed here) 
# time - a fairly low-level standard library module 
# datetime - a new library module for Python 2.3 and used for most of these samples 
# (I will use full names to show which module they are in, but you can also use
# from datetime import datetime, timedelta and so on for convenience) 

import time
import datetime

today = datetime.date.today()
print "The date is", today 
#=> The date is 2003-08-06

print "Today is day", time.localtime()[7], "of the current year" 
# Today is day 218 of the current year

today = datetime.date.today()
print "Today is day", today.timetuple()[7], "of ", today.year
# Today is day 218 of 2003

print "Today is day", today.strftime("%j"), "of the current year" 
# Today is day 218 of the current year

