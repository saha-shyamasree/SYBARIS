#!/usr/bin/env python

import csv
import re
from ProteinParser import ProteinParser,Protein
from BlastFilteredResParser import BlastFilteredResParser, FilteredRes
def split_len(seq, length):
    return [seq[i:i+length] for i in range(0, len(seq), length)]


ref_file="maps/ref_strain_map.csv"
refReader = csv.reader(open(ref_file, 'rb'), delimiter=',')
ref_mapping={}

for row in refReader:
    if ref_mapping.has_key(row[0].strip()):
        #
        l=ref_mapping[row[0].strip()]
        l.append(row[1].strip())
        ref_mapping[row[0].strip()]=l
    else:
        l=[row[1].strip()]
        ref_mapping[row[0].strip()]=l
print ref_mapping


ref_seq_file="maps/ref_prot_file_map.csv"
refSeqReader = csv.reader(open(ref_seq_file, 'r'), delimiter=',')
ref_seq_map={}

for row in refSeqReader:
        ref_seq_map[row[0].strip()]=row[1].strip()


names_mapping={}
map_file="maps/jcvi_sybaris_name_map.csv"
mapReader = csv.reader(open(map_file, 'r'), delimiter=',')
for row in mapReader:
    names_mapping[row[1].strip()]=row[0].strip()
print names_mapping



ref_strain={}
ref_strain_blast={}
for key in ref_mapping:
    strains=ref_mapping[key]
    strain_obj_dict = {}
    strain_obj_dict_blast = {}
    print "Ref protein file.:"+ref_seq_map[key]
    parser=ProteinParser(ref_seq_map[key])
    parser.parse()
    strain_obj_dict[key]=parser
    for strain in strains:
        #object of ProteinParser
        print "strain file name:"+names_mapping[strain]
        afend=re.search("_AF293$",names_mapping[strain])
        blastparser=BlastFilteredResParser("blastFiltered/"+names_mapping[strain]+".out.csv")
        blastparser.parse()
        strain_obj_dict_blast[strain]=blastparser
        #filtered=blastparser.getResultsBySpeciesStrain("","1075")
        parser=None
        if afend:
            parser=ProteinParser(ref_seq_map[key])
        else:
            parser=ProteinParser("protein/"+names_mapping[strain]+".fa")
        parser.parse()
        strain_obj_dict[strain]=parser
    ref_strain_blast[key]=strain_obj_dict_blast
    ref_strain[key]=strain_obj_dict
    

out_handle = open("NEXUS/allRefblast.nexus",'w')
#code for chunking the protein seq and writing to file

length=100
repChar="-"*100
for ref in ref_mapping:
    parsers=ref_strain[ref]
    parser=parsers[ref]
    proteins=parser.getProteinSeq()
    for pr in proteins:
        pid=pr.getProtein()
        refSeq = pr.getSeq()
        chunks={}
        prChunks=split_len(refSeq,length)
        chunks[ref]=prChunks
        maxlist=len(prChunks)
        strains=ref_strain[ref]
        
        for strn in strains:
            stprt=strains[strn].getProteinSeqByProtein(pid)
            chunks[strn]=split_len(stprt.getSeq(),length)
            if len(chunks[strn])>maxlist:
                maxlist=len(chunks[strn])
        removedChunks={}
        for it in range(maxlist):
            for cref in ref_mapping:
                if ref!=cref:
                    #out_handle.write(cref+"\t"+repChar+"\n")
                    strains=ref_strain[cref]
                    for strn in strains:
                        if strn==cref:
                            out_handle.write(strn+"\t"+repChar+"\n")
                        else:
                            if it==0:
                                removed=ref_strain_blast[cref][strn].removeResByProteinId(pid)
                                if removed!=None:
                                    print "same protein found in blast different species,protein id:"+pid+"\t Strain:"+strn
                                    removedChunks[strn]=split_len(removed.getSeqQ(),length)
                                    remRepChar="-"*(100-len(removedChunks[strn][it]))
                                    out_handle.write(strn+"\t"+removedChunks[strn][it]+remRepChar+"\n")
                                else:
                                    out_handle.write(strn+"\t"+repChar+"\n")
                            else:
                                if removedChunks[strn]:
                                    if len(removedChunks[strn])<=it:
                                        out_handle.write(strn+"\t"+repChar+"\n")
                                    else:
                                        remRepChar="-"*(100-len(removedChunks[strn][it]))
                                        out_handle.write(strn+"\t"+removedChunks[strn][it]+remRepChar+"\n")
                                else:
                                    out_handle.write(strn+"\t"+repChar+"\n")
                else:
                    #100 char from 0th location protein
                    #foreach strain same.
                    for key in chunks:
                        clen=len(chunks[key])
                        if it>=clen:
                            out_handle.write(key+"\t"+repChar+"\n")
                        else:
                            if it==0:
                                removed=ref_strain_blast[cref][strn].removeResByProteinId(pid)
                                if removed!=None:
                                    print "same protein found in blast"
                                    chunks[key]=split_len(removed.getSeqQ(),length)
                            clen2=len(chunks[key][it])
                            if clen2<length:
                                remChar="-"*(length-clen2)
                                out_handle.write(key+"\t"+chunks[key][it]+remChar+"\n")
                            else:
                                out_handle.write(key+"\t"+chunks[key][it]+"\n")
    blastresults=[]
    for cref in ref_mapping:
        blastresults=blastresults+ref_strain_blast[cref].getResults()

    for br in blastresults:
        #check whether there is another node of from this protein.
        nodes=[bpr for bpr in blastresults if bpr.getProtein()==br.getProtein()]
        blChunks={}
        if len(nodes)>0:
            #it means there are more node mapping to this protein, so collect chunks
            maxc=0
            for nd in nodes:
                blChunks[nd.getSample()]=split_len(nd.getSeqQ())
                if maxc<len(blChunks[nd.getSample()]):
                    maxc=len(blChunks[nd.getSample()])
            for it in range(maxc):
                for cref in ref_mapping:
                    strains=ref_strain[cref]
                    for strn in strains:
                        if blChunks[strn]:
                            if it>=len(blChunks[strn]):
                                out_handle.write(strn+"\t"+repChar+"\n")
                            else:
                                remRepChar="-"*(length-len(blChunks[strn][it]))
                                out_handle.write(strn+"\t"+blChunks[strn][it]+remRepChar+"\n")
                        else:
                            out_handle.write(strn+"\t"+repChar+"\n")