package PERLANCAR::Exporter::Lite;

# DATE
# VERSION

# Be lean.
#use strict;
#use warnings;

sub import {
    my $pkg0 = shift;
    if (@_ && $_[0] eq 'import') {
        my $caller0 = caller;
        *{"$caller0\::import"} = sub {
            my $pkg = shift;
            my $caller = caller;
            my @imp = @_ ? @_ : @{__PACKAGE__.'::EXPORT'};
            for my $imp (@imp) {
                if (grep {$_ eq $imp} (@{__PACKAGE__.'::EXPORT'},
                                       @{__PACKAGE__.'::EXPORT_OK'})) {
                    *{"$caller\::$imp"} = \&{$imp};
                } else {
                    die "$imp is not exported by ".__PACKAGE__;
                }
            }
        };
    }
}

1;
# ABSTRACT: A stripped down Exporter

=head1 SYNOPSIS

In F<lib/YourModule.pm>:

 package YourModule;
 use PERLANCAR::Exporter::Lite qw(import);
 our @EXPORT = qw(...);
 our @EXPORT_OK = qw(...);


=head1 DESCRIPTION

This is a stripped down exporter module, to achieve the smallest startup
overhead (see L<Bencher::Scenario::Exporters::Startup> for benchmark). This is
what I think L<Exporter::Lite> should be.

This module offers only some features of L<Exporter>: default exports via
C<@EXPORT> and optional exports via C<@EXPORT_OK>. You can only use this
exporter by importing its C<import> and not by subclassing. There is no support
for export tags, C<export_to_level>, etc.


=head1 SEE ALSO

L<Exporter>
