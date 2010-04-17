package MyApp::Encrypt;
# http://www.futomi.com/lecture/htaccess/htpasswd.html

use strict;

sub passwd {
    my($pass, $salt) = @_;
    if (! $salt) {
        my @salt_set = ('a'..'z','A'..'Z','0'..'9','.','/');
    
        srand;
        my $idx1 = int(rand(63));
        my $idx2 = int(rand(63));
        my $salt = $salt_set[$idx1] . $salt_set[$idx2];
    }
    
    return crypt($pass, $salt);
}

1;

__END__
