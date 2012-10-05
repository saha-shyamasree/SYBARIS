#!/usr/bin/env python

import csv
import re

class FilteredRes:
    """A class to reprent each blast results"""
    def __init__(self, filename,sample,node,length,coverage,species,strain,gene,proteinid,proteinname,gMap,lMap,seqQ,seqP):
        self.filename = filename
        self.sample = sample
        self.node = node
        self.length=length
        self.coverage=coverage
        self.species=species
        self.strain=strain
        self.proteinId = proteinid
        self.proteinName = proteinname
        self.gene = gene
        self.good_map = gMap
        self.long_map = lMap
        self.seqQ=seqQ
        self.seqP=seqP
    def getFilename(self):
        return self.filename;
    def getSample(self):
        return self.sample;
    def getNode(self):
        return self.node;
    def getLength(self):
        return self.contig_length;
    def getCoverage(self):
        return self.contig_coverage;
    def getProteinId(self):
        return self.proteinId;
    def getProteinName(self):
        return self.proteinName;
    def getSpecies(self):
        return self.species;
    def getStrain(self):
        return self.strain;
    def getGene(self):
        return self.gene;
    def getGoodMap(self):
        return self.good_map;
    def getLongMap(self):
        return self.long_map;
    def getSeqQ(self):
        return self.seqQ;
    def getSeqP(self):
        return self.seqP;

class BlastFilteredResParser:
    """A class to parse filtered blast results"""
    def __init__(self,filename):
        self._filename=filename
        self._results=[]
        
    def parse(self):
        blastResReader = csv.reader(open(self._filename, 'r'), delimiter=',')
        lno=0
        for row in blastResReader:
            if lno==0:
                print "Header"
                lno=1
            else:
                if len(row)!=14:
                    print "field missing"
                    exit
                else:
                    res=FilteredRes(row[0], row[1],row[2], row[3], row[4], row[5], row[6], row[7],row[8], row[9], row[10], row[11], row[12], row[13])
                    self._results.append(res)
    def getResults(self):
        return self._results
    def getResultsBySpeciesStrain(self,sp,st):
        filtered=[]
        for res in self._results:
            mat=re.search(st,res.getStrain())
            if mat:
                filtered.append(res)
        return filtered
    def removeResByProteinId(self,pid):
        for res in self._results:
            if res.getProteinId()==pid:
                return self._results.pop(self._results.index(res))
    def printResults(self):
        for res in self._results:
            print "File:"+res.getFilename(),
            print "\tSpecies:"+res.getSpecies(),
            print "\tStrain:"+res.getStrain(),
            print "\tProtein Id:"+res.getProteinId(),
            print "\tGene:"+res.getGene()
#parser=BlastFilteredResParser("blastFiltered/C023MABXX_3_8.out.csv")
#parser.parse()
#filtered=parser.getResultsBySpeciesStrain("","1075")
#print filtered[0].getSpecies()+filtered[0].getStrain()+filtered[0].getGene()+filtered[0].getProteinId()
#parser.printResults()
#removed=parser.removeResByProteinId("test")
#parser.printResults()
#if removed!=None:
#    print removed.getSpecies()