# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 736 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/strstr.al)"
sub strstr {
    usage "strstr(big, little)" if @_ != 2;
    CORE::index($_[0], $_[1]);
}

# end of POSIX::strstr
1;
