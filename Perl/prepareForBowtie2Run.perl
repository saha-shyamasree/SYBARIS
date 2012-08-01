use File::Basename;

sub job_run
{
    my $path_bowtie2=shift;
    my $f=shift;
    my $flowcell_base=shift;
    my $exception_file=shift;
    
    my $index="";
    my $char="_";
    my $out="/nfs/ma/home/shyama/outputs/SYBARIS/Bowtie2/";
    
    #print "\n\n\n".$exception_file;
    print "\n in function";
    if($f=~m/1\.fastq/)
    #if($f=~m/1\.fastq\.gz/)
    #if($f=~m/1\.fastq\.gz/)
     {
        if($f=~m/$exception_file/)
        {
            print "\n\n this is exception file";
            if($flowcell_base=~m/B07BNABXX/)
            {
                $index="/nfs/ma/home/shyama/DATA/SYBARIS/Index/F8226/Aspergillus_Nidulans";
            }
            elsif($flowcell_base=~m/C023MABXX/)
            {
                $index="/nfs/ma/home/shyama/DATA/SYBARIS/Index/F8226/Aspergillus_Nidulans";
            }
            elsif($flowcell_base=~m/D0ACKACXX/)
            {
                $index="/nfs/ma/home/shyama/DATA/SYBARIS/Index/F4S9A/Neosartorya_fischeri";
            }
        }
        else
        {
            $index="/nfs/ma/home/shyama/DATA/SYBARIS/Index/AF293/AF293";
        }
        my $last_ind=rindex($f,$char);
        my $base=substr($f,0,$last_ind);
	print "\nf in func $f";
	#my $base=substr($f,0,$last_ind-10);
        print "\n base $base";
	my $last_ind_slash=rindex($f,"/");
        my $name=substr($f,$last_ind_slash+1,$last_ind-$last_ind_slash-1);
       # my $command="bsub -o /nfs/ma/home/shyama/outputs/bowtie2_job_beta6_read_removed.out -M 10000 -R \'rusage[mem=10000]\' \"".$path_bowtie2." -x ".$index." -1 ".$base."_1.fastq -2 ".$base."_2.fastq --un-gz ".$out.$flowcell_base."/un-aligned/".$name.".fastq.gz -S ".$out.$flowcell_base."/sam/".$name.".sam\"";
        my $command="bsub -o /nfs/ma/home/shyama/outputs/bowtie2_job_beta6_wrong_read.out -M 10000 -R \'rusage[mem=10000]\' \"".$path_bowtie2." -x ".$index." -1 ".$base."_1.fastq.gz -2 ".$base."_2.fastq.gz --un-gz ".$out.$flowcell_base."/un-aligned/".$name.".fastq.gz -S ".$out.$flowcell_base."/sam/".$name.".sam\"";
	#print "\nCommand:".$command;
        system($command);
        #last;
    }
}
my $info_file="/nfs/ma/home/shyama/docs/fungi_samples.csv";
my @D0_files=("/nfs/ma/home/shyama/DATA/SYBARIS/D0ACKACXX_1_3/corrected/D0ACKACXX_1_3_1.fastq.gz","/nfs/ma/home/shyama/DATA/SYBARIS/D0ACKACXX_1_3/corrected/D0ACKACXX_1_3_2.fastq.gz","/nfs/ma/home/shyama/DATA/SYBARIS/D0ACKACXX_1_5/corrected/D0ACKACXX_1_5_1.fastq.gz","/nfs/ma/home/shyama/DATA/SYBARIS/D0ACKACXX_1_5/corrected/D0ACKACXX_1_5_2.fastq.gz","/nfs/ma/home/shyama/DATA/SYBARIS/D0ACKACXX_1_2/corrected/D0ACKACXX_1_2_1.fastq.gz","/nfs/ma/home/shyama/DATA/SYBARIS/D0ACKACXX_1_2/corrected/D0ACKACXX_1_2_2.fastq.gz","/nfs/ma/home/shyama/DATA/SYBARIS/D0ACKACXX_1_7/corrected/D0ACKACXX_1_7_1.fastq.gz","/nfs/ma/home/shyama/DATA/SYBARIS/D0ACKACXX_1_7/corrected/D0ACKACXX_1_7_2.fastq.gz");#glob "/nfs/ftp/private/sybaris/k6dXa23pq/Sybaris_01/*.fastq*";
#my @D0_files=glob "/nfs/ftp/private/sybaris/k6dXa23pq/Sybaris_01/*.fastq*";
#my @B0_files=glob "/nfs/ftp/private/sybaris/k6dXa23pq/B07BNABXX/*.fastq*";
#my @C0_files=glob "/nfs/ftp/private/sybaris/k6dXa23pq/C023MABXX/*.fastq*";

my $path_bowtie2="/nfs/ma/home/shyama/installed_soft/bowtie2-2.0.0-beta6/bowtie2";
#my $path_bowtie2="/nfs/ma/home/shyama/installed_soft/bowtie2-2.0.0-beta5/bowtie2";
#print "\n 1. ".$D0_files[0];
open(READ,"<",$info_file) or die("Could not open ".$info_file);
my @files=<READ>;

my @suffixlist="";

#foreach my $f (@B0_files)
#{
#    print "\n".$f;
#    my $basename = basename($f,@suffixlist);
#    print "\nbase Name:".$basename;
#    if ( grep( /$basename/, @files ) )
#    {
#        print "\nin List\n";
#        job_run($path_bowtie2,$f,"B07BNABXX","B07BNABXX_2_4");
#    }
#    else
#    {
#        print "\nNot in list\n";
#    }
#}

#foreach my $f (@C0_files)
#{
#    print "\n".$f;
#    my $basename = basename($f,@suffixlist);
#    print "\nbase Name:".$basename;
#    if ( grep( /$basename/, @files ) )
#    {
#        print "\nin List\n";
#        job_run($path_bowtie2,$f,"C023MABXX","C023MABXX_3_8");
#    }
#    else
#    {
#        print "\n\nNot in list";
#    }
#}

my @sub_list_bet5=("D0ACKACXX_1_2_1.fastq","D0ACKACXX_1_3_1.fastq","D0ACKACXX_1_5_1.fastq","D0ACKACXX_1_7_1.fastq");
foreach my $f (@D0_files)
{
#    print "\n".$f;
    my $basename = basename($f,@suffixlist);
#   print "\nbase Name:".$basename;
    #if ( grep( /$basename/, @files ) )
    #{
        print "\nin List\n";
        #if ( grep( /$basename/, @sub_list_bet5 ) )
        #{
            print "\n did not run with beta6";
            job_run($path_bowtie2,$f,"D0ACKACXX","D0ACKACXX_1_12");
        #}
        #else
        #{
            #print "\n ran with beta6";
        #}
   # }
   # else
   # {
   #     print "\n\nNot in list";
   # }
}
