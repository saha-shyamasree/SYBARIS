#!/usr/bin/perl

package NameMap;
use strict;
use warnings;
=prod
this class read 2 column file, 1st column should be file name, without extension, and second is sample name
=cut
sub new {
    my $class = shift;
    my $self = {
                _fileName => shift,
                _map_hash => {}
                };
    bless $self, $class;
    return $self;
}

sub read
{
    my ($self)=@_;
    open(READ,"<",$self->{_fileName}) or die("Could not open ".$self->{_fileName});
    
    while(<READ>)
    {
        chomp($_);
        my @array=split(/,/,$_);
        if($self->{_map_hash}->{$array[0]})
        {
            die("\nTwo file can not belong to same sample. Make Sure one sample correspondent to single file.\n");
        }
        else
        {
            $self->{_map_hash}->{$array[0]} = $array[1];
        }
    }
}

sub getMapHash
{
    my ($self)=@_;
    return $self->{_map_hash};
}
1;
