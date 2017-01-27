BEGIN {
}
{
DATING_SID_L=38;

Champ7="JSESSIONID=4912D729A0F03FA461D0FA9FE6932F9C.mer01; - 0"
print "$7 = "Champ7

idxsid=index(Champ7,"JSESSIONID=");
print "idxsid = "idxsid


field=Champ7;
print "field = "field;

sid = substr(field,idxsid+11,DATING_SID_L);
print "sid = "sid


}
END {
}
