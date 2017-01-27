#!/usr/bin/python

import time, datetime

TRANSACTION_ID_PREFIX = "CH"
TRANSACTION_ID_LENGTH = 10
msisdn="3360743803"

# ensuite tu enleve 1251763200000 et tu as le nb de msec depuis le 01/09/09
time=(time.time() * 1000) - 1251763200000
print "time=" + str(time)
lmsisdn=long(msisdn)
print "msisdn=" + str(lmsisdn)

xor = long(time) ^ lmsisdn
print "xor: "+str(xor)
sXor = hex(xor)
print "xor (hex)=" + sXor
suffixLength = TRANSACTION_ID_LENGTH - len(TRANSACTION_ID_PREFIX)

if (len(sXor) > suffixLength):
    # keep last "suffixLength" chars from sXor
    sXorMin=(len(sXor) - suffixLength)-1
    sXor = sXor[int(sXorMin):int(len(sXor))]
else:
    # pad sXor with '0' until suffixLength is reached
    sXor = "0000000000".concat(sXor);
    sXor = sXor[int(len(sXor) - int(suffixLength)):int(len(sXor))]

# we remove the last caractere L=Long - substring
sXor = sXor[0:len(sXor)-1]

print "suffix (hex)=" + sXor
transactionId=TRANSACTION_ID_PREFIX
transactionId=transactionId+sXor
print "transactionId (hex)=" + transactionId
