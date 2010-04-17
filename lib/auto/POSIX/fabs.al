# NOTE: Derived from lib/SCCS/s.POSIX.pm.
# Changes made here will be lost when autosplit again.
# See AutoSplit.pm.
package POSIX;

#line 348 "lib/SCCS/s.POSIX.pm (autosplit into lib/auto/POSIX/fabs.al)"
sub fabs {
    usage "fabs(x)" if @_ != 1;
    CORE::abs($_[0]);
}

# end of POSIX::fabs
1;
