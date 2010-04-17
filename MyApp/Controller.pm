package MyApp::Controller;
use strict;

sub new {
    my $class = shift;
    bless {}, $class;
}

sub handle_request {
    my $self = shift;

    return ('text/html', undef);
}

1;

__END__