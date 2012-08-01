#!/usr/bin/sh

blast_path=/Volumes/ma-home/SYBARIS/WGS-AF293/Shyama/BLAST+/ncbi-blast-2.2.26+/bin
cd $blast_path

input_path=/Volumes/ma-home/SYBARIS/WGS-AF293/D0A-unaligned/
num=0
for f in $input_path*
do
    if [ -d $f ]
    then
        echo $f;
        contig_file_name=`basename $f`
        echo $contig_file_name;
        temp=grep -h ">" $contig_file_name | wc -l
        num=`$num+$temp`
    fi
done
echo $num
