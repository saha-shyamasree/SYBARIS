@files=glob("*.txt");
open(WR,">","/nfs/ma/home/shyama/outputs/all_unmapped.csv");
foreach my $f(@files)
{
  open(RD,"<",$f) or die("Could not open $f");
  print $f;
  my @lines=<RD>;
  $lines[0]=~s/^\s+//g;
  $lines[0]=~s/\s+/,/g;
  print WR $lines[0]."\n";
  close(RD);
}

close(WR);