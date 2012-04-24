package Log::Message::Structured;
use MooseX::Role::WithOverloading;
use MooseX::Storage;
use namespace::clean -except => 'meta';

our $VERSION = '0.006';
$VERSION = eval $VERSION;

use overload
    q{""}    => 'stringify',
    fallback => 1;

with Storage('format' => 'JSON');

my $GETOPT = do { local $@; eval { require MooseX::Getopt; 1 } };

has epochtime => (
    isa => 'Int',
    is => 'ro',
    default => sub { time() },
    $GETOPT ? ( traits => [qw/ NoGetopt /] ) : (),
);

sub BUILD {}

requires 'stringify';

1;

__END__

=pod

=head1 NAME

Log::Message::Structured - Simple structured log messages

=head1 SYNOPSIS

    package MyLogEvent;
    use Moose;
    use namespace::autoclean;

    # Note: you MUST implement a 'stringify' method, or compose a role
    #       that gives you a stringify method.
    with qw/
        Log::Message::Structured
        Log::Message::Structured::Stringify::AsJSON
    /;
    # Components must be consumed seperately
    with qw/
        Log::Message::Structured::Component::Date
        Log::Message::Structured::Component::Hostname
    /;

    has foo => ( is => 'ro', required => 1 );

    ... elsewhere ...

    use aliased 'My::Log::Event';

    $logger->log(message => Event->new( foo => "bar" ));
    # Logs:
    {"__CLASS__":"MyLogEvent","foo":1,"date":"2010-03-28T23:15:52Z","hostname":"mymachine.domain"}

=head1 DESCRIPTION

Logging lines to a file is a fairly useful and traditional way of recording what's going on in your application.

However, if you have another use for the same sort of data (for example, sending to another process via a
message queue, or storing in L<KiokuDB>), then you can be needlessly repeating your data marshalling.

Log::Message::Structured is a B<VERY VERY SIMPLE> set of roles to help you make small structured classes
which represent 'C<< something which happened >>', that you can then either pass around in your application,
log in a traditional manor as a log line, or serialize to JSON for transmission over the network.

=head1 COMPONENTS

The consuming class can include components, that will provide additional
attributes. Here is a list of the components included in the basic
distribution. More third party components may be available on CPAN.

=over

=item *

L<Log::Message::Structured::Component::Date>

=item *

L<Log::Message::Structured::Component::Hostname>

=back

=head1 ATTRIBUTES

The basic Log::Message::Structured role provides the following read only attributes:

=head1 epochtime

The date and time on which the event occurred, as an no of seconds since Jan 1st 1970 (i.e. the output of time())

=head1 METHODS

The only non-accessor methods provided are those composed from L<MooseX::Storage> related to serialization
and deserialization.

=head2 freeze

Return the instance as a JSON string.

=head2 thaw

Inflate an instance of the class from a JSON string.

=head2 pack

Return the instance data as a plain data structure (hashref).

=head2 pack

Inflate an instance from a plain data structure (hashref).

=head2 BUILD

An empty build method (which will be silently discarded if you have one
in your class) is provided, so that additional components can wrap it
(to farce lazy attributes to be built).

=head1 REQUIRED METHODS

=head2 stringify

You B<must> implement a stringify method, or compose a stringification role for all L<Log::Message::Structured>
events. This is so that events will always be meaningfully loggable be printing them to STDOUT or STDERR,
or logging them in a traditional way in a file.

=head1 A note about namespace::autoclean

L<namespace::autoclean> does not work correctly with roles that supply overloading. Therefore you should instead use:

    use namespace::clean -except => 'meta';

instead in all classes using L<Log::Message::Structured>.

=head1 SEE ALSO

=over

=item L<Log::Message::Structured::Stringify::Sprintf>

=item L<Log::Message::Structured::Stringify::JSON>

=back

=head1 AUTHOR AND COPYRIGHT

Tomas Doran (t0m) C<< <bobtfish@bobtfish.net> >>.

=head1 LICENSE

Licensed under the same terms as perl itself.

=cut

