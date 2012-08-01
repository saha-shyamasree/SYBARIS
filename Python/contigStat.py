#!/usr/bin/python

from __future__ import division
import Bio
import os
import glob
import math

from Bio.Blast import NCBIXML

#path = '/Volumes/ma-home/SYBARIS/WGS-AF293/Shyama/test/xml_output/'
#path = '/Volumes/ma-home-1/shyama/outputs/SYBARIS/BLAST/OG/xml_output_default_gap/'
#path = '/Volumes/ma-home-1/shyama/outputs/SYBARIS/BLAST/AF293/xml_output_gap/'
path = '/Volumes/ma-home-1/shyama/outputs/SYBARIS/BLAST/OG/xml_output_gap_coverage/'
#files = os.listdir(path)
E_VALUE_THRESHOLD = 0.04

print "file,query_name,query_length,match,hit_def,e-value,p-value,start,end,identitie,align_length,gap,coverage%,score,more"
for infile in glob.glob( os.path.join(path,'*.out')):
    file_handle = open(infile)
    blast_record_itr = Bio.Blast.NCBIXML.parse(file_handle)
    for blast_record in blast_record_itr:
        print os.path.basename(infile) + ",",
        print blast_record.query + ",",
        print blast_record.query_letters,
        print ",",
	if(len(blast_record.alignments)>0):
            print "yes,",
            for alignment in blast_record.alignments:
                count=len(alignment.hsps)
                print alignment.hit_def.replace(",",";"),
                print ",",
                for hsp in alignment.hsps:
                    print hsp.expect,
                    print ",",
                    print (1-math.exp(-(hsp.expect))),
                    print ",",
                    print hsp.sbjct_start,
                    print ",",
                    print hsp.sbjct_end,
                    print ",",
                    print hsp.identities,
                    print ",",
                    print hsp.align_length,
                    print ",",
                    print hsp.gaps,
                    print ",",
                    print round(hsp.identities/hsp.align_length,2),
                    print ",",
                    print hsp.score,
                    print ",",
                    print count
                    break
                break
        else:
            print "no,,,,,,,,"

