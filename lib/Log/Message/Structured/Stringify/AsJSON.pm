package Log::Message::Structured::Stringify::AsJSON;
use Moose::Role;
use namespace::autoclean;

requires 'freeze';

sub stringify { shift->freeze }

1;

