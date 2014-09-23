#use lib "/Volumes/ma-home/shyama/installed_soft/lib/perl5/";
#use lib "/Volumes/ma-home/shyama/code/SYBARIS/Perl/";
#use Bio::Seq;
#use GTF;
#use GTFParser;
#my $str="TTAATCCTGCCGATCGACCACCCGGGTCGTCGGATTCGTTGTCTCAGGGTTTCTTGCCTCAAGACTTACTTCAGAGCTCGAGCCCGAAGTGTCCGTACCTAAATCACGCAGCTGGATAGCCCCCGACATCTTGAACTGATCCTCGAATTCACCGGCCGCTTTGTCCTCCGGCGGCTCCTCGTCCACCGCATAGCGCCAGTGACCATCCGCGTTGAGGAACATCCGGAATCCGTACCGCTTGTTCAGCCGGTCCAGGTGAATCCGTCTCTGTATGCTTGTCCAAAAGTAGGTGCCGCGGAAATCCTCGAGCATGCGACTGTGAGCAATCCAGGGCATGACTGCACCAATGGACCGCGGCACGCGGGGACCCTTGAAGCGGCCCCGGCGCGTGCCAAAGACAATAAGAACGATCAACGTATCGAGGGCGATGATCATCAATGCAATAGCTAGAGAGGGGATTGACGGTTCCATGGTCCATGTGTCGTAGATCACCGTCGAGTTCGGAGCAGCCTGCGGTTTGTCCAACGGCTGTAGGTAAATCCCCCTCCAGATGGTAAAATAAGTGCTATAGACCCACTGATAGACGATTCTGGACATGTCCATCAGGTCATCAGGGTTTAGAGCCATAAACCCCGGATCTCGACGCCTGTACAAACGTGCAACTAGGAAACCGGCCCAGTCATACGACGTGATGTATGTCTTGCGATCATAAGTCGAATTGCTGATGTAGCTCTGCGGGATGGCGGCAAAGACCTTGTTGAACTGTCCCAGGCTGATGGTCGCATTGTCGTACATGGGGCCAGATGTGATGGCTGTACCGGCAATAGGGCTCAAATCTTGGATTTGGCCTTTCGTATCGAAAGTGATCGAGTAGTTTTCCAACTTGATTCTGGGTTCGCAGTGCAGAGCAATAGTGTTTTTGTCGGTTATGGGCGACCCGGCAGTGTAATTCCACCGACCCAGAACCACCACAGTGGATGTCTGACAATCATACGTGTCGTCTTCGGTAACCACAGGAGACAAAAAGTGAATGGAAAGTGTAATGTTCTCATGTGGATGCTGCAGCATGCTCATGTCGACTTTACAGTGCCTGCTGGGATCGTCAAATGTCTGATATTCCCAATAAGCAGATCCATTCTGGGGATTCACAACCAGACTATCAGCGATAGACAACTCTTCACATGCCAGGTCCGCTCCGATACCCAGCGTGTTGGCCCCGTACAGAGCATCAGAATCCGGATCCTTGATCGTGATGGGAACGAAAGAGCGGTTGGCACTCGTCCATGGGAGTATCGACACTCCGGTGGTGATACTGGTCTGGATGATGTCGTATTCAGTAAAGTCTGCCGCAAAGTCGGTTTGCTGAAAAACAGCACTGCTGTAGTTGGTGACCAGTGACGATGTAGGAAGAGAGGAGCTAGTCATCTGTTGTGTGAATAAGCCACCAGCAACGACGGTAAGAGCCGTGTTGGCAACACATGCTACTGATATCAGGAGCAACAAAATGTGACGGTGTCGTGCTGCTTTCACCAATACTGCCAACGGCGTCTGCGACGAGTAGTTCATTGACAATGAGTCCTCCGCCGTAGCCCTGCCCCGCTGAAGGTGCACCCAAGGTTCAAGGATGCTGACATTGCGGTGAATGGAGGTGCAGAGAGAACCAACGGCCGAAGCAACTATGGACGGCAAAACTGACAGAACAACTTGAAAGAAGCTCGAGTCCGACTGCGTGAGATGTCGAAACTTGCCATCCCGGGTCAGTGAGGCAACGACCAGGCTCATCGCTGTGATTACTGCGGCGAGCAAGAGAAATTCAATAATAAAGAAGGGAATGACGAGAAAGTGTGGCATCGGATCAGCACGCTTGCGCAGCTGCTGGTCTAACTGGATCGGAGAGCCGTCTGAGGTGACGATTGCGAGGCGTCTGCCATTTGGGCCCGGGCCAGGTTCCCAGCGCAACCAGCAATTCCGAAGAAGCCGGCGGAGTTGTCGCGTGGAATACTGATGAAACTCAAACCGAGGATCGGCGAGAATGTTGGAGGGTCCAAACAGGTCTGTCACAATGCTACACATGGCTGCCACAGAGCACGGGTCGCTTTGAAGCACGTTTTCCCGGTTTTTGTACACGTGCAACAGCCCTAAGGTGACAACGACGCCCAGACCAAGAATGACCTCGGACCATAAAGCTGCGAAATCGACCACCGCGAGTGTGACTTGCCGGGTGAGCCGCGTCGCCGGTACGACGGCTGGGGCTTCGTCAAGATTGAAGAGTCGTCCCATGGTAAGCAAAAAAGTCTGTTTAACGCCTCGCGTAACCTTGGATTCGAACTCTTCTTTTGTCATAACGTCTGACGAGTCCAGGACTACGACAGGCTCCAGATCACCTATTTCTTGACTGATAATGGGCAACTCCGTCACTTCGCGTTCGCCGCTGGTCTTGTTGATCCGAAAGAAGAGCATGTCGCTGGTATAGGGGGCTCTATGGGACAAGAAGCCCTGAAACTCGTCAATGTTGAACTGATCGTCGGTTAATACAGTGGTGGTGCCGGGGTGTACGTCCACTGATGTGATGGAGCTATTGGCATGAAGCTGGAGCTTTGCGTCGGCCTTGCGATAGTCGATATTGCAGGCAAAAAGGGTTGCCGAGGATGCGAAGGTGACGCCAGATAGTGACATGTCATCCGCATCGAGGTCCGTGGCGCGCGTAGCGTTGACACCAATGAGTATGCCGTAGAGATCAAACGGGTTGCAACTGTCGTAGAAGAATGACTGGGAAACATTGTCCGTCCAGACTGGCTCCCAGTAGCGGATCTGGACATAATCGCTCGAAGGGAAGAATATGTTGCTGTATTGGAAATCCAGGGTACACCGTTGATCCTGGCCTTGTTGCTGAAGCTGGACCCCCTTGACATTCCATGAGATGATCGGCAGTCCGTCCGTCGTCTCGTTTGCGAAAACTTCCAGGCTCTCATTCACCATAACATCCTGGCAAGAAAGCTCCGACCAGTATATCGTTTGGTTCAGTGTCCATACCGTGCTTTCTCGGAAGTCGTCCGTGGGAATTTCCACAGGGGCAACGGCGTACTTGGCAGAGCGAGTCTTCTGAAAGGGACTGCCTGCCGAGAGCGTCGAAAAGTCCCAATTGTTCTTTTCCTGTGCGACAATCCACCGAGCCTGGCTATCGAGGTCCACAAGATTCGGCCATGTTCGCATGGTTTCGTCGCTCAGGATGCTTATTTCCCTCAACTCAAACACCGCACTCTGCAGAGCGGGTAGGAAGATCCGCATCAACACTGTAAGAAGTGATACAAGCAATACGACCCAATGACCCCTCTTGGCCGAAGTAAGTGGGGTCAGAAAGGATTGGCCAAAATTGTAATTGATGAATAACGTTGTGGCTGGAGTGCCCTCGGGGCGAGAAAGTTGGAAATACGGCTCAAGTCGCAGGACGTCAAAGTCGATGAAAGACCAGGATGTGACGAGTGTCAGGGCAACGATAACAGGCACGTAGTTGTAGGCGAATGTGGCGGGGCTGGAAAGGTTGGTGGTATCCTGGTAGAAGACGAGGCCTCCATAGCGATCGGTATATCGACGGAGCGCCTCAAGCACCGCCAACATTATCAGCAT";
#$seq_obj = Bio::Seq->new(-seq => $str,-alphabet => 'dna' );
#$seq_comp=$seq_obj->revcom();
#print "\nComp seq\n".$seq_comp->seq();
#$seq_prot = $seq_comp->translate(-codontable_id => 4);
#print "\n\n".$seq_prot->seq();
#
#my @splitted = split(/(.{10})/,$str);
#
#foreach my $sp(@splitted)
#{
#    print "\n$sp";
#}

#my $GFFP=new GTFParser("/Volumes/ma-home/shyama/DATA/CAGEKID/gtf/GRC37_fordexseq.gtf");
#$GFFP->parse();
#my $exon=$GFFP->getNearestExon(11990,12007,"1");
#print "Attribute:".$exon->getAttribute();
#$GFFP->printGTF();

my $str1="IGV1R2";
my $str2="IGV16";
my @arr1=split(//,$str1);
my @arr2=split(//,$str2);

my @out = map { $arr1[$_] - $arr2[$_] } 0 .. $#arr1;

my $output=join(":",@out);
print $output;
#foreach my $ele(@out)
#{
#    print $ele."\n";
#}