#!/usr/bin/python

import sys
import re

class FilteredRes:
    """A class to reprent each blast results"""
    def __init__(self, filename, node, sample,hit_def, indentities, hit_length, alignment_length, good_map, long_map,seqQ,seqP):
        self.filename = filename
        self.sample = sample
        m = re.search('NODE_(\d+)_length_(\d+)_cov_(.+)$',node)
        self.node = m.group(1)
        self.contig_length = m.group(2)
        self.contig_coverage = m.group(3)
        if hit_def!="":
            sp_st_gn=re.search('\|.+?\|(\S+) (.+)? OS=(.+) \(strain (.+)\) GN=(\S+) (.+)?',hit_def)
            self.proteinId = sp_st_gn.group(1)
            self.proteinName = sp_st_gn.group(2)
            self.species = sp_st_gn.group(3)
            self.strain = sp_st_gn.group(4)
            self.gene = sp_st_gn.group(5)
            
        else:
            self.proteinId = ""
            self.proteinName = ""
            self.species = ""
            self.strain = ""
            self.gene = ""
        self.indentities = indentities
        self.hit_length = hit_length   
        self.alignment_length = alignment_length
        self.good_map = good_map
        self.long_map = long_map
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
    