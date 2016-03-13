package PERLANCAR::Exporter::Lite;

# DATE
# VERSION

# Be lean.
#use strict;
#use warnings;

sub import {
    my $pkg0 = shift;
    if (@_ && $_[0] eq 'import') {
        my $exporter = caller;
        *{"$exporter\::import"} = sub {
            my $pkg = shift;
            my $caller = caller;
            my @exp = @_ ? @_ : @{"$exporter\::EXPORT"};
            for my $exp (@exp) {
                unless (grep {$_ eq $exp} (@{"$exporter\::EXPORT"},
                                           @{"$exporter\::EXPORT_OK"})) {
                    die "$exp is not exported by $exporter";
                }
                *{"$caller\::$1"} =
                    $exp =~ /\A\$(.+)/ ? \${"$exporter\::$1"} :
                    $exp =~ /\A\@(.+)/ ? \@{"$exporter\::$1"} :
                    $exp =~ /\A\%(.+)/ ? \%{"$exporter\::$1"} :
                    $exp =~ /\A\*(.+)/ ?  *{"$exporter\::$1"} :
                    $exp =~ /\A&?(.+)/ ? \&{"$exporter\::$1"} :
                    die "Invalid export '$exp'";
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
