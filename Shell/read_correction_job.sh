
path="/nfs/ma/home/shyama/DATA/SYBARIS/D0ACKACXX_1_"
for i in "7" #"2" "3" "5" "7"
do
mkdir $path$i"/corrected/"
base=$path$i"/D0ACKACXX_1_"$i"_"
base_cor=$path$i"/corrected/"
	bsub -o /nfs/ma/home/shyama/outputs/SYBARIS/Perl/read_correction.txt -M 10000 -R 'rusage[mem=10000]' "perl /nfs/ma/home/shyama/code/SYBARIS/Perl/wrong_read_remove_fastq.perl $base\"1.fastq\" $base_cor\"D0ACKACXX_1_\"$i\"_1.fastq\" $base\"2.fastq\" $base_cor\"D0ACKACXX_1_\"$i\"_2.fastq\" > $base_cor\"log.txt\""
done
