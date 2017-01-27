#!/usr/bin/perl
my $file_name=shift;
my $rejected=0;
my $total=0;
my $pc_rejected;
my $regexp="Z+[0-9AEIOUYaeiouy@&éèàù£]*B+";
#my $regexp="Z+[aeiouy@&éèàù£3]*B+";
#my $regexp="[\\w-]+(\\.[\\w-]+)*(:(\\d+))?(/\\w+)*(/\\w+\\.\\w+)?(\\?\\w+=\\w+(&(\\w+=\\w+))*)?";

open(my $in,  "<", $file_name)  or die "Can't open input file: $!";
print "regexp: $regexp\n";
print "\n";
while (<$in>) {
    chomp($_);
    $total++;
    print "$_\t";
    if ($_ =~ /$regexp/o ) {
        print "It matches       => rejected\n";
        $rejected++;
    }
    else {
        print "It doesn't match => accepted\n";
    }
}
$pc_rejected=sprintf("%.1f", 100*$rejected/$total);
print("\n$rejected rejected / $total sentences, $pc_rejected \% rejected\n");
