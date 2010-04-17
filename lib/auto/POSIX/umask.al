# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 769 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/umask.al)"
sub umask {
    usage "umask(mask)" if @_ != 1;
    CORE::umask($_[0]);
}

# end of POSIX::umask
1;
