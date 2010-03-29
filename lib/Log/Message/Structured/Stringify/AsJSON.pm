package Log::Message::Structured::Stringify::AsJSON;
use Moose::Role;
use namespace::autoclean;

requires 'freeze';

sub stringify { shift->freeze }

1;

__END__

=pod

=head1 NAME

Log::Message::Structured::Stringify::AsJSON - JSON log lines

=head1 SYNOPSIS

    package MyLogEvent;
    use Moose;
    use namespace::autoclean;

    # Note: you MUST compose these together as they depend on methods in each other
    with qw/
        Log::Message::Structured
        Log::Message::Structured::Stringify::AsJSON
    /;

    has foo => ( is => 'ro', required => 1 );

    ... elsewhere ...

    use aliased 'My::Log::Event';

    $logger->log(message => Event->new( foo => "bar" ));
    # Logs:
    {"__CLASS__":"MyLogEvent","foo":1,"date":"2010-03-28T23:15:52Z","hostname":"mymachine.domain"}

=head1 DESCRIPTION

Implelements the C<stringify> method required by L<Log::Message::Structured>, by delegateing to
the C<freeze> method provided by L<Log::Message::Structured>, and thus returning a JSON string.

=head1 METHODS

=head2 stringify

Calls the freeze method (provided by L<Log::Message::Structured> to return JSON.

=head1 AUTHOR AND COPYRIGHT

Tomas Doran (t0m) C<< <bobtfish@bobtfish.net> >>.

=head1 LICENSE

Licensed under the same terms as perl itself.

=cut
