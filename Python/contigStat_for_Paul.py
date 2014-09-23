#!/usr/bin/python

from __future__ import division
import sys
sys.path.append('/nfs/ma/home/shyama/installed_soft/BiopythonCluster/lib64/python')
import Bio
import os
import glob
import math

from Bio.Blast import NCBIXML

#path = '/Volumes/ma-home/SYBARIS/WGS-AF293/Shyama/test/xml_output/'
#path = '/Volumes/ma-home-1/shyama/outputs/SYBARIS/BLAST/OG/xml_output_default_gap/'
#path = '/Volumes/ma-home-1/shyama/outputs/SYBARIS/BLAST/AF293/xml_output_gap/'
#path = '/Volumes/ma-home/shyama/outputs/SYBARIS/BLAST/OG/xml_output_gap_coverage/'
#print sys.argv[1:];
#path = '/nfs/ma/home/shyama/DATA/SYBARIS/data/blast/' #sys.argv[1] #
files = glob.glob('blast/B07BNABXX_1_9.out')
#infile=path
path='blastCSVPaul'
if not os.path.exists(path):
    os.makedirs(path)

#files=["blast/B07BNABXX_2_4.out","blast/C023MABXX_3_8.out","blast/D0ACKACXX_1_12.out","blast/B07BNABXX_1_9.out","blast/C023MABXX_5_2.out"]

for infile in files: #glob.glob('blast/*.out'):
    if os.path.getsize(infile)>0:
        file_handle = open(infile)
        
        out_handle = open(os.path.join(path,os.path.basename(infile)+'.csv'),'w')
        out_handle.write("file,query_name,query_length,match,hit_def,hit_length,e-value,p-value,identitie,bit_score,align_length,gap,good_match,long_match,score,more,seq,sseq,s_st,s_end\n")
        blast_record_itr = Bio.Blast.NCBIXML.parse(file_handle)
        for blast_record in blast_record_itr:
            out_handle.write(os.path.basename(infile) + ",")
            out_handle.write(blast_record.query + ",")
            out_handle.write(str(blast_record.query_letters)+",")
            if(len(blast_record.alignments)>0):
                out_handle.write("yes,")
                for alignment in blast_record.alignments:
                    count=len(alignment.hsps)
                    out_handle.write(alignment.hit_def.replace(",",";"))
                    out_handle.write(",")
                    out_handle.write(str(alignment.length))
                    out_handle.write(",")
                    for hsp in alignment.hsps:
                        out_handle.write(str(hsp.expect))
                        out_handle.write(",")
                        out_handle.write(str((1-math.exp(-(hsp.expect)))))
                        out_handle.write(",")
                        out_handle.write(str(hsp.identities))
                        out_handle.write(",")
                        out_handle.write(str(hsp.bits))
                        out_handle.write(",")
                        out_handle.write(str(hsp.align_length))
                        out_handle.write(",")
                        out_handle.write(str(hsp.gaps))
                        out_handle.write(",")
                        out_handle.write(str(round(hsp.identities/hsp.align_length,4)))
                        out_handle.write(",")
                        out_handle.write(str(round(hsp.identities/alignment.length,4)))
                        out_handle.write(",")
                        out_handle.write(str(hsp.score))
                        out_handle.write(",")
                        out_handle.write(str(count))
                        out_handle.write(",")
                        out_handle.write(hsp.query)
                        out_handle.write(",")
                        out_handle.write(hsp.sbjct)
                        out_handle.write(",")
                        out_handle.write(str(hsp.sbjct_start))
                        out_handle.write(",")
                        out_handle.write(str(hsp.sbjct_end)+"\n")
                        break
                    break
            else:
                out_handle.write("no, , , , , , , , , , , , , , \n")
    else:
        print infile+" is empty"
