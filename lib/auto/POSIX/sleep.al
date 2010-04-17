# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 936 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/sleep.al)"
sub sleep {
    usage "sleep(seconds)" if @_ != 1;
    CORE::sleep($_[0]);
}

# end of POSIX::sleep
1;
