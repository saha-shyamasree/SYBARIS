
for filename in *.sam
do
  bsub -o /nfs/ma/home/shyama/outputs/SYBARIS/Shell/line_count.txt "wc $filename | sed 's/\s+/ /g' | sed 's/^\s+//g' >/nfs/ma/home/shyama/outputs/SYBARIS/Shell/Line_Count/unmapped/$filename.txt"
done;