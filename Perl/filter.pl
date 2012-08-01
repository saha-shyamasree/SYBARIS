#!/usr/bin/perl

while (<>) {
  if (/^#/) {
    print;
  } elsif (/AC1=2;/ && /AF1=1;/) {
		@data = split(/\t/);
    $dp = $_;
    $dp =~ s/.+DP=([0-9]+);.+$/\1/;
    $tmp = $_;
    $tmp =~ s/.+DP4=([0-9,]+);.+$/\1/;
		@dp4 = split(/,/, $tmp);
    if (@data[5] >= 70 && $dp >= 20 && @dp4[0] == 0 && @dp4[1] == 0 && @dp4[2] > 4 && @dp4[3] > 4) {
			print;
    }
  }
}
