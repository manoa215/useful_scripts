#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# sms.py
#
# This scripts sends a SMS through Orange SMS API
# It takes the phone number as argument and reads the text message from standard input
#
# (c) Hervé Le Roy
# Licence: GPLv3
 
import re, string, sys, urllib
import elementtree.ElementTree as ET
import cElementTree as ET
import lxml.etree as ET
#import xml.etree.ElementTree as ET # Python 2.5
 
# Your Orange SMS API key
API_KEY='xxx'
 
usage_message = """Usage: echo "" | sms.py 
  is read from stdin to allow piping to the script. Bear in mind text message will be truncated to 160 characters
  must be an international phone number without leading "+" and without any space or dash. Example: 33610203040"""
 
class UsageError(Exception):
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return repr(self.value)
 
def sendsms(phone,text):
    urlbase = 'http://sms.beta.orange-api.net/sms/sendSMS.xml?'  # Orange SMS API base URL
    urlparam = urllib.urlencode([('id',API_KEY),('to',phone),('content',text)])
    response = ET.parse(urllib.urlopen(urlbase+urlparam)).getroot()
    return response.findtext('status/status_code')
 
def main(argv=None):
    if argv is None:
        argv = sys.argv
    try:
        # reads phone number (first argument on the command line)
        try:
            phone_number = sys.argv[1]
        except:
            raise UsageError("Missing phone number\n")
 
        # match phone number  against a very simple regex (10 to 14 digits allowed, no other signs)
        if not re.match("\d{10,14}$",phone_number):
            raise UsageError("Incorrect phone number\n")
 
        if not sys.stdin.isatty():
            text_message = sys.stdin.read() # Text message is read from standard input
            text_message = text_message[:159] # Truncate text message to 160 characters
        else:
            raise UsageError("Missing text message (empty stdin)\n")
 
        # sends sms and return response from Orange SMS API
        return sendsms(phone_number,text_message)
 
    except UsageError, errormsg:
        print >>sys.stderr, errormsg.value
        print >>sys.stderr, usage_message
        return 2
 
if __name__ == "__main__":
    sys.exit(main())
