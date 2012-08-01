
all_file=`ls /nfs/ma/home/shyama/DATA/SYBARIS/database/Fungi_Uniprot_Programmatical_complete/*.fasta`
./makeblastdb -in "\'".$all_file."\'" -dbtype 'prot' -out /nfs/ma/home/shyama/DATA/SYBARIS/database/Fungi_Uniprot_Programmatical_complete/BLAST_DB/fungi_complete