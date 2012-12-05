package Log::Any::Adapter::Core::Patch::UseDataDump;

use 5.010001;
use strict;
no warnings;
use Log::Any; # required prior to loading Log::Any::Adapter::Core

use Module::Patch 0.12 qw();
use base qw(Module::Patch);

use Data::Dump qw(dump);

# VERSION

our %config;

my $_dump_one_line = sub {
    my ($value) = @_;

    return dump($value);
};

sub patch_data {
    return {
        v => 3,
        patches => [
            {
                action      => 'replace',
                mod_version => qr/^0\.\d+$/,
                sub_name    => '_dump_one_line',
                code        => $_dump_one_line,
            },
        ],
    };
}

1;
# ABSTRACT: Use Data::Dump

=for Pod::Coverage ^(patch_data)$

=head1 SYNOPSIS

 use Log::Any '$log';
 use Log::Any::DD; # shortcut for Log::Any::Adapter::Core::Patch::UseDataDump;

 $log->debug("See this data structure: %s", $some_data);


=head1 DESCRIPTION

Log::Any dumps data structures using L<Data::Dumper> with settings: Indent=0.
This is rather hard to read. This patch replaces dumping with using
L<Data::Dump> which has nicer output.


=head1 FAQ


=head1 SEE ALSO

L<Log::Any::Adapter::Core::Patch::SetDumperIndent>

=cut
