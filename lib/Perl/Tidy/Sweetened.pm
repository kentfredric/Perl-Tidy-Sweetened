package Perl::Tidy::Sweetened;

# ABSTRACT: Tweaks to Perl::Tidy to support some syntactic sugar

use 5.010;
use strict;
use warnings;
use Perl::Tidy qw();

our $VERSION = '0.20';

use Perl::Tidy::Sweetened::Keyword::SubSignature;
use Perl::Tidy::Sweetened::Pluggable;

our $plugins = Perl::Tidy::Sweetened::Pluggable->new();
$plugins->add_filter(
    Perl::Tidy::Sweetened::Keyword::SubSignature->new(
        keyword => 'func',
        marker  => 'FUNC',
    )
);
$plugins->add_filter(
    Perl::Tidy::Sweetened::Keyword::SubSignature->new(
        keyword => 'method',
        marker  => 'METHOD',
    )
);

sub add_filter {
    shift;
    $plugins->add_filter(@_);
}

sub perltidy {
    return Perl::Tidy::perltidy(
        prefilter  => sub { $plugins->prefilter( $_[0] ) },
        postfilter => sub { $plugins->postfilter( $_[0] ) },
        @_
    );
}

1;

__END__

=pod

=head1 NAME

Perl::Tidy::Sweetened - Tweaks to Perl::Tidy to support some syntactic sugar

=head1 VERSION

version 0.19

=head1 DESCRIPTION

There are a number of modules on CPAN that allow users to write their classes
with a more "modern" syntax. These tools eliminate the need to shift off
C<$self>, can support type checking and offer other improvements.
Unfortunately, they can break the support tools that the Perl community has
come to rely on. This module attempts to work around those issues.

The module uses
L<Perl::Tidy>'s C<prefilter> and C<postfilter> hooks to support C<method> and
C<func> keywords, including the (possibly multi-line) parameter lists. This is
quite an ugly hack, but it is the recommended method of supporting these new
keywords (see the 2010-12-17 entry in the Perl::Tidy
L<CHANGES|https://metacpan.org/source/SHANCOCK/Perl-Tidy-20120714/CHANGES>
file). B<The resulting formatted code will leave the parameter lists untouched.>

C<Perl::Tidy::Sweetened> attempts to support the syntax outlined in:

=over

=item * Method::Signature::Simple

=item * MooseX::Method::Signatures

=item * MooseX::Declare

=back

=head1 SEE ALSO

L<Perl::Tidy>

The idea and much of original code taken from Jonathan Swartz'
L<blog|http://www.openswartz.com/2010/12/19/perltidy-and-method-happy-together/>.

=head1 BUGS

Please report any bugs or suggestions at
L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Perl-Tidy-Sweetened>

=head1 AUTHOR

Mark Grimes, E<lt>mgrimes@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Mark Grimes, E<lt>mgrimes@cpan.orgE<gt>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
