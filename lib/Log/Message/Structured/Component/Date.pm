package Log::Message::Structured::Component::Date;
use Moose::Role;
use namespace::autoclean;

use DateTime;
use MooseX::Types::ISO8601 qw/ ISO8601DateTimeStr /;

my $GETOPT = do { local $@; eval { require MooseX::Getopt; 1 } };

has date => (
    is => 'ro',
    isa => ISO8601DateTimeStr,
    lazy => 1,
    default => sub { DateTime->from_epoch(epoch => shift()->epochtime) },
    coerce => 1,
    $GETOPT ? ( traits => [qw/ NoGetopt /] ) : (),
);

after BUILD => sub { shift()->date };

requires 'epochtime';

1;

__END__

=pod

=head1 NAME

Log::Message::Structured::Component::Date

=head1 SYNOPSIS

    package MyLogEvent;
    use Moose;
    use namespace::autoclean;

    with qw/
        Log::Message::Structured
    /;
    # Components must be consumed seperately
    with qw/
        Log::Message::Structured::Component::Date
    /;

    has foo => ( is => 'ro', required => 1 );

    ... elsewhere ...

    use aliased 'My::Log::Event';

    $logger->log(message => Event->new( foo => "bar" ));
    # Logs:
    {"__CLASS__":"MyLogEvent","foo":1,"date":"2010-03-28T23:15:52Z"}

=head1 DESCRIPTION

Provides a C<'date'> attribute to the consuming class ( probably
L<Log::Message::Structured>), representing the epoch time in ISO8601.

Requires the C<epochtime> attribute (L<Log::Message::Structured> provides it).

=head1 METHODS

=head2 BUILD

The BUILD method is wrapped to make sure the date is inflated at
construction time.

=head1 ATTRIBUTES

=head1 date

The date and time on which the event occured, as an ISO8601 date time string
(from L<MooseX::Types::ISO8601>). Defaults to the time the object is
constructed.

=head1 AUTHOR AND COPYRIGHT

Damien Krotkine (dams) C<< <dams@cpan.org> >>.

=head1 LICENSE

Licensed under the same terms as perl itself.

=cut
