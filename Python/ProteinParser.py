#!/usr/bin/env python
import re

class Protein:
    """A class to to represent Protein sequence"""
    def __init__(self, pid,seqname,st,ed,strnd,gid,tid,seq):
        self._protein = pid
        self._seqname = seqname
        self._start = st
        self._end = ed
        self._strand = strnd
        self._gene = gid
        self._transcript = tid
        self._seq = seq
    def getProtein(self):
        return self._protein
    def getSeqName(self):
        return self._seqname
    def getStart(self):
        return self._start
    def getEnd(self):
        return self._end
    def getStrand(self):
        return self._strand
    def getGene(self):
        return self._gene
    def getTranscript(self):
        return self._transcript
    def getSeq(self):
        return self._seq
    def setProtein(self,p):
        self._protein=p
    def setSeqName(self,sn):
        self._seqname=sn
    def setStart(self,st):
        self._start=st
    def setEnd(self,ed):
        self._end=ed
    def setStrand(self,strnd):
        self._strand=strnd
    def setGene(self,g):
        self._gene=g
    def setTranscript(self,t):
        self._transcript=t
    def setSeq(self,sq):
        self._seq=sq

class ProteinParser:
    """A class to to represent Protein sequence"""
    def __init__(self, filename):
        self._filename = filename
        self._proteinCodingSeq=[]
        self._seqSize=0
    def parse(self):
        PRT=open(self._filename,"r")
        print "\nParsing "+self._filename
        records=[]
        for line in PRT:
            line=line.strip()
            m=re.match('>',line)
            if m:
                tags=re.split('\s+',line)
                #tags are in folowing order protein_id, pep:known/unknown(optional), feature:CADRE:feature_number:start:end:starnd gene:gene_id transcript:transcript_id
                no_of_tags=len(tags)
                chr_info=re.split(':',tags[no_of_tags-2-1])
                #my $nucl=<READ>;
                #chomp($nucl);
                gene_inf=re.split(':',tags[no_of_tags-1-1])
                trns_inf=re.split(':',tags[no_of_tags-1])
                #print "Length of Tag:",
                #print tags[1],
                #print len(tags)
                #print "pr id:"+tags[0],
                #print ", feat id:",
                #print chr_info[2],
                #print ",start:",
                #print chr_info[3],
                #print ",end:",
                #print chr_info[4],
                #print ",strand:",
                #print chr_info[5],
                #print ",gene id:",
                #print gene_inf[1],
                #print ", transcript:"+str(trns_inf[1])
                #print len(gene_inf)+",transcript id:"+len(trns_inf)
                PCS=Protein(tags[0],chr_info[2],chr_info[3],chr_info[4],chr_info[5],gene_inf[1],trns_inf[1],"")
                records.append(PCS);
            else:
                last=records.pop();
                last_seq=last.getSeq()
                last_seq=last_seq+line
                last.setSeq(last_seq)
                records.append(last)
        self._seqSize=len(records)
        self._proteinCodingSeq=records
        print "\nTotal Protein:"+str(self._seqSize)
    def getFilename(self):
        return self._filename
    def getProteinSeq(self):
        return self._proteinCodingSeq
    def getProteinSeqByIndex(self,ind):
        return self._proteinCodingSeq[ind]
    def getProteinSeqByProtein(self,pid):
        #print "pid:"+pid
        proteins=self._proteinCodingSeq
        prt=[pc for pc in proteins if pid==pc.getProtein()]
        #print len(prt)
        if len(prt)==1:
            #print "prt 0:"
            #print prt[0].getProtein()
            return prt[0]
        else:
	    print "PID of no match:"+pid
	    print "match length:"+str(len(prt))
	    print "File Name:"+self._filename
            return None
    def getSeqSize(self):
        return self._seqSize
    def printProteinCodingSeqArray(self):
        for rec in self._proteinCodingSeq:
            self.printProteinCodingSeq(rec)
#parser=ProteinParser("/Volumes/ma-home/shyama/DATA/SYBARIS/data/protein/C023MABXX_3_8.fa")
#parser.parse()
#pr=parser.getProteinSeqByIndex(2)
#print pr.getProtein()
#pr=parser.getProteinSeqByProtein(">CADANIAP00000003")
#if pr:
    #print pr.getStart()
#else:
    #print "Did not find the protein"