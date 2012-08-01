
#this code has to be run from the directory where D0ACKACXX_1_*_*.fastq files lives.

mkdir D0ACKACXX_1_7
mkdir D0ACKACXX_1_2

cp D0ACKACXX_1_7_*.fastq D0ACKACXX_1_7/
cp cp D0ACKACXX_1_2_*.fastq D0ACKACXX_1_2/

cd D0ACKACXX_1_7/
split -l 700000 -a 4 -d D0ACKACXX_1_7_1.fastq D0ACKACXX_1_7_1
split -l 700000 -a 4 -d D0ACKACXX_1_7_2.fastq D0ACKACXX_1_7_2

file=`grep "HWI-ST539_84:1:1101:2332:6331#7" D0ACKACXX_1_7_10*`
echo $file
file=`grep "HWI-ST539_84:1:1101:2332:6331#7" D0ACKACXX_1_7_20*`
echo $file

cd ..
cd D0ACKACXX_1_2/
split -l 700000 -a 4 -d D0ACKACXX_1_2_1.fastq D0ACKACXX_1_2_1
split -l 700000 -a 4 -d D0ACKACXX_1_2_2.fastq D0ACKACXX_1_2_2

file=`grep "HWI-ST539_84:1:1101:2332:6331#7" D0ACKACXX_1_2_10*`
echo $file
file=`grep "HWI-ST539_84:1:1101:17024:59417#2" D0ACKACXX_1_2_20*`
echo $file

