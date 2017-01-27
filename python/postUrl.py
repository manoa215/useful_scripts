#!/usr/bin/python

# post xml soap message
# Made by OFA who want a part of the pognon
import sys, httplib,datetime

HOST="tutu.com"
URI="/toto/http/"


JB_TEMPLATE="""

-----------------------------1851513825346697882541390826

Content-Disposition: form-data; name="ctx_userAge"



12

-----------------------------1851513825346697882541390826

Content-Disposition: form-data; name="ctx_userSex"



M

-----------------------------1851513825346697882541390826

Content-Disposition: form-data; name="ctx_userId"



007

-----------------------------1851513825346697882541390826

Content-Disposition: form-data; name="cnt_profiledesc"
Content-Type: content/url

%s-----------------------------1851513825346697882541390826

Content-Disposition: form-data; name="submit"



send to moderation

-----------------------------1851513825346697882541390826--
"""


def sendContent(ticket):
        #construct and send the header
        webservice = httplib.HTTP(HOST)
        webservice.putrequest("POST", URI)
        webservice.putheader("Host", HOST)
        webservice.putheader("User-Agent", "Python post")

        webservice.putheader("Referer", "http://lalala:6666/postobject.html")
        webservice.putheader("X-AiR-ClientName", "ORA_LALA")
        webservice.putheader("X-AiR-Command", "COMMAND1")
        webservice.putheader("X-AiR-ObjectType", "TRACK_CONTENT")
        webservice.putheader("X-AiR-ObjectId", "123")
        webservice.putheader("Content-Type", "multipart/form-data; boundary=---------------------------1851513825346697882541390826")
        webservice.putheader("Content-length", "%d" % len(ticket))
        webservice.endheaders()
        webservice.send(ticket.encode('utf-8','replace'))

        # get the response
        statuscode, statusmessage, header = webservice.getreply()
        print "Response: ", statuscode, statusmessage
        print "headers: ", header
        res = webservice.getfile().read()
        print res


#Main
if len(sys.argv) != 2:
        print "Usage: %s url" % sys.argv[0]
else:
        content = sys.argv[1]
        tk=JB_TEMPLATE % (content)
        print tk
        t1=datetime.datetime.now()
        sendContent(tk)
        t2=datetime.datetime.now()
        print "-------------------------------------"
        print "DELTA %s" % (t2-t1)
        print "-------------------------------------"

