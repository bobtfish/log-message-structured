use strict;
use warnings;
use Test::More;

{
    package TestEventSprintf;
    use Moose;
    with qw( Log::Message::Structured
             Log::Message::Structured::Stringify::AsJSON
          );
    with qw( Log::Message::Structured::Component::Date);

    has [qw/foo bar baz/] => ( is => 'ro', required => 1);
}

my $e = TestEventSprintf->new(foo => 2, bar => 3, baz => 4);
ok $e;

my $f = TestEventSprintf->thaw($e . '');
is_deeply $f, $e;

done_testing;
