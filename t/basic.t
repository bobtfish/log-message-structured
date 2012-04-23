use strict;
use warnings;
use Test::More;

{
    package TestEvent;
    use Moose;
    with qw(Log::Message::Structured);
    with qw(Log::Message::Structured::Component::Date);
    with qw(Log::Message::Structured::Component::Hostname);

    sub stringify { 'MOO' }

    has foo => ( is => 'ro', required => 1);
}

my $e = TestEvent->new(foo => 2);
ok $e;
is $e.'', 'MOO';
foreach my $meth (qw/ freeze thaw pack unpack epochtime date hostname /) {
    ok $e->can($meth);
}

my $f = TestEvent->thaw($e->freeze);
is_deeply $f, $e;

done_testing;
