# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 903 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/isatty.al)"
sub isatty {
    usage "isatty(filehandle)" if @_ != 1;
    -t $_[0];
}

# end of POSIX::isatty
1;
