#!/usr/bin/env python

import re
import csv
import os
import glob

class ContigReader:
    def __init__(self,filename,out,nameList):
        self.filename=filename
        self.outFile=out
        self.nameList=nameList
    def filterContigs(self):
        READ = open(self.filename,"r")
        WRT=open(self.outFile,"w")
        flag=0
        for line in READ:
            line=line.strip()
            m=re.match('>',line)
            if m:
                flag=0
                print "m:"+line[1:]
                if line[1:] in self.nameList:
                    flag=1
                    WRT.write(line+"\n")
            else:
                if flag==1:
                    WRT.write(line+"\n")
                print "Contig Seq"+line
        WRT.close()
        READ.close()

class FailedContigNames:
    def __init__(self,filenames):
        self.filenames=filenames
    def read(self):
        for filename in self.filenames:
            RD=csv.reader(open(filename,"r"), delimiter=',')
            namelist=[]
            flag=0 #flag for header
            for line in RD:
                if flag==0:
                    print "Header"+str(line)
                    flag=1
                else:
                    namelist.append("NODE_"+line[2]+"_length_"+line[3]+"_cov_"+line[4])
            fname=os.path.splitext(os.path.basename(filename))[0]
            if os.path.exists(os.path.join("contigsFailed",fname)):
                print "Folder already exists:"+os.path.join("contigsFailed",fname)
            else:
                print os.path.join("contigsFailed",fname)+" created"
                os.mkdir(os.path.join("contigsFailed",fname))
            contigReader=ContigReader(os.path.join("contigs/",fname+'/contigs.fa'),os.path.join("contigsFailed",fname+'/contigs.fa'),namelist)
            contigReader.filterContigs()

if os.path.exists("contigsFailed"):
    print "Folder already exists"
else:
    os.mkdir("contigsFailed")

files=glob.glob('blastFailed/*.out')
fcn=FailedContigNames(files)
fcn.read()
#reader=ContigReader("contigs/B07BNABXX_2_1/contigs.fa",[])
#reader.filterContigs()