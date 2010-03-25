package Log::Message::Structured::Stringify::Sprintf;
use MooseX::Role::Parameterized;
use Moose::Autobox;
use MooseX::Types::Moose qw/ ArrayRef /;
use MooseX::Types::Common::String qw/ NonEmptySimpleStr /;
use namespace::autoclean;

parameter format_string => (
    isa      => NonEmptySimpleStr,
    required => 1,
);

parameter attributes => (
    isa => ArrayRef[NonEmptySimpleStr],
    required => 1,
);

role {
    my $p = shift;

    my $format_string = $p->format_string;
    my @attributes = $p->attributes->flatten;

#   FIXME - Moose bug..
#    requires $_ for @attributes;

    method stringify => sub {
        my $self = shift;
        sprintf($format_string, map { $self->$_ } @attributes);
    };
};

1;

