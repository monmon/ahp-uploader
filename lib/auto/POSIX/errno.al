# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 308 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/errno.al)"
sub errno {
    usage "errno()" if @_ != 0;
    $! + 0;
}

# end of POSIX::errno
1;
