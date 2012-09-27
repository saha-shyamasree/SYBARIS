#!/usr/bin/sh

blast_path=/nfs/ma/home/SYBARIS/WGS-AF293/Shyama/BLAST+/ncbi-blast-2.2.26+/bin
cd $blast_path

input_path=/nfs/ma/home/shyama/DATA/SYBARIS/data/contigs/
#input_path=/nfs/ma/home/SYBARIS/WGS-AF293/D0A-unaligned/
#input_path=/nfs/ma/home/shyama/outputs/SYBARIS/Perl/
#input_path=/nfs/ma/home/shyama/outputs/SYBARIS/Perl/AF293/gap_penalty/
#db=/nfs/ma/home/shyama/DATA/SYBARIS/database/OG/other_genomic
#db=/nfs/ma/home/shyama/DATA/SYBARIS/database/AF293/AF293_db
db=/nfs/ma/home/shyama/DATA/SYBARIS/database/Fungi_Uniprot_Programmatical_complete/BLAST_DB/fungi_complete
#out=/nfs/ma/home/shyama/outputs/SYBARIS/BLAST/AF293/xml_output_gap/
#out=/nfs/ma/home/shyama/outputs/SYBARIS/BLAST/OG/xml_output_gap_coverage/
#out=/nfs/ma/home/shyama/outputs/SYBARIS/BLAST/Fungi_Uniprot/xml_output_gap/
out=/nfs/ma/home/shyama/DATA/SYBARIS/data/blast/
for f in $input_path"B07BNABXX_2_4" $input_path"C023MABXX_3_8" $input_path"D0ACKACXX_1_12" $input_path"B07BNABXX_1_9" $input_path"C023MABXX_5_2" #$input_path*
do
    if [ -d $f ]
    then
        echo $f;
        contig_file_name=`basename $f`
        echo $contig_file_name;
#bsub -o /nfs/ma/home/shyama/outputs/blastn_job.out -M 10000 -R 'rusage[mem=10000]' "./blastn -db $db -query $f/contigs.fa -gapopen 4 -gapextend 2 -out $out$contig_file_name\".out\" -outfmt 5"
    bsub -o /nfs/ma/home/shyama/outputs/blastx_job.out -M 10000 -R 'rusage[mem=10000]' "./blastx -db $db -query $f/contigs.fa -gapopen 6 -gapextend 2 -out $out$contig_file_name\".out\" -outfmt 5"
    fi
done

