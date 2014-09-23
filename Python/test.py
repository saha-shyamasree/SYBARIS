import re
import os
from Bio.Blast import NCBIXML
def split_len(seq, length):
    return [seq[i:i+length] for i in range(0, len(seq), length)]

m= re.search('length_(\d+)_cov_(.+)$','NODE_4810_length_167_cov_96.065865')

print(m.group(2));

word="banana apple orange plum grape"

if word == "banana":
    print("It is banana")
else:
    print("It is not banana")
    
sp_st_gn=re.search('\|.+?\|(\S+) (.+)? OS=(.+) \(strain (.+)\) GN=(\S+) (.+)?','tr|B0XXJ6|B0XXJ6_ASPFC Putative uncharacterized protein OS=Neosartorya fumigata (strain CEA10 / CBS 144.89 / FGSC A1163) GN=AFUB_048570 PE=4 SV=1')

print(sp_st_gn.group(5))

l=[5,10,15,20]
if 15 in l:
    print("15 is there")
else:
    print("15 is not in the list")
word_list=split_len(word,5)
print(word_list)
print(word)
"""
rep = "*"*1
print "Repchar 0 times:"+rep+"END"
infile="/nfs/ma/home/shyama/code/SYBARIS/Python/BlastResFilter.py"
print os.path.splitext(os.path.basename(infile))[0]
"""