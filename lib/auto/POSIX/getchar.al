# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 502 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/getchar.al)"
sub getchar {
    usage "getchar()" if @_ != 0;
    CORE::getc(STDIN);
}

# end of POSIX::getchar
1;
