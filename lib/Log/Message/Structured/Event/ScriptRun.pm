package Log::Message::Structured::Event::ScriptRun;
use Moose;
use MooseX::Types::Moose qw/ Str Int /;
use namespace::autoclean;

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

# FIXME - User running script?

with 'Log::Message::Structured::Stringify::Sprintf' => {
    format_string => q{Script %s run on %s for %ss},
    attributes => [qw/ script_name hostname time /],
};
with 'Log::Message::Structured';

__PACKAGE__->meta->make_immutable;

