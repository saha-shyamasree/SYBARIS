#!/usr/bin/perl

package VCFRecord;

sub new
{
    my $class = shift;
    my $self = {
        _feat=>shift,
        _pos=>shift,
        _id=>shift,
        _ref=>shift,
        _alt=>shift,
        _qual=>shift,
        _filter=>shift,
        _info=>shift,
        _format=>shift
    };
    bless $self, $class;
    return $self;
}

sub setFeat
{
    my ($self,$chr)=@_;
    $self->{_feat}=$chr if defined($chr);
}

sub setPOS
{
    my ($self,$pos)=@_;
    $self->{_pos}=$pos if defined($pos);
}

sub setID
{
    my ($self,$id)=@_;
    $self->{_id}=$id if defined($id);
}

sub setRef
{
    my ($self,$ref)=@_;
    $self->{_ref}=$ref if defined($ref);
}

sub setAlt
{
    my ($self,$alt)=@_;
    $self->{_alt}=$alt if defined($alt);
}

sub setQual
{
    my ($self,$qual)=@_;
    $self->{_qual}=$qual if defined($qual);
}

sub setFilter
{
    my ($self,$filter)=@_;
    $self->{_filter}=$filter if defined($filter);
}

sub setInfo
{
    my ($self,$info)=@_;
    $self->{_info}=$info if defined($info);
}

sub setFormat
{
    my ($self,$format)=@_;
    $self->{_format}=$format if defined($format);
}

sub getFeat {
    my( $self ) = @_;
    return $self->{_feat};
}

sub getPOS {
    my( $self ) = @_;
    return $self->{_pos};
}

sub getID {
    my( $self ) = @_;
    return $self->{_id};
}

sub getRef {
    my( $self ) = @_;
    return $self->{_ref};
}

sub getAlt {
    my( $self ) = @_;
    return $self->{_alt};
}

sub getQual {
    my( $self ) = @_;
    return $self->{_qual};
}

sub getFilter {
    my( $self ) = @_;
    return $self->{_filter};
}

sub getInfo {
    my( $self ) = @_;
    return $self->{_info};
}

sub getFormat {
    my( $self ) = @_;
    return $self->{_format};
}


sub printFeat {
    my( $self ) = @_;
    print $self->{_feat};
}

sub printPOS {
    my( $self ) = @_;
    print $self->{_pos};
}

sub printID {
    my( $self ) = @_;
    print $self->{_id};
}

sub printRef {
    my( $self ) = @_;
    print $self->{_ref};
}

sub printAlt {
    my( $self ) = @_;
    print $self->{_alt};
}

sub printQual {
    my( $self ) = @_;
    print $self->{_qual};
}

sub printFilter {
    my( $self ) = @_;
    print $self->{_filter};
}

sub printInfo {
    my( $self ) = @_;
    print $self->{_info};
}

sub printFormat {
    my( $self ) = @_;
    print $self->{_format};
}

sub printVCF
{
    my ($self)=@_;
    print "\nFeature:";
    $self->printFeat();
    print "\tPOS:";
    $self->printPOS();
    print "\tID:";
    $self->printID();
    print "\tRef:";
    $self->printRef();
    print "\tAlt:";
    $self->printAlt();
    print "\tQuality:";
    $self->printQual();
    print "\tFilter:";
    $self->printFilter();
    print "\tInfo:";
    $self->printInfo();
    print "\tFormat:";
    $self->printFormat();
}
1;