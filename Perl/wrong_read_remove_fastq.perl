#!/usr/bin/perl
#
use strict "vars";

sub writeRead
{
	my $file_handler=shift;
	my $hash=shift;
	#print "in write function";
	for(my $i=1;$i<=scalar(keys %$hash);$i++)
	{
		print $file_handler $hash->{$i}."\n";
	}

}
sub printRead
{
	my $hash=shift;
	for(my $i=1;$i<=scalar(keys(%$hash));$i++)
	{
		print "\n$i: ".$hash->{$i};
	}
}
sub checkformat
{
	my $hash=shift;
	my $fastq_format_size=shift;
	my $hash_size=scalar keys(%$hash);
	if($hash_size!=$fastq_format_size)
	{
		return 0;
	}
	else
	{
		##standard fastq fortmat should have 4 lines per read, 1st line machine id starts with @, second line base, third line starts with + followed by optional id info, and fouth line is quality value of each base.
		if($hash->{1}=~m/^\@HWI.*\/[12]$/)
		{
			if($hash->{2}=~m/^([ATCGN])+$/)
			{
				my $seq_length=length($hash->{2});
				if($hash->{3}=~m/^+/)
				{
					if(length($hash->{4})==$seq_length)
					{
						return 1;	
					}
					else
					{
						return 0;
					}
				}
				else
				{
					return 0;
				}
			}
			else
			{
				return 0;
			}
		}
		else
		{
			return 0;
		}
	}
}
sub startOfReadCheck
{
	my $currentLine=shift;
	
}

sub formatFastQ{        
        my ( $fastQFileName1, $newFastQFileName1, $fastQFileName2, $newFastQFileName2 ) = @_;
        my @fastQBuffer;
        my $currentLine;
        my $lineCount;

	my $fastq_read_size=4; 
        open( FASTQ1, "<" , $fastQFileName1 ) or die("FastQ File Can not be found :: $fastQFileName1");
        open( NEWFASTQ1, ">" , $newFastQFileName1 ) or die("Can not create new newFastQ $newFastQFileName1");
	open( BR1, ">" , $newFastQFileName1.bad.fastq ) or die("Can not create Bad Read $newFastQFileName1.bad.fastq");

	open( FASTQ2, "<" , $fastQFileName2 ) or die("FastQ File Can not be found :: $fastQFileName2");
        open( NEWFASTQ2, ">" , $newFastQFileName2 ) or die("Can not create new newFastQ $newFastQFileName2");
	open( BR2, ">" , $newFastQFileName2.bad.fastq ) or die("Can not create Bad Read $newFastQFileName2.bad.fastq");
        my $start_flag=0;
	my %hash1=();
	my %hash2=();

	my $wrong_read_count=0;
	my $read_line=0;
        while((my $currentLine1=<FASTQ1>) and (my $currentLine2=<FASTQ2>)){
		chomp($currentLine1);
		chomp($currentLine2);
		
                if($currentLine1=~m/^\@HWI/ and $currentLine2=~m/^\@HWI/)
                {
			#print "\n New read";
			$read_line=1;
			if(scalar(keys(%hash1))>0 and scalar(keys(%hash2))>0)
			{
				my $ret_value1=checkformat(\%hash1,$fastq_read_size);
				my $ret_value2=checkformat(\%hash2,$fastq_read_size);
				#print "\n Retuen value $ret_value";
				if($ret_value1==1 and $ret_value2==1)
				{
					writeRead(NEWFASTQ1,\%hash1);
					writeRead(NEWFASTQ2,\%hash2);
				}
				else
				{
					if($ret_value1==0 and $ret_value2==0)
					{
						print "\n Wrong Read in Both Pair:1. is ".$hash1{1}."\t2. is".$hash2{1};
					}
					elsif($ret_value1==0)
					{
						print "\n Wrong Read in 1stPair:1. is ".$hash1{1};
					}
					else
					{
						print "\n Wrong Read in 2nd Pair:2. is ".$hash2{1};
					}
					$wrong_read_count=$wrong_read_count+1;
				}
				%hash1=();
				%hash2=();
			}
			else
			{
				if(scalar(keys(%hash1))>0 or scalar(keys(%hash2))>0)
				{
					print ("\nWARNING:Both pair was not read simultaneously");
				}
				#print "\n First read:$currentLine1,\t $currentLine2";
				%hash1=();
				%hash2=();
			}
			#printRead(\%hash);
			#print "\nRead line:$read_line";
			$hash1{$read_line}=$currentLine1;
			$hash2{$read_line}=$currentLine2;
		}
		else
		{
			if($currentLine1=~m/^\@HWI/ or $currentLine2=~m/^\@HWI/)
                        {
                                print("\nWARNING:paired reads do not have similar reads,start different, 1:$currentLine1....2:$currentLine2");
				if($currentLine1=~m/^\@HWI/)
				{
					$hash2{$read_line}=$currentLine2;
					while((my $currentLine2=<FASTQ2>)=!m/^\@HWI/)
					{
						$read_line=$read_line+1;
						$hash2{$read_line}=$currentLine2;
					}
				}
				elsif($currentLine2=~m/^\@HWI/)
				{
					$hash1{$read_line}=$currentLine1;
                                        while((my $currentLine1=<FASTQ1>)=!m/^\@HWI/)
                                        {
                                                $read_line=$read_line+1;
                                                $hash1{$read_line}=$currentLine1;
                                        }
				}
				print "\n Different Number of lines in two pairs";
				
				writeRead(BR1,\%hash1);
				writeRead(BR2,\%hash2);
				%hash1=();
				%hash2=();
				$read_line=1;
				$hash1{$read_line}=$currentLine1;
				$hash2{$read_line}=$currentLine2;
                        }
			else
			{
				$read_line=$read_line+1;
				#print "\n read line:$read_line";
				$hash1{$read_line}=$currentLine1;
				$hash2{$read_line}=$currentLine2;
			}
		}
        }
        close(FASTQ1);
        close(NEWFASTQ1);
	close(FASTQ2);
	close(NEWFASTQ2);

	print "\n\n\n TOTAL WRONG READ: $wrong_read_count \n";
}
my $in1=shift;
my $out1=shift;
my $in2=shift;
my $out2=shift;
formatFastQ($in1,$out1,$in2,$out2);
