#!/usr/bin/awk

BEGIN {
}
{
msisdn=$1;
if ( MSISDN[msisdn] != msisdn) {
MSISDN[msisdn]=msisdn;
CPT[msisdn]=0;
}
CPT[msisdn]++;
}
END {
for ( msisdn in MSISDN) {
print msisdn" "CPT[msisdn];
}
}
