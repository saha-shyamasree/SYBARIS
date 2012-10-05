#!/usr/bin/perl

open FQ1, "gunzip -c $ARGV[0] |" or die $!;
open FQ2, "gunzip -c $ARGV[1] |" or die $!;

open BR1, "| gzip -c > bad/$ARGV[0]" or die $!;
open BR2, "| gzip -c > bad/$ARGV[1]" or die $!;

open GR1, "| gzip -c > good/$ARGV[0]" or die $1;
open GR2, "| gzip -c > good/$ARGV[1]" or die $1;


my $f1 = <FQ1>;
my $f2 = <FQ2>;
my $i = 0;
my $b = 0;

while(++$i) {
	($f1, $read1) = get_next_read($f1, FQ1);
	($f2, $read2) = get_next_read($f2, FQ2);

	eval {
		die "Bad read\n  $read1->{id}  $read2->{id}" if $read1->{bad} or $read2->{bad};
		die "Next read ids don't match\n  $f1  $f2" if not substr($f1, 0, -2) eq substr($f2, 0, -2);
		check_that_read_ids_match($read1, $read2);
		check_that_read_lengths_match($read1, $read2);
		check_that_qual_lengths_match($read1, $read2);

		check_that_read_lengths_equal_qual_lengths($read1);
		check_that_read_lengths_equal_qual_lengths($read2);

		check_that_only_valid_characters_present_in_read_seq($read1);
		check_that_only_valid_characters_present_in_read_seq($read2);

		print_read(GR1, $read1);
		print_read(GR2, $read2);
		1;
	} or do {
		warn "ERROR: $@\n";
		print_read(BR1, $read1);
		print_read(BR2, $read2);
		$b++;
	};

	warn "Processed $i reads ($b bad)\n" if 0 == $i % 10000;
	last if $f1 eq "" or $f2 eq "";
}

sub print_read {
	my ($fh, $r) = @_;

	print $fh $r->{id};
	print $fh $r->{seq};
	print $fh "+\n";
	print $fh $r->{qual};
}

sub get_next_read {
	my ($id, $fh) = @_;
	
	my $read = {};
	$read->{id}   = $id;

	my $plus_seen = 0;
        my $nid = "";
	my $c = 0;

	while (!eof($fh)) {
		my $L = <$fh>;
		$c++;
		$nid = $L and last if $L =~ m/^\@HWI.*\/[12]$/;
		$plus_seen = 1 and next if $L =~ /^\+$/;
		$read->{seq}  .= $L if not $plus_seen;
		$read->{qual} .= $L if $plus_seen;
	}

	$c++ if eof($fh);
	$read->{bad} = $c if $c != 4;

	return ($nid, $read);
}

sub check_that_qual_lengths_match {
	my ($r1, $r2) = @_;

	die "Qual lengths different" if
       		length($r1->{qual}) != length($r2->{qual});

}

sub check_that_read_lengths_match {
	my ($r1, $r2) = @_;

	die "Read lengths different" if
       		length($r1->{seq}) != length($r2->{seq});
}

sub check_that_read_ids_match {
	my ($r1, $r2) = @_;

	my $s1 = substr $r1->{id}, 0, -2;
	my $s2 = substr $r2->{id}, 0, -2;

	die "Read IDs don't match: \n  " . $read1->{id} . "-\n  " . $read2->{id} . "-"
		if not $s1 eq $s2;
}

sub check_that_read_lengths_equal_qual_lengths {
	my $read = shift;

	die "Read length is not equal to qual length" if length($read->{seq}) != length($read->{qual});
}

sub check_that_only_valid_characters_present_in_read_seq {
	my $read = shift;

	die "Invalid character in sequence" if $read->{seq} !~ /^[ATCGN]+$/;
}
