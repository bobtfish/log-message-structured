use strict;
use warnings;
use Test::More;

{
    package TestEventSprintf;
    use Moose;
    with qw( Log::Message::Structured
             Log::Message::Structured::Component::Date
             Log::Message::Structured::Stringify::AsJSON );

    has [qw/foo bar baz/] => ( is => 'ro', required => 1);
}

my $e = TestEventSprintf->new(foo => 2, bar => 3, baz => 4);
ok $e;

like "$e", qr/{"epochtime":\d+,"bar":3,"baz":4,"date":"[^"]+","foo":2}/;

done_testing;
