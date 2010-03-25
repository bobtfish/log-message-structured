package Log::Message::Structured::Stringify::AsJSON;
use Moose::Role;
use namespace::autoclean;

requires 'freeze';

sub as_string { shift->freeze }

1;

