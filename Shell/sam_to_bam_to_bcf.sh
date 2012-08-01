#!/bin/sh

#  sam_to_bam_to_bcf.sh
#  
#
#  Created by Shyamasree Saha on 01/06/2012.
#  Copyright (c) 2012 __EMBL-EBI__. All rights reserved.

#/Volumes/ma-home/shyama/DATA/SYBARIS/ReferenceGenome

samtool_path=$1
input_dir=$2

output_dir=$3
sorted_dir=$4
ref_dir=$5
echo "samtool path: $samtool_path";
#referenceFile=$ref_dir/AF293_REF.fasta
#$samtool_path/./samtools faidx $refenceFile $ref_dir/
referenceFile=$ref_dir/AF293_REF.fasta
for file in $input_dir/*.sam
do
name=`basename $file .sam`
echo $file;
echo $name;

if [ "$name" == "D0ACKACXX_1_12" ]; then
    echo "it is exception file";
    referenceFile=$ref_dir/Neosartorya_fischeri.CADRE.12.dna.toplevel.fa
#echo $name;
else
    referenceFile=$ref_dir/AF293_REF.fasta
fi

#$samtool_path/./samtools view -u -S $file -o $output_dir/$name.bam
#$samtool_path/./samtools sort $output_dir/$name.bam $sorted_dir/$name
echo $name;
#$samtool_path/./samtools index $sorted_dir/$name.bam $output_dir/$name.index
$samtool_path/./samtools mpileup -E -ugf $refenceFile $sorted_dir/$name.bam | $samtool_path/bcftools/./bcftools view -bvcg - > /nfs/ma/home/shyama/outputs/SYBARIS/Bowtie2/D0ACKACXX/bcf/$name.bcf
done


#$samtool_path/./samtools mpileup -E -ugf $refenceFile $sorted_dir/D0ACKACXX_1_1.bam | $samtool_path/bcftools/./bcftools view -bvcg - > /nfs/ma/home/shyama/outputs/SYBARIS/Bowtie2/D0ACKACXX/bcf/D0ACKACXX_1_1.bcf