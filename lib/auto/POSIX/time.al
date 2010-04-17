# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 794 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/time.al)"
sub time {
    usage "time()" if @_ != 0;
    CORE::time;
}

# end of POSIX::time
1;
