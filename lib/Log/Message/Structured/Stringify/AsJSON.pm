package Log::Message::Structured::Stringify::AsJSON;
use Moose::Role;
use namespace::autoclean;

sub as_string { shift->freeze }

1;

