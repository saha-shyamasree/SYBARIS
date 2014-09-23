#!/usr/bin/env python

import csv
import re
import sys
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
out_handle_binary = open("NEXUS/sybarisBinary.csv",'w')
out_handle_binary.write("ProteinID")
for key in ref_mapping:
    out_handle_binary.write(","+key)
    strains=ref_mapping[key]
    strain_obj_dict = {}
    strain_obj_dict_blast = {}
    print "Initialization size of strain_obj_dict_blast:"+str(len(strain_obj_dict_blast))
    print "Ref protein file.:"+ref_seq_map[key]
    parser=ProteinParser(ref_seq_map[key])
    parser.parse()
    blastparser=BlastFilteredResParser("blastFiltered/"+key+".out.csv")
    strain_obj_dict_blast[key]=blastparser
    strain_obj_dict[key]=parser
    for strain in strains:
        #object of ProteinParser
        out_handle_binary.write(","+strain)
        print "strain file name:"+names_mapping[strain]
        afend=re.search("_AF293$",names_mapping[strain])
        blastparser=BlastFilteredResParser("blastFiltered/"+names_mapping[strain]+".out.csv")
        print "key:"+key+" strain:"+strain
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
    print "size of strain_obj_dict_blast:"+str(len(strain_obj_dict_blast))
    print "keys of strain_obj_dict_blast:"+str(strain_obj_dict_blast.keys());
    print "strain_obj_dict_blast being added for "+key+", size of ref_strain_blast:"+str(len(ref_strain_blast))
    ref_strain_blast[key]=strain_obj_dict_blast
    print "After adding, size of ref_strain_blast:"+str(len(ref_strain_blast))
    ref_strain[key]=strain_obj_dict
print "1. keys of ref_strain_blast:"+str(ref_strain_blast.keys())    
out_handle_binary.write("\n")
out_handle = open("NEXUS/sybarisblast.nex",'w')
out_handle.write("#NEXUS\nBegin data;\nDimensions ntax=42 nchar=25539600;\nFormat datatype=protein gap=- interleave;\nMatrix\n")
#code for chunking the protein seq and writing to file

length=100
repChar="-"*100
for ref in ref_mapping:
    parsers=ref_strain[ref]
    parser=parsers[ref]
    proteins=parser.getProteinSeq()
    for pr in proteins:
        pid=pr.getProtein()
        print "protein:"+pid
        out_handle_binary.write(pid)
        refSeq = pr.getSeq()
        chunks={}
        prChunks=split_len(refSeq,length)
        chunks[ref]=prChunks
        maxlist=len(prChunks)
        strains=ref_strain[ref]
        
        for strn in strains:
            stprt=strains[strn].getProteinSeqByProtein(pid)
            chunks[strn]=split_len(stprt.getSeq(),length)
            if(len(chunks[strn])==0):
                print "Strain "+strn+" chunks has length 0. seq:"+stprt.getSeq();
                sys.exit()
            if len(chunks[strn])>maxlist:
                maxlist=len(chunks[strn])
        removedChunks={}
        #for binary nexus, it should be outside following loop.
        for it in range(maxlist):
            #print "2. keys of ref_strain_blast:"+str(ref_strain_blast.keys()) 
            for cref in ref_mapping:
                if ref!=cref:
                    strains=ref_strain[cref]
                    if it==0:
                        print "non prot ref, but ref:"+cref
                        out_handle_binary.write(",0")
                    for strn in strains:
                        if strn==cref:
                            out_handle.write(strn+"\t"+repChar+"\n")
                        else:
                            if it==0:
                                print "strn:"+strn
                                #print " keys of ref_strain_blast["+cref+"]:"+str(ref_strain_blast[cref].keys())
                                #print " keys of ref_strain["+cref+"]:"+str(ref_strain[cref].keys())
                                removed=ref_strain_blast[cref][strn].removeResByProteinId(pid)
                                if removed!=None:
                                    print "same protein found in blast different species,protein id:"+pid+"\t Strain:"+strn
                                    removedChunks[strn]=split_len(removed.getSeqQ(),length)
                                    remRepChar="-"*(100-len(removedChunks[strn][it]))
                                    out_handle.write(strn+"\t"+removedChunks[strn][it]+remRepChar+"\n")
                                    
                                    if removed.getSeqQ()==refSeq:
                                        print "non prot ref, prot match"
                                        out_handle_binary.write(",1")
                                    else:
                                        print "non prot ref, prot not match"
                                        out_handle_binary.write(",0.5")
                                else:
                                    out_handle.write(strn+"\t"+repChar+"\n")
                                    print "non prot ref, prot not exists"
                                    out_handle_binary.write(",0")
                            else:
                                if removedChunks.has_key(strn):
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
                    #out to binary shoud be here
                    if it==0:
                        print "prot ref:"+cref
                        out_handle_binary.write(",1")
                    for key in chunks:
                        if it==0 and key!=ref:
                            print "strn:"+key
                        clen=len(chunks[key])
                        if it>=clen:
                            out_handle.write(key+"\t"+repChar+"\n")
                        else:
                            if it==0:
                                #print "2 keys of ref_strain_blast["+cref+"]:"+str(ref_strain_blast[cref].keys())
                                #print "2 keys of ref_strain["+cref+"]:"+str(ref_strain[cref].keys())
                                removed=ref_strain_blast[cref][key].removeResByProteinId(pid)
                                
                                if removed!=None:
                                    print "same protein found in blast"
                                    chunks[key]=split_len(removed.getSeqQ(),length)
                                    if key!=ref:
                                        if removed.getSeqQ()==refSeq:
                                            print "prot ref, prot match"
                                            out_handle_binary.write(",1")
                                        else:
                                            print "prot ref, prot not match"
                                            out_handle_binary.write(",0.5")
                                else:
                                    if key!=ref:
                                        if "".join(chunks[key])==refSeq:
                                            print "prot ref, prot match"
                                            out_handle_binary.write(",1")
                                        else:
                                            print "prot ref, prot not match"
                                            out_handle_binary.write(",0.5")
                            clen2=len(chunks[key][it])
                            if clen2<length:
                                remChar="-"*(length-clen2)
                                out_handle.write(key+"\t"+chunks[key][it]+remChar+"\n")
                            else:
                                out_handle.write(key+"\t"+chunks[key][it]+"\n")
        out_handle_binary.write("\n")
blastresults=[]
uniqueProts=[]
for cref in ref_mapping:
    strains=ref_strain[cref]
    for strn in strains:
        blastresults=blastresults+ref_strain_blast[cref][strn].getResults()
for br in blastresults:
    if len(uniqueProts)==0:
        uniqueProts.append(br.getProteinId())
    else:
        if br.getProteinId() in uniqueProts:
            print "already added"
        else:
            uniqueProts.append(br.getProteinId())

for u in uniqueProts:
    #check whether there is another node from this protein.
    nodes=[bpr for bpr in blastresults if bpr.getProteinId()==u]
    blChunks={}
    out_handle_binary.write(u)
    print "Protein:"+u
    #following should always be true
    if len(nodes)>0:
        #it means there are more node mapping to this protein, so collect chunks
        maxc=0
        for nd in nodes:
            blChunks[nd.getSample()]=split_len(nd.getSeqQ(),length)
            if maxc<len(blChunks[nd.getSample()]):
                maxc=len(blChunks[nd.getSample()])
        for it in range(maxc):
            for cref in ref_mapping:
                strains=ref_strain[cref]
                if it==0:
                    if blChunks.has_key(cref):
                        print "check cref"+cref
                        out_handle_binary.write(",1")
                    else:
                        print "check cref"+cref
                        out_handle_binary.write(",0")
                for strn in strains:
                    
                    if blChunks.has_key(strn):
                        if it==0 and strn!=cref:
                            print "check strn "+strn
                            out_handle_binary.write(",1")
                        if it>=len(blChunks[strn]):
                            out_handle.write(strn+"\t"+repChar+"\n")
                        else:
                            remRepChar="-"*(length-len(blChunks[strn][it]))
                            out_handle.write(strn+"\t"+blChunks[strn][it]+remRepChar+"\n")
                    else:
                        out_handle.write(strn+"\t"+repChar+"\n")
                        if it==0 and strn!=cref:
                            print "check strn "+strn
                            out_handle_binary.write(",0")
    else:
        print "ERROR, this should not happen"
    out_handle_binary.write("\n")
out_handle.write("\t;\nEND;\n")
out_handle.close()
out_handle_binary.close()
