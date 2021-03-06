
use strict;
use warnings;

package Perl::Tidy::Sweetened::Pluggable;

sub filters { return ( $_[0]->{filters} ||= [] ) }

sub add_filter {
    my $self = shift;
    push @{ $self->filters }, @_;
}

sub new {
    my ( $class, %args ) = @_;
    return bless { %args }, $class;
}

sub prefilter {
    my ( $self, $code ) = @_;
    for my $filter ( @{ $self->filters } ){
        $code = $filter->prefilter( $code );
    }
    return $code;
}

sub postfilter {
    my ( $self, $code ) = @_;
    for my $filter ( @{ $self->filters } ) {
        $code = $filter->postfilter( $code );
    }
    return $code;
}

1;
