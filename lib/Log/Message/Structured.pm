package Log::Message::Structured;
use MooseX::Role::WithOverloading;
use MooseX::Storage;
use DateTime;
use MooseX::Types::ISO8601 qw/ ISO8601DateTimeStr /;
use Sys::Hostname ();
use namespace::clean -except => 'meta';

use overload
    q{""}    => 'stringify',
    fallback => 1;

with Storage('format' => 'JSON');

has date => (
    is => 'ro',
    isa => ISO8601DateTimeStr,
    default => sub { DateTime->now },
    coerce => 1,
);

has hostname => (
    is => 'ro',
    default => sub { Sys::Hostname::hostname() },
);

requires 'stringify';

1;

__END__

=pod

=head1 NAME

Log::Message::Structured - Simple structured log messages

=head1 SYNOPSIS

    package My::Log::Event;
    use Moose;
    use namespace::autoclean;

    with 'Log::Message::Structured';

    has foo => ( is => 'ro', required => 1 );

    sub as_string { shift->freeze }

    ... elsewhere ...

    use aliased 'My::Log::Event';

    $logger->log(message => Event->new( foo => "bar" ));
    # Logs:
    XXXX FIXME XXXXX

=head1 DESCRIPTION

FIXME

=head1 AUTHOR AND COPYRIGHT

Tomas Doran C<< <bobtfish@bobtfish.net> >>.

=head1 LICENSE

Licensed under the same terms as perl itself.

=cut

