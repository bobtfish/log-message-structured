use strict;
package Log::Message::Structured::Event::ScriptRun;
use Moose;
use MooseX::Types::Moose qw/ Str Int /;
use namespace::clean -except => 'meta';

has script_name => (
    is => 'ro',
    isa => Str,
    default => sub { $0 },
);

my $starttime = time();
has time => (
    is => 'ro',
    isa => Int,
    default => sub { time() - $starttime },
);

has user_name => (
    is => 'ro',
    isa => Str,
    default => sub { $^O eq 'MSWin32' ? Win32::LoginName() : scalar getpwuid($<) }
);

with qw( Log::Message::Structured
         Log::Message::Structured::Component::Date
         Log::Message::Structured::Component::Hostname
      );
with 'Log::Message::Structured::Stringify::Sprintf' => {
    format_string => q{Script %s run on %s for %ss by %s},
    attributes => [qw/ script_name hostname time user_name/],
};

=head1 NAME

Log::Message::Structured::Event::ScriptRun

=head1 DESCRIPTION

Some Event.

=cut

__PACKAGE__->meta->make_immutable;
1;

