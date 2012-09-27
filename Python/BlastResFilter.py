#!/usr/bin/python
# -*- coding: utf-8 -*-

import csv
import sys
import re
import glob
import os
from FilteredRes import FilteredRes

#names_mapping={
#'C023MABXX_5_2':'CEA10',
#'C023MABXX_5_2_AF293':'CEA10',
#'B07BNABXX_1_9':'CEA10-2',
#'B07BNABXX_1_9_AF293':'CEA10-2',
#'C023MABXX_4_1':'AF300',                                
#'C023MABXX_3_7':'F21857',                               
#'C023MABXX_3_6':'F21732',                               
#'C023MABXX_3_5':'F21572',                               
#'C023MABXX_3_4':'F20451',                               
#'C023MABXX_3_3':'F18454',                               
#'C023MABXX_3_2':'F18329',                               
#'C023MABXX_3_1':'F17999',                               
#'B07BNABXX_1_9':'CEA10-2',                              
#'B07BNABXX_2_1':'AF293_VKBR1',                          
#'B07BNABXX_2_2':'AF293_VKBR3',                          
#'B07BNABXX_2_3':'AF293_VKWH2',                          
#'B07BNABXX_3_8':'AF300-2',                              
#'D0ACKACXX_1_11':'F4S1B',                               
#'D0ACKACXX_1_2':'F18304',                               
#'D0ACKACXX_1_3':'F20063',                               
#'D0ACKACXX_1_5':'CF098',                                
#'D0ACKACXX_1_6':'CF337',                               
#'D0ACKACXX_1_7':'JN10',                                 
#'D0ACKACXX_1_8':'D17',                                  
#'D0ACKACXX_1_9':'F20140',                               
#'D0ACKACXX_2_1':'M128',                                 
#'D0ACKACXX_2_10':'SF2S6',                                
#'D0ACKACXX_2_13':'SF4S10',                               
#'D0ACKACXX_2_14':'RSF2S8',                               
#'D0ACKACXX_2_2':'AP65',                                 
#'D0ACKACXX_2_3':'SF1S5',                                
#'D0ACKACXX_2_4':'SF1S6',                                
#'D0ACKACXX_2_6':'SF2S9',                                
#'D0ACKACXX_2_7':'SF3S1',                                
#'D0ACKACXX_2_8':'SF3S10',                               
#'D0ACKACXX_1_1':'F18149',
#'C023MABXX_3_8':'F8226',
#'B07BNABXX_2_4':'F8226-2'
#}
#
class BlastResFilter:
    """A class to filter meaningful blast results"""
    def __init__(self, filename):
        self.filename = filename
        self.objects = []
    def getFilename(self):
        return self.filename;
    def read(self):
        #, node, hit_def, indentities, hit_length, alignment_length, good_map, long_map
       blastResReader = csv.reader(open(self.filename, 'rb'), delimiter=',')
       i=0
       noCol=0
       goodCol=0
       longCol=0
       idenCol=0
       nodeCol=0
       hitDefCol=0
       hitCol=0
       alignCol=0
       fileCol=0
       seqQCol=0
       seqPCol=0
       
       goodCutOff=0.97
       longCutOff=0.95
       
       for row in blastResReader:
        j=0
        for item in row:
            if i==0:
                if item.strip() == "file":
                    fileCol=j
                elif item.strip() == "match":
                    noCol=j
                elif item.strip() == "good_match":
                    goodCol=j
                elif item.strip() == "identitie":
                    idenCol=j
                elif item.strip() == "long_match":
                    longCol=j
                elif item.strip() == "query_name":
                    nodeCol=j
                elif item.strip() == "hit_def":
                    hitDefCol=j
                elif item.strip() == "hit_length":
                    hitCol=j
                elif item.strip() == "align_length":
                    alignCol=j
                elif item.strip() == "seq":
                    seqQCol=j
                elif item.strip() == "sseq":
                    seqPCol=j
            else:
                if goodCol>longCol:
                    print "Wrong data Order"
                    break
                if j==noCol and item.strip() == "no":
                    break
                elif j==goodCol:
                    if item.strip() < goodCutOff:
                        break
                elif j==longCol:
                    if item.strip() <= longCutOff:
                        break
                elif j==seqPCol:
                    if float(row[goodCol]) >= goodCutOff and float(row[longCol]) > longCutOff:
                        m=re.search("(.+)?\.out",row[fileCol])
                        #print names_mapping[m.group(1)]
                        resObj=FilteredRes(m.group(1),row[nodeCol],names_mapping[m.group(1)],row[hitDefCol],row[idenCol],row[hitCol],row[alignCol],row[goodCol],row[longCol],row[seqQCol],row[seqPCol])
                        self.objects.append(resObj)
            j+=1
        i+=1
       
    def write(self,outFile):
        csvWriter = csv.writer(open(outFile, 'wb'), delimiter=',')
        csvWriter.writerow(['File','Sample','Node','Length','Coverage','Species','Strain','Gene','ProteinID','ProteinName','GoodMap','LongMap','SeqQ','SeqP'])
        for row in self.objects:
            #csvWriter.writerow(row)
            csvWriter.writerow([row.getFilename(),row.getSample(),row.getNode(),row.getLength(),row.getCoverage(),row.getSpecies(),row.getStrain(),row.getGene(),row.getProteinId(),row.getProteinName(),row.getGoodMap(),row.getLongMap(),row.getSeqQ(),row.getSeqP()])
    def getObj(self):
        return self.objects;
#path = sys.argv[1]

class Manipulator:
    def __init__(self):
        self.resObj=[]
        self.proteins=[]
        self.sample_indices={}
        self.protein_sample={}
    def blastWriter(self):
        files=["blastCSV/B07BNABXX_2_4.out.csv","blastCSV/C023MABXX_3_8.out.csv","blastCSV/D0ACKACXX_1_12.out.csv","blastCSV/B07BNABXX_1_9.out.csv","blastCSV/C023MABXX_5_2.out.csv"]
        for infile in files: #glob.glob('blastCSV/*.csv'):
            filter=BlastResFilter(infile)
            filter.read();
            self.resObj=self.resObj+filter.getObj();
            filter.write(os.path.join("blastFiltered",os.path.basename(infile)))
    def proteinCollection(self):
        for obj in self.resObj:
            if any(obj.getProteinId() in p for p in self.proteins):
                continue
            else:
                if obj.getFilename()=="B07BNABXX_2_4" or obj.getFilename()=="C023MABXX_3_8" or obj.getFilename()=="D0ACKACXX_1_12" or obj.getFilename()=="B07BNABXX_1_9" or obj.getFilename()=="C023MABXX_5_2":
                    print "non af293 files"
                    self.proteins.append(obj.getProteinId())
                else:
                    print "af293 files"
                    self.proteins.append(obj.getProteinId())
    def proteinSampleIndex(self):
        for s in names_mapping:
                print "S:"+s
                li = [s==o.getFilename() for o in self.resObj]
                indices=[]
                it=0
                for l in li:
                    if l==True:
                        indices.append(it)
                    it+=1
                if s=="B07BNABXX_2_4" or s=="C023MABXX_3_8" or s=="D0ACKACXX_1_12" or s=="B07BNABXX_1_9" or s=="C023MABXX_5_2":
                    print "non af293 files"
                    self.sample_indices[names_mapping[s]]=indices
                else:
                    print "af293 files"
                    #self.sample_indices[names_mapping[s]]=indices
    def binaryProteinList(self):
        csvWriter = csv.writer(open("NEXUS/blastedMatchlistAllSYBARIS.csv", 'wb'), delimiter=' ')
        print "Sorted"
        sortedKey=sorted(self.sample_indices.keys());
        string=','.join(sortedKey)
        string='ProteinId,GeneId,'+string
        csvWriter.writerow([string])
        print string
        
        for p in self.proteins:
            gid=""
            samples=[]
            for s in sortedKey:
                #print "*"+s
                indices=self.sample_indices[s]
                flag=0
                for ind in indices:
                    if self.resObj[ind].getProteinId()==p:
                        samples.append("1")
                        gid=self.resObj[ind].getGene()
                        flag=1
                        break
                if flag==0:
                    samples.append("0")
            string=p+","+gid+","+','.join(samples)
            csvWriter.writerow([string])
            self.protein_sample[p]=samples
    def getProteinSample(self):
        return self.protein_sample

names_mapping={}

map_file="../Mapping/all_sybaris_name_map.csv"
mapReader = csv.reader(open(map_file, 'rb'), delimiter=',')
for row in mapReader:
    names_mapping[row[0]]=row[1]
print names_mapping

manObj=Manipulator()
manObj.blastWriter()
#manObj.proteinCollection()
#manObj.proteinSampleIndex()
#manObj.binaryProteinList()