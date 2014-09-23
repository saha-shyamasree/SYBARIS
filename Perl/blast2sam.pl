#! /usr/bin/perl
# Victor Amin 2010

use strict;
use warnings;

use Getopt::Std;
$Getopt::Std::STANDARD_HELP_VERSION = 1;

my %options;
getopts('q:3nh', \%options);

if ($options{h} || !$options{q}) {Getopt::Std->version_mess(); HELP_MESSAGE(\*STDERR)}
sub HELP_MESSAGE {
	my $fh = shift;
	print $fh "\nThis program converts BLASTN raw output to SAM format. STDIN/STDOUT\n";
	print $fh "\tFLAGS:\n";
	print $fh "\t-n Do not calculate mapq, use 255. Closer to spec, a little less useful\n";
	print $fh "\t-3 The FASTQ quality scores are already in phred33 format and do not need to be converted (scores are converted from phred64 to phred33 by default, in accordance with the SAM spec and assuming reads from an Illumina pipeline)\n";
	print $fh "\tOPTIONS:\n";
	print $fh "\t-q <file> FASTQ file, must contain all reads in BLAST report [required]\n";
	print $fh "\nMapping qualities are estimated from evalues and should not be considered to be directly comparable to mapping qualities in other SAM outputs. According the the SAM spec, mapping quality should measure the probability that the mapping is wrong. This mapping quality, however, represents the number of times the alignment would be expected to occur by chance. The evalue is converted to the phred scale, then divided by 2 and bounded by 0 and 255 to maintain compatibility with SAM parsers. So, to get the evalue back: evalue = 10^(-mapq/5).\n";
	exit;
}

open FASTQ, $options{q} or die "Could not open FASTQ file: $!\n";

my $SEQ_MODE = 1;
my $QUAL_MODE = 2;
my $fqmode = 1;

my $fqident;
my $fqseq;
my $fqqual;

my $fqlines = 0;
my %fqseq;
my %fqqual;
while (<FASTQ>) {
    chomp;
    if (/^\@/ && $fqmode == $SEQ_MODE) {
		s/\@//;
		$fqident = $_;
    } elsif (/^\+/) {
		$fqmode = $QUAL_MODE;
    } elsif ($fqmode == $SEQ_MODE) {
		$fqseq .= $_;
		$fqlines++;
    } elsif ($fqmode == $QUAL_MODE) {
		$fqqual .= $_;
		$fqlines--;
		if ($fqlines == 0) {
			$fqmode = $SEQ_MODE;
			
			$fqseq{$fqident} = $fqseq;
			$fqqual{$fqident} = $fqqual;
			
			$fqseq = '';
			$fqqual = '';
		}
    } else {
		die "\nError reading file on line $..\n";
    }
}
close FASTQ;

my @buffer = ();
my $query_delim = "BLASTN 2";
while (<>) {
	chomp;
	# fill the buffer with hits from a single read, then parse the buffer
	if (/^$query_delim/ && $. > 1) {
		&parseBuffer(\@buffer, \%fqseq, \%fqqual);
	} else {push @buffer, $_}

}
&parseBuffer(\@buffer, \%fqseq, \%fqqual);

sub parseBuffer
{
	my ($buffer, $fqseq, $fqqual) = @_;

	# read until first hit
	my $splice = 0; # keeps track of how many lines of buffer have been read so they can be spliced out after loops
	my $query_id;

	for (@$buffer) {
		if (/^Query=\s+(.+)$/) {
			$query_id = $1;
		} elsif (/\*\*\*\sNo\shits\sfound\s\*\*\*/) {
			print "$query_id\t4\t*\t0\t0\t*\t*\t0\t0\t$fqseq{$query_id}\t$fqqual{$query_id}\n"; # see SAM spec
			@$buffer = ();
			return 0;
		} elsif (/^>/) {
			last; # Denotes start of hits
		} 
		$splice++;
	}
	if (!$query_id) {return 0}
	
	splice(@$buffer, 0, $splice);
	
	while (@$buffer) {
		$splice = 0;
		
		# read hit id and length
		my $subject_id;
		for (@$buffer) {
			if (/^>(.+)(\s|$)/) {
				$subject_id = (split(/\s/, $1))[0];
			} elsif (/^\s+Length\s=\s/) {
				last;
			} elsif (/^Lambda/) { # Denotes end of file, no more hits
				@$buffer = ();
				last;
			}
			$splice++;
		}
		splice(@$buffer, 0, $splice+1); 
		
		while (@$buffer && $splice != 0) {
			
			my %stats;
			my %alignments;
			# read stats
			$splice = &parseStatsBuffer($buffer, \%stats);
			splice(@$buffer, 0, $splice);
			
			# read alignment
			$splice = &parseAlignmentBuffer($buffer, \%alignments);
			splice(@$buffer, 0, $splice);
			
			my $flag = 0;
			my $strand = '+';
			if ($alignments{s_start} > $alignments{s_end}) {
				$flag = 16;
				$strand = '-';
				my $ss = $alignments{s_start};
				$alignments{s_start} = $alignments{s_end};
				$alignments{s_end} = $ss;
			}
			
			my $pos = $alignments{s_start};
			my $mapq = 255;
			if (!$options{n}) {
				my $evalue = &sci2dec($stats{evalue});
				$mapq = int(-5*(log($evalue)/log(10))); # ln(N)/ln(10) = log(10)
				if ($mapq > 255) {$mapq = 255}
				if ($mapq < 0) {$mapq = 0}
			}
			
			my @q = split(//, $alignments{query_seq});
			my @s = split(//, $alignments{subject_seq});
		
			# create the cigar string from the alignment
			my $cigmode = 'M';
			my $tempcig;
			my $cigar;
			for my $i (0..$#q) {
				if ($q[$i] eq '-') {
					if ($cigmode ne 'D') {
						$cigar .= "$tempcig$cigmode";
						$cigmode = 'D';
						$tempcig = 1;
					} else {$tempcig++}
				} elsif ($s[$i] eq '-') {
					if ($cigmode ne 'I') {
						$cigar .= "$tempcig$cigmode";
						$cigmode = 'I';
						$tempcig = 1;
					} else {$tempcig++}
				} else {
					if ($cigmode ne 'M') {
						$cigar .= "$tempcig$cigmode";
						$cigmode = 'M';
						$tempcig = 1;
					} else {$tempcig++}
				}
			}
			$cigar .= $tempcig.$cigmode;
			my $edit_distance = $stats{mismatches};
			
			my $qual = substr($fqqual{$query_id}, $alignments{q_start}-1, $alignments{q_end}-$alignments{q_start}+1);
			my $seq = substr($fqseq{$query_id}, $alignments{q_start}-1, $alignments{q_end}-$alignments{q_start}+1);
			
			if ($strand eq '-') {
				$qual = reverse $qual;
				$seq = &reverseComplement($seq);
			}
			
			if (!$options{3}) {	
				my @quality = split(//, $qual);
				$qual = "";
				foreach my $char (@quality) {
					my $phred_quality = ord($char) - 64;
					$qual .= chr($phred_quality + 33);
				}
			}
			
			print "$query_id\t$flag\t$subject_id\t$pos\t$mapq\t$cigar\t*\t0\t0\t$seq\t$qual\tNM:i:$edit_distance\n"; # see SAM spec
		}
	}
	@$buffer = ();
}

sub parseStatsBuffer
{
	my ($buffer, $stats) = @_;
	my $splice = 0;
	for (@$buffer) {
		if (/Score\s=\s(.+)\sbits\s\((.+)\)\,\sExpect\s=\s(.+)$/) {
			# Score = 89.7 bits (45), Expect = 4e-17
			$stats->{score} = $1;
			$stats->{evalue} = $3;
		} elsif (/Identities\s=\s(\d+)\/(\d+)/) {
			# Identities = 49/49 (100%)
			$stats->{mismatches} = $2 - $1;
		} elsif (/^Query:\s/) {last} # denotes start of alignment
		$splice++;
	}
	return $splice;
}

sub parseAlignmentBuffer
{
	my ($buffer, $alignments) = @_;
	my $splice = 0;
	
	for (@$buffer) {
		if (/^Query:\s+(\d+)\s+(.+)\s+(\d+)/) {
			# Query: 1        cagaaacggacacaacttgaatatgtttacatatatcgatatatatttt 49
			if (!$alignments->{q_start}) {$alignments->{q_start} = $1}
			$alignments->{query_seq} .= $2;
			if (!$alignments->{q_end} || $alignments->{q_end} < $3) {$alignments->{q_end} = $3}
		} elsif (/^Sbjct:\s+(\d+)\s+(.+)\s+(\d+)/) {
			# Sbjct: 11994016 cagaaacggacacaacttgaatatgtttacatatatcgatatatatttt 11993968
			if (!$alignments->{s_start}) {$alignments->{s_start} = $1}
			$alignments->{subject_seq} .= $2;
			if (!$alignments->{s_end} || $alignments->{s_end} < $3) {$alignments->{s_end} = $3}
		} elsif (/^\sScore\s=\s/) { # denotes start of new stats/alignment block
			return $splice;
		} elsif (/^>/) { # denotes start of new hit
			return 0;
		} elsif (/Database:\s/) { # denotes end of hits
			@$buffer = ();
			return 0;
		}
		$splice++;
	}
	return $splice;
}

sub reverseComplement {
	my $seq = shift;
	my $revcomp = reverse $seq;
	$revcomp =~ tr/ACGTacgt/TGCAtgca/;
	return $revcomp;
}

sub sci2dec {
	my $n = shift;
	return $n unless $n =~ /^(.*)e([-+]?)(.*)$/;
	my ($num, $sign, $exp) = ($1, $2, $3);
	my $sig = $sign eq '-' ? "." . ($exp - 1 + length $num) : '';
	return sprintf "%${sig}f", $n;
}
