#!/llayers/bin/perl
my $regexp="(www+\\.)?[\\w-]+\\s{0,3}[\\.,;:!]\\s{0,3}(r[o0]|n[e3]t|lt|c[o0]m|[i!]nf[o0]|[o0]rg|b[i!][z2]|ru|[e3]du)(\\/)?";
my $file=shift;
$|=1;
open (TAIL,"tail -f $file|") or die "can't open pipe:$!"; 
while ($text = <TAIL>) {
    if ($text =~ /.*(ACCEPTED|REFUSED):(.*)/) {
        $msg = $2;
        chomp($msg);
        if ($msg =~ /$regexp/oi ) {
            print "It matches       => rejected\t$msg\n";
        }
        else {
            print "It doesn't match => accepted\t$msg\n";
        }
    }
}
