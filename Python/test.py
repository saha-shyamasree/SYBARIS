#!/usr/bin/env python

import re

m= re.search('length_(\d+)_cov_(.+)$','NODE_4810_length_167_cov_96.065865')

print m.group(2);

word="bananaT"

if word == "banana":
    print "It is banana"
else:
    print "It is not banana";
    
sp_st_gn=re.search('\|.+?\|(\S+) (.+)? OS=(.+) \(strain (.+)\) GN=(\S+) (.+)?','tr|B0XXJ6|B0XXJ6_ASPFC Putative uncharacterized protein OS=Neosartorya fumigata (strain CEA10 / CBS 144.89 / FGSC A1163) GN=AFUB_048570 PE=4 SV=1')

print sp_st_gn.group(5)